import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'devices/device_catalog.g.dart';
import 'gateway_api.dart';
import 'platform/platform_io.dart';

/// High-level status of the panel, driving which UI is shown.
enum PanelStatus {
  /// No VM service connection.
  disconnected,

  /// Connected, but `ext.device_preview.getState` is not registered — the app
  /// does not use `DevicePreview`.
  noBinding,

  /// The binding is installed but simulation is disabled
  /// (`enabled: false` in the state shape, e.g. a profile/release build).
  disabled,

  /// The main isolate is paused — service extensions cannot be called.
  paused,

  /// Connected, extension registered, state loaded.
  ready,
}

/// Simulation JSON keys that describe screen metrics. Selecting a preset or
/// "Real device" replaces exactly this set, preserving all other overrides.
const List<String> kMetricSimulationKeys = <String>[
  'presetId',
  'orientation',
  'screenSize',
  'frame',
  'systemUi',
  'devicePixelRatio',
  'padding',
  'viewPadding',
  'systemGestureInsets',
  'displayFeatures',
];

/// The seven tri-state accessibility flags of the protocol, in display order.
const List<String> kAccessibilityFlags = <String>[
  'accessibleNavigation',
  'invertColors',
  'disableAnimations',
  'boldText',
  'reduceMotion',
  'highContrast',
  'onOffSwitchLabels',
];

/// Raw-JSON-backed view over one device: an entry of the generated
/// [kDeviceSpecs] catalog, or of `ext.device_preview.listPresets` for presets
/// the app registered itself.
///
/// The extension deliberately does not re-model the domain: unknown keys are
/// carried along untouched and every getter is null-tolerant.
@immutable
class PresetView {
  /// Wraps a raw `DevicePreset.toJson()` map.
  const PresetView(this.json);

  /// The raw preset JSON.
  final Map<String, Object?> json;

  /// Stable preset identifier (e.g. `apple-iphone-16-pro`).
  String get id => json['id'] as String? ?? '';

  /// Human readable name (e.g. `iPhone 16 Pro`).
  String get name => json['name'] as String? ?? id;

  /// Manufacturer (e.g. `Apple`), or an empty string when unspecified.
  String get brand => json['brand'] as String? ?? '';

  /// Screen outline and body artwork, when the device has a frame.
  Map<String, Object?>? get frame => _asMap(json['frame']);

  /// Decorative system UI (status bar, gesture pill), when the device has it.
  Map<String, Object?>? get systemUi => _asMap(json['systemUi']);

  /// Target platform name (e.g. `iOS`, `android`).
  String get platform => json['platform'] as String? ?? 'unknown';

  /// Device kind (`phone`, `tablet`, `foldable`, `desktop`).
  String get kind => json['kind'] as String? ?? 'phone';

  /// Logical portrait size as a `{width, height}` map.
  Map<String, Object?>? get portraitSize => _asMap(json['portraitSize']);

  /// Device pixel ratio.
  double? get devicePixelRatio => (json['devicePixelRatio'] as num?)?.toDouble();

  /// Portrait `MediaQuery.padding` as an insets map.
  Map<String, Object?>? get portraitPadding => _asMap(json['portraitPadding']);

  /// Portrait view padding; defaults to [portraitPadding] app-side when null.
  Map<String, Object?>? get portraitViewPadding =>
      _asMap(json['portraitViewPadding']);

  /// Landscape padding, when the preset provides one.
  Map<String, Object?>? get landscapePadding =>
      _asMap(json['landscapePadding']);

  /// Landscape view padding, when the preset provides one.
  Map<String, Object?>? get landscapeViewPadding =>
      _asMap(json['landscapeViewPadding']);

  /// System gesture insets map, when provided.
  Map<String, Object?>? get systemGestureInsets =>
      _asMap(json['systemGestureInsets']);

  /// Display features (foldables), when provided.
  List<Object?>? get displayFeatures => json['displayFeatures'] as List<Object?>?;
}

/// Raw-JSON-backed view over the protocol state shape (§4 of the design).
@immutable
class StateView {
  /// Wraps the raw state map returned by `getState`/`setSimulation`/`reset`.
  const StateView(this.json);

  /// The raw state JSON.
  final Map<String, Object?> json;

  /// Protocol version advertised by the app.
  int get protocolVersion => json['protocolVersion'] as int? ?? 0;

  /// Whether simulation is enabled in the inspected app.
  bool get enabled => json['enabled'] as bool? ?? false;

  /// The active simulation, or null when passing through.
  Map<String, Object?>? get simulation => _asMap(json['simulation']);

  /// Live real-device metrics.
  Map<String, Object?> get realDevice =>
      _asMap(json['realDevice']) ?? const <String, Object?>{};

  /// The current scale-to-fit mapping.
  Map<String, Object?> get fit =>
      _asMap(json['fit']) ?? const <String, Object?>{};

  /// Capability flags.
  Map<String, Object?> get capabilities =>
      _asMap(json['capabilities']) ?? const <String, Object?>{};

  /// Whether `ext.device_preview.screenshot` is available.
  bool get canScreenshot => capabilities['screenshot'] == true;

  /// Whether target-platform simulation is available (debug builds only).
  bool get canTargetPlatform => capabilities['targetPlatform'] == true;
}

Map<String, Object?>? _asMap(Object? value) =>
    value is Map ? Map<String, Object?>.from(value) : null;

/// Deep-copies a JSON-compatible map.
Map<String, Object?> _deepCopy(Map<String, Object?> json) =>
    Map<String, Object?>.from(jsonDecode(jsonEncode(json)) as Map);

/// The built-in device catalog, generated from `device_specs/*.json`.
///
/// Unlike the app's own presets these carry frame artwork (screen outline and
/// device body), which is why the catalog lives here: only the selected
/// device's artwork is ever pushed over the wire, and the published package
/// ships none of it.
final List<PresetView> kBuiltInPresets = List<PresetView>.unmodifiable(
  kDeviceSpecs.map(PresetView.new),
);

/// The panel's single source of local truth, mirroring the inspected app's
/// device_preview state over the service extension protocol.
///
/// All mutations build the full simulation JSON locally and push it with
/// `setSimulation`; the UI then reconciles from the response (the app is the
/// single source of truth). Mutations are serialized: one issued while
/// another is in flight builds its JSON only after the previous response has
/// reconciled, so overrides can never be silently dropped by a stale
/// full-replacement push. Incoming `stateChanged` events update local state
/// unless their `requestId` matches one of our own pending writes (echo
/// suppression).
class PanelController extends ChangeNotifier {
  /// Creates a controller talking to [gateway].
  ///
  /// [storage] and [saveScreenshot] default to the platform implementations
  /// (localStorage / browser download on the web); tests inject fakes.
  /// [readyEventTimeout] is the fallback delay used when the
  /// `device_preview.ready` event does not arrive after the extension becomes
  /// available (e.g. it fired before we started listening).
  PanelController({
    required this.gateway,
    KeyValueStorage? storage,
    void Function(String bytesBase64, String filename)? saveScreenshot,
    this.readyEventTimeout = const Duration(milliseconds: 500),
    this.bannerDelay = const Duration(seconds: 2),
  })  : _storage = storage ?? createPlatformStorage(),
        _saveScreenshot = saveScreenshot ?? savePngDownload {
    _keepAcrossRestarts = _storage.read(_keepStorageKey) == 'true';
    gateway.connected.addListener(_onConnectionChanged);
    gateway.extensionAvailable.addListener(_onAvailabilityChanged);
    _eventsSubscription = gateway.events.listen(_onEvent);
    _onConnectionChanged();
    if (gateway.connected.value && gateway.extensionAvailable.value) {
      _scheduleSync(awaitReadyEvent: false);
    }
  }

  /// The injected gateway. The controller never touches `serviceManager`.
  final DevicePreviewGateway gateway;

  /// Fallback delay before syncing when no `device_preview.ready` arrives.
  final Duration readyEventTimeout;

  /// Grace period before showing the "no binding" banner, so the normal
  /// extension registration window after connect does not flash it.
  final Duration bannerDelay;

  final KeyValueStorage _storage;
  final void Function(String bytesBase64, String filename) _saveScreenshot;

  StreamSubscription<DevicePreviewEvent>? _eventsSubscription;
  Timer? _readyFallbackTimer;
  Timer? _bannerTimer;
  bool _syncing = false;
  int _requestCounter = 0;
  final Set<String> _pendingRequestIds = <String>{};

  PanelStatus _status = PanelStatus.disconnected;
  Map<String, Object?>? _stateJson;

  /// Presets the inspected app registered itself, minus the ones the built-in
  /// catalog already describes (the catalog entry wins: it has artwork).
  List<PresetView> _customPresets = const <PresetView>[];
  Map<String, Object?>? _stashedSimulation;
  bool _keepAcrossRestarts = false;
  bool _disposed = false;

  static const String _keepStorageKey = 'device_preview.keepAcrossRestarts';

  String get _stashStorageKey =>
      'device_preview.simulation:${gateway.serviceUri ?? 'unknown'}';

  // --------------------------------------------------------------------------
  // Read surface (consumed by the panel widgets)
  // --------------------------------------------------------------------------

  /// Current panel status.
  PanelStatus get status => _status;

  /// The last loaded state shape, or null before the first successful sync.
  StateView? get state {
    final json = _stateJson;
    return json == null ? null : StateView(json);
  }

  /// The active simulation JSON, or null when passing through.
  Map<String, Object?>? get simulation => state?.simulation;

  /// The devices offered by the picker: the built-in catalog, followed by any
  /// preset the inspected app registered through
  /// `DevicePreviewController.registerPreset` that the catalog does not
  /// already cover.
  List<PresetView> get presets => <PresetView>[
        ...kBuiltInPresets,
        ..._customPresets,
      ];

  /// Whether the "Keep across restarts" toggle is on.
  bool get keepAcrossRestarts => _keepAcrossRestarts;

  /// Whether a screen size simulation is active (enables orientation toggle).
  bool get hasSimulatedScreen => simulation?['screenSize'] != null;

  /// The preset matching the active simulation's `presetId`, if any.
  PresetView? get activePreset {
    final id = simulation?['presetId'];
    if (id is! String) return null;
    for (final preset in presets) {
      if (preset.id == id) return preset;
    }
    return null;
  }

  /// Label describing the active device selection for the toolbar.
  String get activeDeviceLabel {
    final sim = simulation;
    if (sim == null || sim['screenSize'] == null) return 'Real device';
    return activePreset?.name ?? (sim['presetId'] as String? ?? 'Custom');
  }

  // --------------------------------------------------------------------------
  // Lifecycle: connection / availability / events
  // --------------------------------------------------------------------------

  void _onConnectionChanged() {
    if (_disposed) return;
    if (!gateway.connected.value) {
      _readyFallbackTimer?.cancel();
      _bannerTimer?.cancel();
      _pendingRequestIds.clear();
      _stateJson = null;
      _customPresets = const <PresetView>[];
      _setStatus(PanelStatus.disconnected);
    } else {
      _onAvailabilityChanged();
    }
  }

  void _onAvailabilityChanged() {
    if (_disposed || !gateway.connected.value) return;
    if (gateway.extensionAvailable.value) {
      _bannerTimer?.cancel();
      _scheduleSync(awaitReadyEvent: true);
    } else {
      _readyFallbackTimer?.cancel();
      _stateJson = null;
      _setStatus(PanelStatus.noBinding);
      _bannerTimer?.cancel();
      _bannerTimer = Timer(bannerDelay, () {
        if (_disposed ||
            !gateway.connected.value ||
            gateway.extensionAvailable.value) {
          return;
        }
        gateway.showBannerMessage(
          key: 'device_preview_no_binding',
          type: 'warning',
          message:
              'Device Preview is not active in this app. Add '
              '`DevicePreview.enable()` before `runApp`.',
        );
      });
    }
  }

  void _onEvent(DevicePreviewEvent event) {
    if (_disposed) return;
    switch (event.kind) {
      case 'device_preview.ready':
        // Hot restart (or first registration): re-push + re-fetch.
        _readyFallbackTimer?.cancel();
        unawaited(_syncNow());
      case 'device_preview.stateChanged':
        _onStateChangedEvent(event.data);
      case 'device_preview.presetsChanged':
        unawaited(_refreshPresets());
    }
  }

  void _onStateChangedEvent(Map<String, Object?> data) {
    final requestId = data['requestId'];
    if (requestId is String && _pendingRequestIds.remove(requestId)) {
      // Echo of our own write: the response already reconciled the state.
      return;
    }
    final stateJson = _stateJson;
    if (stateJson == null) return;
    stateJson['simulation'] = data['simulation'];
    if (data['fit'] is Map) stateJson['fit'] = data['fit'];
    _restash();
    notifyListeners();
  }

  /// Schedules a state sync: waits for `device_preview.ready` (with a
  /// [readyEventTimeout] fallback for the case where the event fired before
  /// the availability flip reached us), then re-pushes + re-fetches.
  void _scheduleSync({required bool awaitReadyEvent}) {
    _readyFallbackTimer?.cancel();
    if (!awaitReadyEvent) {
      unawaited(_syncNow());
      return;
    }
    _readyFallbackTimer = Timer(readyEventTimeout, () => unawaited(_syncNow()));
  }

  Future<void> _syncNow() async {
    if (_disposed || _syncing) return;
    _syncing = true;
    _readyFallbackTimer?.cancel();
    try {
      // Restart re-push: if enabled and a simulation is stashed, restore it
      // before fetching state so the fetched state already reflects it.
      final stash = _stashedSimulation ?? _readStoredStash();
      if (_keepAcrossRestarts && stash != null) {
        await _pushSimulation(stash, source: 'restore', reconcile: false);
      }
      final stateJson = await gateway.call(kGetStateExtension);
      _stateJson = stateJson;
      _restash();
      await _refreshPresets(notify: false);
      _setStatus(
        StateView(stateJson).enabled ? PanelStatus.ready : PanelStatus.disabled,
      );
    } on GatewayException catch (error) {
      if (_disposed) return;
      if (error.isRpcError) {
        _setStatus(PanelStatus.paused);
      } else {
        gateway.showNotification('Device Preview: ${error.message}');
      }
    } finally {
      _syncing = false;
    }
  }

  Future<void> _refreshPresets({bool notify = true}) async {
    final builtInIds = kBuiltInPresets.map((p) => p.id).toSet();
    try {
      final result = await gateway.call('ext.device_preview.listPresets');
      final rawPresets = result['presets'];
      _customPresets = <PresetView>[
        if (rawPresets is List)
          for (final entry in rawPresets)
            if (entry is Map &&
                !builtInIds.contains(entry['id'] as String? ?? ''))
              PresetView(Map<String, Object?>.from(entry)),
      ];
    } on GatewayException {
      _customPresets = const <PresetView>[];
    }
    if (notify) notifyListeners();
  }

  /// Re-fetches state and presets (used by the paused empty state's retry).
  Future<void> refresh() => _syncNow();

  // --------------------------------------------------------------------------
  // Mutations (sync-out)
  // --------------------------------------------------------------------------

  /// Applies [preset], preserving all non-metric overrides of the current
  /// simulation. Keeps the current orientation when one is active.
  Future<void> selectPreset(PresetView preset) {
    return _enqueueWrite(() {
      final current = _currentSimulation();
      final orientation = current['orientation'] as String? ?? 'portrait';
      return _applyPresetSimulation(preset, orientation, current);
    });
  }

  /// Clears all metric fields ("Real device"), preserving non-metric
  /// overrides. Sends a full reset when nothing else is overridden.
  Future<void> selectRealDevice() {
    return _enqueueWrite(() {
      final sim = _currentSimulation();
      for (final key in kMetricSimulationKeys) {
        sim.remove(key);
      }
      return _pushSimulation(sim.isEmpty ? null : sim);
    });
  }

  /// Applies custom screen metrics, replacing any preset selection.
  Future<void> setCustomMetrics({
    required double width,
    required double height,
    required double devicePixelRatio,
    double paddingLeft = 0,
    double paddingTop = 0,
    double paddingRight = 0,
    double paddingBottom = 0,
  }) {
    return _enqueueWrite(() {
      final sim = _currentSimulation();
      for (final key in kMetricSimulationKeys) {
        sim.remove(key);
      }
      sim['orientation'] = height >= width ? 'portrait' : 'landscape';
      sim['screenSize'] = <String, Object?>{'width': width, 'height': height};
      sim['devicePixelRatio'] = devicePixelRatio;
      final padding = <String, Object?>{
        'left': paddingLeft,
        'top': paddingTop,
        'right': paddingRight,
        'bottom': paddingBottom,
      };
      if (padding.values.any((v) => v != 0)) {
        sim['padding'] = padding;
        sim['viewPadding'] = Map<String, Object?>.from(padding);
      }
      return _pushSimulation(sim);
    });
  }

  /// Rotates the simulated screen to [orientation]
  /// (`'portrait'` | `'landscape'`).
  ///
  /// Uses the preset's per-orientation metrics when the active `presetId`
  /// resolves; otherwise applies the documented rotation rule.
  Future<void> setOrientation(String orientation) {
    return _enqueueWrite(() async {
      final sim = _currentSimulation();
      if (sim['screenSize'] == null) return;
      if (sim['orientation'] == orientation) return;
      final preset = activePreset;
      if (preset != null) {
        await _applyPresetSimulation(preset, orientation, sim);
        return;
      }
      final toLandscape = orientation == 'landscape';
      final size = _asMap(sim['screenSize']);
      // Display features are geometry: map their bounds through the 90°
      // rotation (before the size swap, using the pre-rotation extents).
      final features = sim['displayFeatures'];
      if (features is List && size != null) {
        final extent =
            ((toLandscape ? size['width'] : size['height']) as num?)
                ?.toDouble();
        if (extent != null) {
          sim['displayFeatures'] = _rotateDisplayFeatures(
            features,
            toLandscape: toLandscape,
            extent: extent,
          );
        }
      }
      if (size != null) {
        sim['screenSize'] = <String, Object?>{
          'width': size['height'],
          'height': size['width'],
        };
      }
      final padding = _asMap(sim['padding']);
      if (padding != null) {
        sim['padding'] = _rotateInsets(padding, toLandscape: toLandscape);
      }
      final viewPadding = _asMap(sim['viewPadding']);
      if (viewPadding != null) {
        sim['viewPadding'] =
            _rotateInsets(viewPadding, toLandscape: toLandscape);
      }
      sim['orientation'] = orientation;
      await _pushSimulation(sim);
    });
  }

  /// Sets or clears (`null`) the platform brightness (`'light'`/`'dark'`).
  Future<void> setBrightness(String? brightness) =>
      _mutate('platformBrightness', brightness);

  /// Sets or clears (`null`) the linear text scale factor.
  Future<void> setTextScaleFactor(double? factor) =>
      _mutate('textScaleFactor', factor);

  /// Sets or clears (`null`) the 24-hour time format override.
  Future<void> setAlwaysUse24HourFormat(bool? value) =>
      _mutate('alwaysUse24HourFormat', value);

  /// Sets or clears (`null`/empty) the ordered simulated locale list
  /// (language tags, first entry is `PlatformDispatcher.locale`).
  Future<void> setLocales(List<String>? locales) =>
      _mutate('locales', (locales == null || locales.isEmpty) ? null : locales);

  /// Sets or clears (`null`) the target platform override (debug only).
  Future<void> setTargetPlatform(String? platform) =>
      _mutate('platform', platform);

  /// Sets one tri-state accessibility [flag] to [value] (null = real device).
  Future<void> setAccessibilityFlag(String flag, bool? value) {
    return _enqueueWrite(() {
      final sim = _currentSimulation();
      final accessibility =
          _asMap(sim['accessibility']) ?? <String, Object?>{};
      if (value == null) {
        accessibility.remove(flag);
      } else {
        accessibility[flag] = value;
      }
      if (accessibility.isEmpty) {
        sim.remove('accessibility');
      } else {
        sim['accessibility'] = accessibility;
      }
      return _pushSimulation(sim.isEmpty ? null : sim);
    });
  }

  /// Clears the whole simulation (`ext.device_preview.reset`).
  Future<void> resetAll() {
    return _enqueueWrite(() async {
      try {
        final result = await gateway.call('ext.device_preview.reset');
        if (_checkErrorEnvelope(result)) return;
        _stateJson = result;
        _restash();
        _setStatus(
          StateView(result).enabled ? PanelStatus.ready : PanelStatus.disabled,
        );
        notifyListeners();
      } on GatewayException catch (error) {
        _onMutationError(error);
      }
    });
  }

  /// Requests a screenshot and triggers a browser download.
  Future<void> takeScreenshot() async {
    try {
      final result = await gateway.call('ext.device_preview.screenshot');
      if (_checkErrorEnvelope(result)) return;
      final bytesBase64 = result['bytesBase64'];
      if (bytesBase64 is! String || bytesBase64.isEmpty) {
        gateway.showNotification('Device Preview: empty screenshot response.');
        return;
      }
      final label = (simulation?['presetId'] as String?) ?? 'device';
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      _saveScreenshot(bytesBase64, 'device_preview_${label}_$timestamp.png');
    } on GatewayException catch (error) {
      _onMutationError(error);
    }
  }

  /// Toggles the "Keep across restarts" behavior (persisted).
  set keepAcrossRestarts(bool value) {
    if (value == _keepAcrossRestarts) return;
    _keepAcrossRestarts = value;
    _storage.write(_keepStorageKey, value.toString());
    notifyListeners();
  }

  // --------------------------------------------------------------------------
  // Internals
  // --------------------------------------------------------------------------

  /// Tail of the serialized write queue, or null when no write is in flight.
  Future<void>? _writeQueue;

  /// Serializes state-mutating pushes: each mutation builds its simulation
  /// JSON only after the previous push has reconciled `_stateJson`, so a push
  /// built while another is in flight can never silently drop the earlier
  /// override (the UI callbacks are fire-and-forget, so without this two
  /// quick successive clicks would race over the RPC round-trip).
  ///
  /// When the queue is idle, [task] starts synchronously (no extra microtask
  /// hops). The queue survives a throwing task (errors still surface through
  /// the future returned to that task's caller).
  Future<void> _enqueueWrite(Future<void> Function() task) {
    final previous = _writeQueue;
    final result = previous == null ? task() : previous.then((_) => task());
    final tail = result.catchError((Object _) {});
    _writeQueue = tail;
    tail.whenComplete(() {
      if (identical(_writeQueue, tail)) {
        _writeQueue = null;
      }
    });
    return result;
  }

  Future<void> _applyPresetSimulation(
    PresetView preset,
    String orientation,
    Map<String, Object?> current,
  ) {
    final sim = Map<String, Object?>.from(current);
    for (final key in kMetricSimulationKeys) {
      sim.remove(key);
    }
    sim['presetId'] = preset.id;
    sim['orientation'] = orientation;
    // The frame is described in portrait and rotated app-side, so it is the
    // one metric field orientation never touches.
    final frame = preset.frame;
    if (frame != null) sim['frame'] = frame;
    // Like the frame, the bars are orientation-independent: they follow the
    // safe areas, which are resolved below.
    final systemUi = preset.systemUi;
    if (systemUi != null) sim['systemUi'] = systemUi;
    final landscape = orientation == 'landscape';
    final size = preset.portraitSize;
    if (size != null) {
      sim['screenSize'] = landscape
          ? <String, Object?>{'width': size['height'], 'height': size['width']}
          : Map<String, Object?>.from(size);
    }
    if (preset.devicePixelRatio != null) {
      sim['devicePixelRatio'] = preset.devicePixelRatio;
    }
    final portraitPadding = preset.portraitPadding;
    final padding = landscape
        ? preset.landscapePadding ??
            (portraitPadding == null
                ? null
                : _rotateInsets(portraitPadding, toLandscape: true))
        : portraitPadding;
    if (padding != null) sim['padding'] = padding;
    final portraitViewPadding = preset.portraitViewPadding ?? portraitPadding;
    final viewPadding = landscape
        ? preset.landscapeViewPadding ??
            (portraitViewPadding == null
                ? null
                : _rotateInsets(portraitViewPadding, toLandscape: true))
        : portraitViewPadding;
    if (viewPadding != null) sim['viewPadding'] = viewPadding;
    final gestureInsets = preset.systemGestureInsets;
    if (gestureInsets != null &&
        gestureInsets.values.any((v) => v != 0 && v != 0.0)) {
      sim['systemGestureInsets'] = gestureInsets;
    }
    final displayFeatures = preset.displayFeatures;
    if (displayFeatures != null && displayFeatures.isNotEmpty) {
      // Preset display features are expressed in portrait coordinates; map
      // them through the 90° rotation for landscape (mirrors
      // `SimulatedDisplayFeature.rotatedToLandscape` app-side).
      final portraitWidth = (size?['width'] as num?)?.toDouble();
      sim['displayFeatures'] = landscape && portraitWidth != null
          ? _rotateDisplayFeatures(
              displayFeatures,
              toLandscape: true,
              extent: portraitWidth,
            )
          : displayFeatures;
    }
    return _pushSimulation(sim);
  }

  /// Maps display-feature bounds through the 90° rotation.
  ///
  /// [extent] is the pre-rotation portrait width when [toLandscape], or the
  /// pre-rotation landscape height otherwise: `(l, t, r, b)` becomes
  /// `(t, extent − r, b, extent − l)` toward landscape and
  /// `(extent − b, l, extent − t, r)` toward portrait.
  List<Object?> _rotateDisplayFeatures(
    List<Object?> features, {
    required bool toLandscape,
    required double extent,
  }) {
    return <Object?>[
      for (final feature in features)
        if (feature is Map)
          _rotateFeatureBounds(
            Map<String, Object?>.from(feature),
            toLandscape: toLandscape,
            extent: extent,
          )
        else
          feature,
    ];
  }

  Map<String, Object?> _rotateFeatureBounds(
    Map<String, Object?> feature, {
    required bool toLandscape,
    required double extent,
  }) {
    final bounds = _asMap(feature['bounds']);
    if (bounds == null) return feature;
    double side(String key) => (bounds[key] as num?)?.toDouble() ?? 0;
    final left = side('left');
    final top = side('top');
    final right = side('right');
    final bottom = side('bottom');
    feature['bounds'] = toLandscape
        ? <String, Object?>{
            'left': top,
            'top': extent - right,
            'right': bottom,
            'bottom': extent - left,
          }
        : <String, Object?>{
            'left': extent - bottom,
            'top': left,
            'right': extent - top,
            'bottom': right,
          };
    return feature;
  }

  /// Rotation rule from the design document:
  /// `landscape.padding = EdgeInsets.only(left: portrait.top,
  /// right: portrait.top, bottom: portrait.bottom)` (notch mirrored to both
  /// sides, home indicator kept). The portrait direction is the best-effort
  /// inverse.
  Map<String, Object?> _rotateInsets(
    Map<String, Object?> insets, {
    required bool toLandscape,
  }) {
    double side(String key) => (insets[key] as num?)?.toDouble() ?? 0;
    if (toLandscape) {
      return <String, Object?>{
        'left': side('top'),
        'top': 0.0,
        'right': side('top'),
        'bottom': side('bottom'),
      };
    }
    return <String, Object?>{
      'left': 0.0,
      'top': side('left'),
      'right': 0.0,
      'bottom': side('bottom'),
    };
  }

  Map<String, Object?> _currentSimulation() {
    final sim = simulation;
    return sim == null ? <String, Object?>{} : _deepCopy(sim);
  }

  Future<void> _mutate(String key, Object? value) {
    return _enqueueWrite(() {
      final sim = _currentSimulation();
      if (value == null) {
        sim.remove(key);
      } else {
        sim[key] = value;
      }
      return _pushSimulation(sim.isEmpty ? null : sim);
    });
  }

  String _newRequestId() =>
      'devtools-${DateTime.now().microsecondsSinceEpoch}-${_requestCounter++}';

  /// Sends [simulation] (null = reset) with a fresh `requestId` and, when
  /// [reconcile] is true, reconciles local state from the response.
  Future<void> _pushSimulation(
    Map<String, Object?>? simulation, {
    String source = 'devtools',
    bool reconcile = true,
  }) async {
    final requestId = _newRequestId();
    _pendingRequestIds.add(requestId);
    try {
      final result = await gateway.call(
        'ext.device_preview.setSimulation',
        args: <String, String>{
          'simulation': jsonEncode(simulation),
          'requestId': requestId,
          // Forward-compatible extra key (ignored by apps that predate it):
          // lets the app label the resulting stateChanged event's `source`.
          'source': source,
        },
      );
      if (_checkErrorEnvelope(result)) return;
      if (!reconcile) return;
      _stateJson = result;
      _restash();
      _setStatus(
        StateView(result).enabled ? PanelStatus.ready : PanelStatus.disabled,
      );
      notifyListeners();
    } on GatewayException catch (error) {
      _pendingRequestIds.remove(requestId);
      _onMutationError(error);
    }
  }

  /// Returns true (and notifies) when [result] is a protocol error envelope.
  bool _checkErrorEnvelope(Map<String, Object?> result) {
    final error = result['error'];
    if (error is Map) {
      final message = error['message'] ?? 'unknown error';
      gateway.showNotification('Device Preview: $message');
      return true;
    }
    return false;
  }

  void _onMutationError(GatewayException error) {
    if (_disposed) return;
    if (error.isRpcError) _setStatus(PanelStatus.paused);
    gateway.showNotification('Device Preview: ${error.message}');
  }

  void _restash() {
    final sim = state?.simulation;
    _stashedSimulation = sim == null ? null : _deepCopy(sim);
    if (sim == null) {
      _storage.remove(_stashStorageKey);
    } else {
      _storage.write(_stashStorageKey, jsonEncode(sim));
    }
  }

  Map<String, Object?>? _readStoredStash() {
    final raw = _storage.read(_stashStorageKey);
    if (raw == null) return null;
    try {
      final decoded = jsonDecode(raw);
      return decoded is Map ? Map<String, Object?>.from(decoded) : null;
    } on FormatException {
      return null;
    }
  }

  void _setStatus(PanelStatus status) {
    if (status == _status) {
      notifyListeners();
      return;
    }
    _status = status;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _readyFallbackTimer?.cancel();
    _bannerTimer?.cancel();
    unawaited(_eventsSubscription?.cancel());
    gateway.connected.removeListener(_onConnectionChanged);
    gateway.extensionAvailable.removeListener(_onAvailabilityChanged);
    super.dispose();
  }
}

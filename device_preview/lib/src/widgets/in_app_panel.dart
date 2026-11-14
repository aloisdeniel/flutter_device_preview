import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';

import '../../presets.dart';
import '../binding/preview_state.dart';
import '../controller/controller.dart';
import '../model/fit_transform.dart';
import '../model/foldable_posture.dart';
import '../model/simulation.dart';
import 'dot_grid_decoration.dart';
import 'in_app_panel_storage.dart';
import 'preview_host_shell.dart';

/// Width of the docked right-hand developer panel in real logical pixels.
const double kInAppPanelWidth = 320;

/// Default insets reserved around the simulated device when the panel is open.
const EdgeInsets kInAppPanelExpandedInsets = EdgeInsets.fromLTRB(
  16,
  16,
  kInAppPanelWidth + 16,
  16,
);

/// Default insets reserved around the simulated device when collapsed.
const EdgeInsets kInAppPanelCollapsedInsets = EdgeInsets.all(16);

const double _kCollapsedButtonWidth = 124;
const double _kCollapsedButtonHeight = 36;
const double _kCollapsedMargin = 12;

/// Wraps [app] with the collapsible in-app Device Preview panel.
class PreviewInAppShell extends StatefulWidget {
  /// Creates the in-app preview shell.
  const PreviewInAppShell({
    super.key,
    required this.controller,
    required this.state,
    required this.fit,
    required this.hostView,
    required this.app,
  });

  /// Active simulation controller.
  final DevicePreviewControllerImpl controller;

  /// Shared preview state.
  final PreviewState state;

  /// Live fit transform.
  final ValueListenable<FitTransform> fit;

  /// Real host view.
  final ui.FlutterView hostView;

  /// Application subtree.
  final Widget app;

  @override
  State<PreviewInAppShell> createState() => _PreviewInAppShellState();
}

class _PreviewInAppShellState extends State<PreviewInAppShell> {
  bool _isExpanded = true;
  bool _restoringPreferences = true;
  DevicePreset _lastPreset = DevicePresets.iPhone17Pro;
  late final OverlayEntry _overlayEntry;

  static final SegmentedButtonThemeData _segmentedButtonTheme =
      SegmentedButtonThemeData(
        style: ButtonStyle(
          visualDensity: VisualDensity.compact,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          ),
          textStyle: const WidgetStatePropertyAll<TextStyle>(
            TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
      );

  static final ThemeData _darkPanelTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    visualDensity: VisualDensity.compact,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF5C9CE6),
      brightness: Brightness.dark,
      surface: const Color(0xFF1B1E26),
    ),
    scaffoldBackgroundColor: const Color(0xFF1B1E26),
    segmentedButtonTheme: _segmentedButtonTheme,
  );

  static final ThemeData _lightPanelTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    visualDensity: VisualDensity.compact,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF2B6CB0),
      surface: const Color(0xFFD2D5DC),
    ),
    scaffoldBackgroundColor: const Color(0xFFD2D5DC),
    segmentedButtonTheme: _segmentedButtonTheme,
  );

  @override
  void initState() {
    super.initState();
    _syncLastPreset();
    widget.controller.addListener(_handleSimulationChanged);
    widget.state.backgroundDecorationOverride.addListener(_handleUiPrefChanged);
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => _buildOverlayContent(context),
    );
    unawaited(_restorePreferences());
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleSimulationChanged);
    widget.state.backgroundDecorationOverride.removeListener(
      _handleUiPrefChanged,
    );
    _overlayEntry.dispose();
    super.dispose();
  }

  void _syncLastPreset() {
    final String? baseId = FoldableCoverSpecs.baseId(
      widget.controller.simulation?.presetId,
    );
    if (baseId == null) {
      return;
    }
    for (final DevicePreset preset in widget.controller.presets) {
      if (preset.id == baseId) {
        _lastPreset = preset;
        return;
      }
    }
  }

  void _handleSimulationChanged() {
    _syncLastPreset();
    _persistPreferences();
  }

  void _handleUiPrefChanged() {
    _persistPreferences();
  }

  Future<void> _restorePreferences() async {
    final InAppPanelPreferences? saved = await InAppPanelPreferences.load();
    if (!mounted) {
      return;
    }
    if (saved == null) {
      _restoringPreferences = false;
      return;
    }
    for (final DevicePreset p in widget.controller.presets) {
      if (p.id == saved.lastPresetId) {
        _lastPreset = p;
        break;
      }
    }
    widget.state.backgroundDecorationOverride.value = saved.isLightBackground
        ? const DotGridDecoration.light()
        : null;
    if (_isExpanded != saved.isExpanded) {
      setState(() {
        _isExpanded = saved.isExpanded;
      });
      _overlayEntry.markNeedsBuild();
      widget.controller.setPanelInsets(
        saved.isExpanded
            ? kInAppPanelExpandedInsets
            : kInAppPanelCollapsedInsets,
      );
    }
    final DeviceSimulation restored = saved.buildSimulation(
      widget.controller.presets,
    );
    await widget.controller.apply(restored);
    if (mounted) {
      setState(() {
        _restoringPreferences = false;
      });
      _overlayEntry.markNeedsBuild();
    }
  }

  void _persistPreferences() {
    if (_restoringPreferences) {
      return;
    }
    final DeviceSimulation? sim = widget.controller.simulation;
    final bool simulatesMetrics = sim?.simulatesMetrics ?? false;
    final FoldablePosture foldPosture;
    if (FoldableCoverSpecs.isCoverId(sim?.presetId)) {
      foldPosture = FoldablePosture.folded;
    } else if (sim?.displayFeatures?.any(
          (SimulatedDisplayFeature f) =>
              f.state == ui.DisplayFeatureState.postureHalfOpened,
        ) ??
        false) {
      foldPosture = FoldablePosture.halfOpen;
    } else {
      foldPosture = FoldablePosture.open;
    }

    unawaited(
      InAppPanelPreferences.save(
        InAppPanelPreferences(
          isExpanded: _isExpanded,
          isLightBackground:
              widget.state.backgroundDecorationOverride.value ==
              const DotGridDecoration.light(),
          lastPresetId: _lastPreset.id,
          simulatesMetrics: simulatesMetrics,
          activePresetId: FoldableCoverSpecs.baseId(sim?.presetId),
          foldPosture: foldPosture,
          orientation: sim?.orientation ?? Orientation.portrait,
          showSystemUi: sim?.showSystemUi ?? true,
          showFrame: sim?.showFrame ?? true,
          keyboardVisible: sim?.keyboardInset != null,
          touchInput: sim?.touchInput,
          platformBrightness: sim?.platformBrightness,
          textScaleFactor: sim?.textScaleFactor,
          targetPlatform: sim?.targetPlatform,
          accessibility: sim?.accessibility,
        ),
      ),
    );
  }

  double _effectivePanelWidth(ui.Size realSize) {
    return math.min(kInAppPanelWidth, math.max(240, realSize.width * 0.45));
  }

  ui.Rect _computeHitRect(ui.Size realSize) {
    if (_isExpanded) {
      final double width = _effectivePanelWidth(realSize);
      return ui.Rect.fromLTWH(
        realSize.width - width,
        0,
        width,
        realSize.height,
      );
    }
    return ui.Rect.fromLTWH(
      realSize.width - _kCollapsedButtonWidth - _kCollapsedMargin,
      _kCollapsedMargin,
      _kCollapsedButtonWidth,
      _kCollapsedButtonHeight,
    );
  }

  void _setExpanded(bool expanded) {
    if (_isExpanded == expanded) {
      return;
    }
    setState(() {
      _isExpanded = expanded;
    });
    _overlayEntry.markNeedsBuild();
    widget.controller.setPanelInsets(
      expanded ? kInAppPanelExpandedInsets : kInAppPanelCollapsedInsets,
    );
    _persistPreferences();
  }

  Widget _buildOverlayContent(BuildContext context) {
    final ui.Size realSize = MediaQuery.sizeOf(context);
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    if (!_isExpanded) {
      return Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.all(_kCollapsedMargin),
          child: SizedBox(
            width: _kCollapsedButtonWidth,
            height: _kCollapsedButtonHeight,
            child: Material(
              color: isLight
                  ? const Color(0xF2D2D5DC)
                  : const Color(0xEE1B1E26),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: BorderSide(
                  color: isLight
                      ? const Color(0xFFB5BAC4)
                      : const Color(0xFF343946),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => _setExpanded(true),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.devices,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Preview',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    final double width = _effectivePanelWidth(realSize);
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        width: width,
        height: realSize.height,
        child: _InAppDevicePreviewPanel(
          controller: widget.controller,
          state: widget.state,
          lastPreset: _lastPreset,
          onLastPresetChanged: (DevicePreset preset) {
            _lastPreset = preset;
          },
          onCollapse: () => _setExpanded(false),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PreviewHostShell(
      fit: widget.fit,
      hostMetricsRevision: widget.state.hostMetricsRevision,
      hostView: widget.hostView,
      state: widget.state,
      computeHitRect: _computeHitRect,
      app: widget.app,
      overlay: ValueListenableBuilder<int>(
        valueListenable: widget.state.hostMetricsRevision,
        builder: (BuildContext context, int _, Widget? _) {
          final MediaQueryData hostMediaQuery = MediaQueryData.fromView(
            widget.hostView,
          ).copyWith(textScaler: TextScaler.noScaling);
          return ValueListenableBuilder<Decoration?>(
            valueListenable: widget.state.backgroundDecorationOverride,
            builder: (BuildContext context, Decoration? bgOverride, Widget? _) {
              final bool isLight =
                  bgOverride == const DotGridDecoration.light();
              return MediaQuery(
                data: hostMediaQuery,
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Localizations(
                    locale: const Locale('en', 'US'),
                    delegates: const <LocalizationsDelegate<dynamic>>[
                      DefaultMaterialLocalizations.delegate,
                      DefaultWidgetsLocalizations.delegate,
                    ],
                    child: Theme(
                      data: isLight ? _lightPanelTheme : _darkPanelTheme,
                      child: FocusScope(
                        child: Overlay(
                          initialEntries: <OverlayEntry>[_overlayEntry],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _InAppDevicePreviewPanel extends StatefulWidget {
  const _InAppDevicePreviewPanel({
    required this.controller,
    required this.state,
    required this.lastPreset,
    required this.onLastPresetChanged,
    required this.onCollapse,
  });

  final DevicePreviewControllerImpl controller;
  final PreviewState state;
  final DevicePreset lastPreset;
  final ValueChanged<DevicePreset> onLastPresetChanged;
  final VoidCallback onCollapse;

  @override
  State<_InAppDevicePreviewPanel> createState() =>
      _InAppDevicePreviewPanelState();
}

class _InAppDevicePreviewPanelState extends State<_InAppDevicePreviewPanel> {
  bool _pickingDevice = false;
  String _searchQuery = '';
  late DevicePreset _lastPreset = widget.lastPreset;
  double? _draggingTextScale;
  final TextEditingController _searchController = TextEditingController();

  bool get _isLightBackground =>
      widget.state.backgroundDecorationOverride.value ==
      const DotGridDecoration.light();

  void _setLightBackground(bool light) {
    widget.state.backgroundDecorationOverride.value = light
        ? const DotGridDecoration.light()
        : null;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _syncLastPreset();
    widget.controller.addListener(_handleControllerChanged);
  }

  @override
  void didUpdateWidget(covariant _InAppDevicePreviewPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.lastPreset != widget.lastPreset) {
      _lastPreset = widget.lastPreset;
    }
    if (!identical(oldWidget.controller, widget.controller)) {
      oldWidget.controller.removeListener(_handleControllerChanged);
      widget.controller.addListener(_handleControllerChanged);
      _syncLastPreset();
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleControllerChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _handleControllerChanged() {
    _syncLastPreset();
    if (mounted) {
      setState(() {});
    }
  }

  void _syncLastPreset() {
    final String? baseId = FoldableCoverSpecs.baseId(
      widget.controller.simulation?.presetId,
    );
    if (baseId == null) {
      return;
    }
    for (final DevicePreset preset in widget.controller.presets) {
      if (preset.id == baseId) {
        _lastPreset = preset;
        widget.onLastPresetChanged(preset);
        return;
      }
    }
  }

  /// Base preset selected in the device list (resolves cover ids back to their
  /// foldable parent preset).
  DevicePreset? get _basePreset {
    final String? baseId = FoldableCoverSpecs.baseId(
      widget.controller.simulation?.presetId,
    );
    if (baseId == null) {
      return null;
    }
    for (final DevicePreset preset in widget.controller.presets) {
      if (preset.id == baseId) {
        return preset;
      }
    }
    return null;
  }

  /// Effective preset for the currently active screen (returns the cover preset
  /// when folded).
  DevicePreset? get _activePreset {
    final String? id = widget.controller.simulation?.presetId;
    if (id == null) {
      return null;
    }
    if (FoldableCoverSpecs.isCoverId(id)) {
      final DevicePreset? base = _basePreset;
      return base == null ? null : FoldableCoverSpecs.coverFor(base);
    }
    return _basePreset;
  }

  FoldablePosture get _activeFoldPosture {
    final DeviceSimulation? sim = widget.controller.simulation;
    if (FoldableCoverSpecs.isCoverId(sim?.presetId)) {
      return FoldablePosture.folded;
    }
    final bool halfOpen =
        sim?.displayFeatures?.any(
          (SimulatedDisplayFeature f) =>
              f.state == ui.DisplayFeatureState.postureHalfOpened,
        ) ??
        false;
    return halfOpen ? FoldablePosture.halfOpen : FoldablePosture.open;
  }

  void _setFoldPosture(FoldablePosture posture) {
    final DevicePreset? foldable = _basePreset;
    if (foldable == null || foldable.kind != DeviceKind.foldable) {
      return;
    }
    final Orientation orientation =
        widget.controller.simulation?.orientation ?? Orientation.portrait;
    switch (posture) {
      case FoldablePosture.open:
        unawaited(
          widget.controller.applyPreset(foldable, orientation: orientation),
        );
      case FoldablePosture.halfOpen:
        unawaited(() async {
          await widget.controller.applyPreset(
            foldable,
            orientation: orientation,
          );
          await widget.controller.update((DeviceSimulation s) {
            final List<SimulatedDisplayFeature>? features = s.displayFeatures;
            if (features == null) {
              return s;
            }
            return s.copyWith(
              displayFeatures: List<SimulatedDisplayFeature>.unmodifiable(
                features.map(
                  (SimulatedDisplayFeature f) =>
                      f.type == ui.DisplayFeatureType.fold ||
                          f.type == ui.DisplayFeatureType.hinge
                      ? SimulatedDisplayFeature(
                          bounds: f.bounds,
                          type: f.type,
                          state: ui.DisplayFeatureState.postureHalfOpened,
                        )
                      : f,
                ),
              ),
            );
          });
        }());
      case FoldablePosture.folded:
        final DevicePreset? cover = FoldableCoverSpecs.coverFor(foldable);
        if (cover != null) {
          unawaited(
            widget.controller.applyPreset(cover, orientation: orientation),
          );
        }
    }
  }

  String get _activeDeviceLabel {
    final DeviceSimulation? sim = widget.controller.simulation;
    if (sim == null || !sim.simulatesMetrics) {
      return 'Real window';
    }
    final DevicePreset? base = _basePreset;
    if (base != null) {
      return FoldableCoverSpecs.isCoverId(sim.presetId)
          ? '${base.name} (Folded)'
          : base.name;
    }
    final Size size = sim.screenSize!;
    return '${size.width.toInt()} × ${size.height.toInt()}';
  }

  void _toggleMetricsSimulation(bool enabled) {
    if (enabled) {
      unawaited(widget.controller.applyPreset(_lastPreset));
    } else {
      unawaited(
        widget.controller.update(
          (DeviceSimulation s) => s.copyWith(
            presetId: null,
            screenSize: null,
            frame: null,
            systemUi: null,
            devicePixelRatio: null,
            padding: null,
            viewPadding: null,
            systemGestureInsets: null,
            keyboardInset: null,
            displayFeatures: null,
            deviceKind: null,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isLight = theme.brightness == Brightness.light;
    final Color panelBg = isLight
        ? const Color(0xFFD2D5DC)
        : const Color(0xFF1B1E26);
    final Color borderColor = isLight
        ? const Color(0xFFB5BAC4)
        : const Color(0xFF2E3340);
    final DeviceSimulation? sim = widget.controller.simulation;
    final bool simulatesMetrics = sim?.simulatesMetrics ?? false;

    return Material(
      color: panelBg,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: borderColor),
            top: BorderSide(color: borderColor),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildHeader(theme, isLight, borderColor, simulatesMetrics),
            Expanded(
              child: _pickingDevice
                  ? _buildDevicePicker(theme, borderColor)
                  : _buildControls(theme, sim, simulatesMetrics),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    ThemeData theme,
    bool isLight,
    Color borderColor,
    bool simulatesMetrics,
  ) {
    final Color headerBg = isLight
        ? const Color(0xFFC5C9D3)
        : const Color(0xFF151820);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: headerBg,
        border: Border(bottom: BorderSide(color: borderColor)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: isLight ? 0.08 : 0.25),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: <Widget>[
            Icon(Icons.devices, size: 18, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Device Preview',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Tooltip(
              message: simulatesMetrics
                  ? 'Disable device frame (use real window)'
                  : 'Enable device frame',
              child: Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: simulatesMetrics,
                  onChanged: _toggleMetricsSimulation,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.restart_alt, size: 18),
              tooltip: 'Reset all overrides',
              onPressed: () {
                widget.state.backgroundDecorationOverride.value = null;
                unawaited(
                  widget.controller.applyPreset(
                    _lastPreset,
                    resetOverrides: true,
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right, size: 20),
              tooltip: 'Collapse panel',
              onPressed: widget.onCollapse,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControls(
    ThemeData theme,
    DeviceSimulation? sim,
    bool simulatesMetrics,
  ) {
    final DevicePreset? preset = _activePreset;
    final DevicePreset? basePreset = _basePreset;
    final bool isFoldable =
        simulatesMetrics && basePreset?.kind == DeviceKind.foldable;
    final Orientation orientation = sim?.orientation ?? Orientation.portrait;
    final double? presetKeyboardHeight = preset?.keyboardHeight(orientation);
    final bool hasKeyboardSupport =
        simulatesMetrics && presetKeyboardHeight != null;
    final bool isKeyboardUp = sim?.keyboardInset != null;
    final bool hasSystemUi = simulatesMetrics && sim?.systemUi != null;
    final bool hasFrameBody =
        simulatesMetrics && (sim?.frame?.body.isNotEmpty ?? false);
    final Brightness? brightness = sim?.platformBrightness;
    final double? textScale = sim?.textScaleFactor;
    final double effectiveTextScale = _draggingTextScale ?? textScale ?? 1.0;
    final SimulatedAccessibilityFeatures a11y =
        sim?.accessibility ?? const SimulatedAccessibilityFeatures();

    return ListView(
      padding: const EdgeInsets.all(14),
      children: <Widget>[
        _SectionCard(
          title: 'Device Settings',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => setState(() => _pickingDevice = true),
                child: InputDecorator(
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _activeDeviceLabel,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (simulatesMetrics && sim?.screenSize != null)
                              Text(
                                '${sim!.screenSize!.width.toInt()} × '
                                '${sim.screenSize!.height.toInt()} · '
                                '@${sim.devicePixelRatio ?? 1.0}x',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                  fontSize: 11,
                                ),
                              ),
                          ],
                        ),
                      ),
                      const Icon(Icons.unfold_more, size: 18),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              _ControlRow(
                label: 'Platform',
                child: SegmentedButton<String>(
                  showSelectedIcon: false,
                  segments: const <ButtonSegment<String>>[
                    ButtonSegment<String>(
                      value: 'auto',
                      label: Text('Auto', softWrap: false),
                    ),
                    ButtonSegment<String>(
                      value: 'iOS',
                      label: Text('iOS', softWrap: false),
                    ),
                    ButtonSegment<String>(
                      value: 'android',
                      label: Text('Android', softWrap: false),
                    ),
                  ],
                  selected: <String>{
                    switch (sim?.targetPlatform) {
                      TargetPlatform.iOS => 'iOS',
                      TargetPlatform.android => 'android',
                      _ => 'auto',
                    },
                  },
                  onSelectionChanged: kDebugMode
                      ? (Set<String> next) {
                          final TargetPlatform? target = switch (next.first) {
                            'iOS' => TargetPlatform.iOS,
                            'android' => TargetPlatform.android,
                            _ => null,
                          };
                          unawaited(
                            widget.controller.update(
                              (DeviceSimulation s) =>
                                  s.copyWith(targetPlatform: target),
                            ),
                          );
                        }
                      : null,
                ),
              ),
              const SizedBox(height: 12),
              if (isFoldable) ...<Widget>[
                _ControlRow(
                  label: 'Fold',
                  child: SegmentedButton<FoldablePosture>(
                    showSelectedIcon: false,
                    segments: const <ButtonSegment<FoldablePosture>>[
                      ButtonSegment<FoldablePosture>(
                        value: FoldablePosture.open,
                        label: Text('Open', softWrap: false),
                      ),
                      ButtonSegment<FoldablePosture>(
                        value: FoldablePosture.halfOpen,
                        label: Text('Half', softWrap: false),
                      ),
                      ButtonSegment<FoldablePosture>(
                        value: FoldablePosture.folded,
                        label: Text('Folded', softWrap: false),
                      ),
                    ],
                    selected: <FoldablePosture>{_activeFoldPosture},
                    onSelectionChanged: (Set<FoldablePosture> next) =>
                        _setFoldPosture(next.first),
                  ),
                ),
                const SizedBox(height: 12),
              ],
              _ControlRow(
                label: 'Orientation',
                child: SegmentedButton<Orientation>(
                  showSelectedIcon: false,
                  segments: const <ButtonSegment<Orientation>>[
                    ButtonSegment<Orientation>(
                      value: Orientation.portrait,
                      icon: Icon(Icons.stay_current_portrait, size: 16),
                      tooltip: 'Portrait',
                    ),
                    ButtonSegment<Orientation>(
                      value: Orientation.landscape,
                      icon: Icon(Icons.stay_current_landscape, size: 16),
                      tooltip: 'Landscape',
                    ),
                  ],
                  selected: <Orientation>{orientation},
                  onSelectionChanged: simulatesMetrics
                      ? (Set<Orientation> next) {
                          unawaited(
                            widget.controller.setOrientation(next.first),
                          );
                        }
                      : null,
                ),
              ),
              const SizedBox(height: 10),
              _SwitchRow(
                label: 'On-screen keyboard',
                value: isKeyboardUp,
                onChanged: hasKeyboardSupport
                    ? (bool v) {
                        unawaited(
                          widget.controller.update(
                            (DeviceSimulation s) => s.copyWith(
                              keyboardInset: v ? presetKeyboardHeight : null,
                            ),
                          ),
                        );
                      }
                    : null,
              ),
              const SizedBox(height: 10),
              _ControlRow(
                label: 'Pointer',
                child: SegmentedButton<String>(
                  showSelectedIcon: false,
                  segments: const <ButtonSegment<String>>[
                    ButtonSegment<String>(
                      value: 'auto',
                      label: Text('Auto', softWrap: false),
                    ),
                    ButtonSegment<String>(
                      value: 'touch',
                      label: Text('Touch', softWrap: false),
                    ),
                    ButtonSegment<String>(
                      value: 'mouse',
                      label: Text('Mouse', softWrap: false),
                    ),
                  ],
                  selected: <String>{
                    switch (sim?.touchInput) {
                      true => 'touch',
                      false => 'mouse',
                      null => 'auto',
                    },
                  },
                  onSelectionChanged: (Set<String> next) {
                    final bool? touch = switch (next.first) {
                      'touch' => true,
                      'mouse' => false,
                      _ => null,
                    };
                    unawaited(
                      widget.controller.update(
                        (DeviceSimulation s) => s.copyWith(touchInput: touch),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _SectionCard(
          title: 'Device Theme & Display Settings',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _ControlRow(
                label: 'Device Theme',
                child: SegmentedButton<String>(
                  showSelectedIcon: false,
                  segments: const <ButtonSegment<String>>[
                    ButtonSegment<String>(
                      value: 'system',
                      label: Text('Auto', softWrap: false),
                    ),
                    ButtonSegment<String>(
                      value: 'light',
                      icon: Icon(Icons.light_mode_outlined, size: 16),
                      tooltip: 'Light',
                    ),
                    ButtonSegment<String>(
                      value: 'dark',
                      icon: Icon(Icons.dark_mode_outlined, size: 16),
                      tooltip: 'Dark',
                    ),
                  ],
                  selected: <String>{
                    switch (brightness) {
                      Brightness.light => 'light',
                      Brightness.dark => 'dark',
                      null => 'system',
                    },
                  },
                  onSelectionChanged: (Set<String> next) {
                    final Brightness? target = switch (next.first) {
                      'light' => Brightness.light,
                      'dark' => Brightness.dark,
                      _ => null,
                    };
                    unawaited(
                      widget.controller.update(
                        (DeviceSimulation s) =>
                            s.copyWith(platformBrightness: target),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: <Widget>[
                  Text('Device Text Scale', style: theme.textTheme.bodySmall),
                  const Spacer(),
                  Text(
                    textScale == null
                        ? 'System (1.0×)'
                        : '${effectiveTextScale.toStringAsFixed(1)}×',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (textScale != null) ...<Widget>[
                    const SizedBox(width: 6),
                    InkWell(
                      onTap: () {
                        unawaited(
                          widget.controller.update(
                            (DeviceSimulation s) =>
                                s.copyWith(textScaleFactor: null),
                          ),
                        );
                      },
                      child: Text(
                        'Reset',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              Slider(
                min: 0.8,
                max: 2.5,
                divisions: 17,
                value: effectiveTextScale.clamp(0.8, 2.5),
                onChanged: (double value) {
                  setState(() => _draggingTextScale = value);
                },
                onChangeEnd: (double value) {
                  final double rounded = double.parse(value.toStringAsFixed(1));
                  setState(() => _draggingTextScale = null);
                  unawaited(
                    widget.controller.update(
                      (DeviceSimulation s) =>
                          s.copyWith(textScaleFactor: rounded),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _SectionCard(
          title: 'Device Accessibility Settings',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _SwitchRow(
                label: 'Bold text',
                value: a11y.boldText ?? false,
                onChanged: (bool v) {
                  unawaited(
                    widget.controller.update(
                      (DeviceSimulation s) => s.copyWith(
                        accessibility: a11y.copyWith(boldText: v ? true : null),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 4),
              _SwitchRow(
                label: 'High contrast',
                value: a11y.highContrast ?? false,
                onChanged: (bool v) {
                  unawaited(
                    widget.controller.update(
                      (DeviceSimulation s) => s.copyWith(
                        accessibility: a11y.copyWith(
                          highContrast: v ? true : null,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 4),
              _SwitchRow(
                label: 'Disable animations',
                value: a11y.disableAnimations ?? false,
                onChanged: (bool v) {
                  unawaited(
                    widget.controller.update(
                      (DeviceSimulation s) => s.copyWith(
                        accessibility: a11y.copyWith(
                          disableAnimations: v ? true : null,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _SectionCard(
          title: 'Previewer Settings',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _ControlRow(
                label: 'Previewer Theme',
                child: SegmentedButton<bool>(
                  showSelectedIcon: false,
                  segments: const <ButtonSegment<bool>>[
                    ButtonSegment<bool>(
                      value: false,
                      label: Text('Dark', softWrap: false),
                    ),
                    ButtonSegment<bool>(
                      value: true,
                      label: Text('Light', softWrap: false),
                    ),
                  ],
                  selected: <bool>{_isLightBackground},
                  onSelectionChanged: simulatesMetrics
                      ? (Set<bool> next) => _setLightBackground(next.first)
                      : null,
                ),
              ),
              const SizedBox(height: 10),
              _SwitchRow(
                label: 'Show Device Frame',
                value: sim?.showFrame ?? true,
                onChanged: hasFrameBody
                    ? (bool v) {
                        unawaited(
                          widget.controller.update(
                            (DeviceSimulation s) => s.copyWith(showFrame: v),
                          ),
                        );
                      }
                    : null,
              ),
              const SizedBox(height: 4),
              _SwitchRow(
                label: 'Show Status Bar',
                value: sim?.showSystemUi ?? true,
                onChanged: hasSystemUi
                    ? (bool v) {
                        unawaited(
                          widget.controller.update(
                            (DeviceSimulation s) => s.copyWith(showSystemUi: v),
                          ),
                        );
                      }
                    : null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDevicePicker(ThemeData theme, Color borderColor) {
    final String query = _searchQuery.trim().toLowerCase();
    final String? activeId = FoldableCoverSpecs.baseId(
      widget.controller.simulation?.presetId,
    );
    final bool simulatesMetrics =
        widget.controller.simulation?.simulatesMetrics ?? false;

    final List<DevicePreset> matches = widget.controller.presets.where((
      DevicePreset p,
    ) {
      if (query.isEmpty) {
        return true;
      }
      return p.name.toLowerCase().contains(query) ||
          (p.brand?.toLowerCase().contains(query) ?? false) ||
          p.platform.name.toLowerCase().contains(query) ||
          '${p.year ?? ''}'.contains(query);
    }).toList();

    const List<DeviceKind> kindOrder = <DeviceKind>[
      DeviceKind.phone,
      DeviceKind.foldable,
      DeviceKind.tablet,
      DeviceKind.desktop,
    ];
    const Map<DeviceKind, String> kindTitles = <DeviceKind, String>{
      DeviceKind.phone: 'Phones',
      DeviceKind.foldable: 'Foldables',
      DeviceKind.tablet: 'Tablets',
      DeviceKind.desktop: 'Desktops',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 12, 6),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.arrow_back, size: 18),
                tooltip: 'Back to controls',
                onPressed: () => setState(() => _pickingDevice = false),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText:
                        'Search ${widget.controller.presets.length} devices…',
                    isDense: true,
                    prefixIcon: const Icon(Icons.search, size: 16),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 16),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (String v) => setState(() => _searchQuery = v),
                ),
              ),
            ],
          ),
        ),
        Divider(height: 1, color: borderColor),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 4),
            children: <Widget>[
              ListTile(
                dense: true,
                leading: const Icon(Icons.desktop_windows_outlined, size: 18),
                title: const Text('Real window (no frame)'),
                selected: !simulatesMetrics,
                onTap: () {
                  _toggleMetricsSimulation(false);
                  setState(() => _pickingDevice = false);
                },
              ),
              for (final DeviceKind kind in kindOrder) ...<Widget>[
                Builder(
                  builder: (BuildContext context) {
                    final List<DevicePreset> group =
                        matches
                            .where((DevicePreset p) => p.kind == kind)
                            .toList()
                          ..sort((DevicePreset a, DevicePreset b) {
                            final int byYear = (b.year ?? 0).compareTo(
                              a.year ?? 0,
                            );
                            if (byYear != 0) {
                              return byYear;
                            }
                            final int byMonth = (b.releaseMonth ?? 0).compareTo(
                              a.releaseMonth ?? 0,
                            );
                            if (byMonth != 0) {
                              return byMonth;
                            }
                            return a.name.compareTo(b.name);
                          });
                    if (group.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
                          child: Text(
                            kindTitles[kind]!,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        for (final DevicePreset preset in group)
                          ListTile(
                            dense: true,
                            visualDensity: VisualDensity.compact,
                            selected: simulatesMetrics && preset.id == activeId,
                            title: Text(preset.name),
                            subtitle: Text(
                              [
                                if (preset.brand != null) preset.brand!,
                                if (preset.year != null) '${preset.year}',
                                '${preset.portraitSize.width.toInt()}×'
                                    '${preset.portraitSize.height.toInt()}',
                                '@${preset.devicePixelRatio}x',
                              ].join(' · '),
                              style: const TextStyle(fontSize: 11),
                            ),
                            onTap: () {
                              _lastPreset = preset;
                              widget.onLastPresetChanged(preset);
                              unawaited(widget.controller.applyPreset(preset));
                              setState(() => _pickingDevice = false);
                            },
                          ),
                      ],
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isLight = theme.brightness == Brightness.light;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: isLight ? const Color(0xFFE1E4EA) : const Color(0xFF232732),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isLight ? const Color(0xFFBEC3CD) : const Color(0xFF2F3545),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              title,
              style: theme.textTheme.labelMedium?.copyWith(
                color: isLight
                    ? const Color(0xFF4A505C)
                    : const Color(0xFF9AA0A6),
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _ControlRow extends StatelessWidget {
  const _ControlRow({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 68,
          child: Text(label, style: Theme.of(context).textTheme.bodySmall),
        ),
        Expanded(
          child: Align(alignment: Alignment.centerRight, child: child),
        ),
      ],
    );
  }
}

class _SwitchRow extends StatelessWidget {
  const _SwitchRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodySmall),
          ),
          Transform.scale(
            scale: 0.78,
            alignment: Alignment.centerRight,
            child: Switch(value: value, onChanged: onChanged),
          ),
        ],
      ),
    );
  }
}

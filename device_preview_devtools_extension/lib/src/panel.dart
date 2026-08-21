import 'package:devtools_app_shared/ui.dart';
import 'package:flutter/material.dart';

import 'panel_controller.dart';

/// The single-screen Device Preview panel.
///
/// The [controller] is created by the app shell (over the real
/// `ServiceManagerGateway`) or injected with a fake gateway in tests; this
/// widget never touches the DevTools globals itself.
class DevicePreviewPanel extends StatefulWidget {
  /// Creates the panel driven by [controller].
  const DevicePreviewPanel({super.key, required this.controller});

  /// The panel's state controller.
  final PanelController controller;

  @override
  State<DevicePreviewPanel> createState() => _DevicePreviewPanelState();
}

class _DevicePreviewPanelState extends State<DevicePreviewPanel> {
  PanelController get _controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Toolbar(controller: controller),
            Expanded(child: _buildBody(controller)),
          ],
        );
      },
    );
  }

  Widget _buildBody(PanelController controller) {
    switch (controller.status) {
      case PanelStatus.disconnected:
        return const _EmptyState(
          icon: Icons.link_off,
          title: 'No app connected',
          message: 'Connect DevTools to a running app to use Device Preview.',
        );
      case PanelStatus.noBinding:
        return const _EmptyState(
          icon: Icons.extension_off_outlined,
          title: 'Device Preview is not active in this app',
          message: 'Add `DevicePreview.enable()` before '
              '`runApp` and hot restart.',
        );
      case PanelStatus.disabled:
        return const _EmptyState(
          icon: Icons.do_not_disturb_alt_outlined,
          title: 'Device Preview is disabled',
          message: 'Device Preview is installed but simulation is turned off '
              'in this build. Call `DevicePreview.enable()` without an '
              'argument to keep it on in debug and profile builds.',
        );
      case PanelStatus.paused:
        return _EmptyState(
          icon: Icons.pause_circle_outline,
          title: 'Main isolate is paused',
          message: 'Device Preview cannot talk to the app while it is paused '
              'on a breakpoint. Resume the app, then retry.',
          action: DevToolsButton(
            icon: Icons.refresh,
            label: 'Retry',
            onPressed: () => _controller.refresh(),
          ),
        );
      case PanelStatus.ready:
        return _ReadyBody(controller: controller);
    }
  }
}

// ---------------------------------------------------------------------------
// Toolbar
// ---------------------------------------------------------------------------

class _Toolbar extends StatelessWidget {
  const _Toolbar({required this.controller});

  final PanelController controller;

  Color _statusColor(BuildContext context) {
    final theme = Theme.of(context);
    switch (controller.status) {
      case PanelStatus.ready:
        return Colors.green;
      case PanelStatus.paused:
      case PanelStatus.disabled:
        return Colors.orange;
      case PanelStatus.noBinding:
        return theme.colorScheme.error;
      case PanelStatus.disconnected:
        return theme.disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final canScreenshot = controller.state?.canScreenshot ?? false;
    return AreaPaneHeader(
      roundedTopBorder: false,
      includeTopBorder: false,
      tall: true,
      title: Row(
        children: [
          Container(
            key: const Key('device_preview_status_dot'),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _statusColor(context),
            ),
          ),
          const SizedBox(width: denseSpacing),
          Flexible(
            child: Text(
              controller.status == PanelStatus.ready
                  ? controller.activeDeviceLabel
                  : 'Device Preview',
              style: theme.textTheme.titleSmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      actions: [
        if (controller.status == PanelStatus.ready) ...[
          DevToolsButton(
            icon: Icons.restart_alt,
            label: 'Reset',
            tooltip: 'Clear the whole simulation (pass through to the real '
                'device)',
            onPressed: () => controller.resetAll(),
          ),
          const SizedBox(width: denseSpacing),
          if (canScreenshot)
            DevToolsButton.iconOnly(
              icon: Icons.photo_camera_outlined,
              tooltip: 'Save a screenshot of the simulated screen',
              onPressed: () => controller.takeScreenshot(),
            ),
          const SizedBox(width: denseSpacing),
        ],
        PopupMenuButton<void>(
          tooltip: 'More options',
          icon: const Icon(Icons.more_vert),
          itemBuilder: (context) => [
            CheckedPopupMenuItem<void>(
              key: const Key('device_preview_keep_across_restarts'),
              checked: controller.keepAcrossRestarts,
              onTap: () => controller.keepAcrossRestarts =
                  !controller.keepAcrossRestarts,
              child: const Text('Keep across restarts'),
            ),
          ],
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Empty states
// ---------------------------------------------------------------------------

class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.icon,
    required this.title,
    required this.message,
    this.action,
  });

  final IconData icon;
  final String title;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(largeSpacing),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40, color: theme.colorScheme.onSurfaceVariant),
              const SizedBox(height: defaultSpacing),
              Text(
                title,
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: denseSpacing),
              Text(
                message,
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              if (action != null) ...[
                const SizedBox(height: defaultSpacing),
                action!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Ready body: the six sections
// ---------------------------------------------------------------------------

class _ReadyBody extends StatelessWidget {
  const _ReadyBody({required this.controller});

  final PanelController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(defaultSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Section(
            title: 'Device',
            child: _DeviceSection(controller: controller),
          ),
          const SizedBox(height: defaultSpacing),
          _Section(
            title: 'Display',
            child: _DisplaySection(controller: controller),
          ),
          const SizedBox(height: defaultSpacing),
          _Section(
            title: 'Locale',
            child: _LocaleSection(controller: controller),
          ),
          const SizedBox(height: defaultSpacing),
          _Section(
            title: 'Accessibility',
            child: _AccessibilitySection(controller: controller),
          ),
          const SizedBox(height: defaultSpacing),
          _Section(
            title: 'Platform',
            child: _PlatformSection(controller: controller),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RoundedOutlinedBorder(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AreaPaneHeader(
            title: Text(title),
            roundedTopBorder: true,
            includeBottomBorder: true,
          ),
          Padding(
            padding: const EdgeInsets.all(defaultSpacing),
            child: child,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Device section
// ---------------------------------------------------------------------------

class _DeviceSection extends StatelessWidget {
  const _DeviceSection({required this.controller});

  final PanelController controller;

  @override
  Widget build(BuildContext context) {
    final orientation =
        controller.simulation?['orientation'] as String? ?? 'portrait';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: _PresetPickerButton(controller: controller)),
            const SizedBox(width: defaultSpacing),
            SegmentedButton<String>(
              key: const Key('device_preview_orientation_toggle'),
              segments: const [
                ButtonSegment(
                  value: 'portrait',
                  icon: Icon(Icons.stay_current_portrait),
                  tooltip: 'Portrait',
                ),
                ButtonSegment(
                  value: 'landscape',
                  icon: Icon(Icons.stay_current_landscape),
                  tooltip: 'Landscape',
                ),
              ],
              selected: {orientation},
              showSelectedIcon: false,
              onSelectionChanged: controller.hasSimulatedScreen
                  ? (selection) => controller.setOrientation(selection.first)
                  : null,
            ),
          ],
        ),
        const SizedBox(height: denseSpacing),
        _LabeledRow(
          label: 'System UI',
          child: Switch(
            key: const Key('device_preview_system_ui_switch'),
            value: controller.showSystemUi,
            onChanged: controller.hasSystemUi
                ? (value) => controller.setShowSystemUi(value)
                : null,
          ),
        ),
        const SizedBox(height: denseSpacing),
        _LabeledRow(
          label: 'Keyboard',
          child: Switch(
            key: const Key('device_preview_keyboard_switch'),
            value: controller.keyboardInset != null,
            onChanged: controller.hasKeyboard
                ? (value) => controller.setKeyboardVisible(value)
                : null,
          ),
        ),
        const SizedBox(height: denseSpacing),
        _TriStateRow(
          label: 'Touch input',
          triKey: const Key('device_preview_touch_input_toggle'),
          systemLabel: 'Auto',
          value: controller.touchInput,
          onChanged: controller.setTouchInput,
        ),
        const SizedBox(height: denseSpacing),
        _CustomDeviceExpander(controller: controller),
      ],
    );
  }
}

class _PresetPickerButton extends StatelessWidget {
  const _PresetPickerButton({required this.controller});

  final PanelController controller;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      key: const Key('device_preview_preset_picker_button'),
      icon: const Icon(Icons.devices, size: defaultIconSize),
      label: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          controller.activeDeviceLabel,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      onPressed: () async {
        final selection = await showDialog<_PresetSelection>(
          context: context,
          builder: (context) => _PresetPickerDialog(controller: controller),
        );
        if (selection == null) return;
        if (selection.realDevice) {
          await controller.selectRealDevice();
        } else if (selection.importJson) {
          if (!context.mounted) return;
          final imported = await showDialog<List<PresetView>>(
            context: context,
            builder: (context) => _ImportDeviceDialog(controller: controller),
          );
          if (imported != null && imported.isNotEmpty) {
            await controller.selectPreset(imported.last);
          }
        } else if (selection.preset != null) {
          await controller.selectPreset(selection.preset!);
        }
      },
    );
  }
}

class _PresetSelection {
  const _PresetSelection.realDevice()
      : realDevice = true,
        importJson = false,
        preset = null;
  const _PresetSelection.importJson()
      : realDevice = false,
        importJson = true,
        preset = null;
  const _PresetSelection.of(PresetView this.preset)
      : realDevice = false,
        importJson = false;

  final bool realDevice;

  /// The user asked to import a new device from a JSON spec.
  final bool importJson;
  final PresetView? preset;
}

/// Searchable preset list: the user's imported devices first, then the
/// catalog grouped by device kind then platform.
class _PresetPickerDialog extends StatefulWidget {
  const _PresetPickerDialog({required this.controller});

  final PanelController controller;

  @override
  State<_PresetPickerDialog> createState() => _PresetPickerDialogState();
}

class _PresetPickerDialogState extends State<_PresetPickerDialog> {
  String _query = '';

  static const _kindOrder = ['phone', 'tablet', 'foldable', 'desktop'];
  static const _kindLabels = {
    'phone': 'Phones',
    'tablet': 'Tablets',
    'foldable': 'Foldables',
    'desktop': 'Desktop windows',
  };

  bool _matches(PresetView p, String query) =>
      query.isEmpty ||
      p.name.toLowerCase().contains(query) ||
      p.brand.toLowerCase().contains(query) ||
      p.platform.toLowerCase().contains(query) ||
      '${p.year}'.contains(query) ||
      p.id.toLowerCase().contains(query);

  @override
  Widget build(BuildContext context) {
    // Rebuilds when a user device is removed from within the dialog.
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) => _buildDialog(context),
    );
  }

  Widget _buildDialog(BuildContext context) {
    final controller = widget.controller;
    final theme = Theme.of(context);
    final query = _query.trim().toLowerCase();
    final activePresetId = controller.simulation?['presetId'] as String?;
    // A Custom-metrics simulation has no presetId yet is not "Real device".
    final hasSimulatedScreen = controller.hasSimulatedScreen;
    final userDevices =
        controller.userDevices.where((p) => _matches(p, query)).toList();
    final filtered = controller.presets
        .where((p) => !controller.isUserDevice(p.id) && _matches(p, query))
        .toList();
    final byKind = <String, List<PresetView>>{};
    for (final preset in filtered) {
      byKind.putIfAbsent(preset.kind, () => []).add(preset);
    }
    final orderedKinds = [
      ..._kindOrder.where(byKind.containsKey),
      ...byKind.keys.where((k) => !_kindOrder.contains(k)),
    ];
    for (final kind in orderedKinds) {
      byKind[kind]!.sort(
        (a, b) {
          final byBrand = a.brand.compareTo(b.brand);
          if (byBrand != 0) return byBrand;
          final byPlatform = a.platform.compareTo(b.platform);
          if (byPlatform != 0) return byPlatform;
          // Newest first: a catalog spanning several generations is most
          // useful with this year's devices at the top. Undated entries (an
          // app's own presets) sort last.
          final byYear = (b.year ?? 0).compareTo(a.year ?? 0);
          return byYear != 0 ? byYear : a.name.compareTo(b.name);
        },
      );
    }
    Widget groupLabel(String label) => Padding(
          padding: const EdgeInsets.fromLTRB(
            defaultSpacing,
            denseSpacing,
            defaultSpacing,
            densePadding,
          ),
          child: Text(
            label,
            style: theme.textTheme.labelSmall!.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        );
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420, maxHeight: 520),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(defaultSpacing),
              child: DevToolsClearableTextField(
                key: const Key('device_preview_preset_search'),
                labelText: 'Search devices',
                prefixIcon: const Icon(Icons.search),
                autofocus: true,
                onChanged: (value) => setState(() => _query = value),
              ),
            ),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    key: const Key('device_preview_real_device_entry'),
                    leading: const Icon(Icons.smartphone),
                    title: const Text('Real device'),
                    subtitle: const Text(
                      'Clear the screen simulation, keep other overrides',
                    ),
                    selected: !hasSimulatedScreen,
                    onTap: () => Navigator.of(context)
                        .pop(const _PresetSelection.realDevice()),
                  ),
                  ListTile(
                    key: const Key('device_preview_import_json_entry'),
                    leading: const Icon(Icons.data_object),
                    title: const Text('New device from JSON…'),
                    subtitle: const Text(
                      'Paste a device spec; saved for later sessions',
                    ),
                    onTap: () => Navigator.of(context)
                        .pop(const _PresetSelection.importJson()),
                  ),
                  if (userDevices.isNotEmpty) ...[
                    groupLabel('My devices'),
                    for (final preset in userDevices)
                      ListTile(
                        key: Key('device_preview_user_device_${preset.id}'),
                        dense: true,
                        title: Text(preset.name),
                        subtitle: Text(_presetSubtitle(preset)),
                        selected: preset.id == activePresetId,
                        trailing: IconButton(
                          key: Key(
                            'device_preview_user_device_remove_${preset.id}',
                          ),
                          tooltip: 'Remove this device',
                          icon: const Icon(Icons.delete_outline),
                          iconSize: defaultIconSize,
                          onPressed: () =>
                              controller.removeUserDevice(preset.id),
                        ),
                        onTap: () => Navigator.of(context)
                            .pop(_PresetSelection.of(preset)),
                      ),
                  ],
                  for (final kind in orderedKinds) ...[
                    groupLabel(_kindLabels[kind] ?? kind),
                    for (final preset in byKind[kind]!)
                      ListTile(
                        dense: true,
                        title: Text(preset.name),
                        subtitle: Text(_presetSubtitle(preset)),
                        selected: preset.id == activePresetId,
                        onTap: () => Navigator.of(context)
                            .pop(_PresetSelection.of(preset)),
                      ),
                  ],
                  if (filtered.isEmpty && userDevices.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(defaultSpacing),
                      child: Text(
                        'No matching device.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _presetSubtitle(PresetView preset) {
    final size = preset.portraitSize;
    final width = (size?['width'] as num?)?.toStringAsFixed(0);
    final height = (size?['height'] as num?)?.toStringAsFixed(0);
    final dpr = preset.devicePixelRatio;
    return [
      if (preset.brand.isNotEmpty) preset.brand else preset.platform,
      if (preset.year != null) '${preset.year}',
      if (width != null && height != null) '$width×$height',
      if (dpr != null) '@${dpr}x',
      if (preset.frame != null) 'framed',
    ].join(' · ');
  }
}

/// Lets the user paste a device spec (the `device_specs/*.json` format, or a
/// JSON array of such specs) and import it as a persisted user device.
class _ImportDeviceDialog extends StatefulWidget {
  const _ImportDeviceDialog({required this.controller});

  final PanelController controller;

  @override
  State<_ImportDeviceDialog> createState() => _ImportDeviceDialogState();
}

class _ImportDeviceDialogState extends State<_ImportDeviceDialog> {
  final _text = TextEditingController();
  String? _error;

  static const String _placeholder = '''
{
  "id": "acme-phone",
  "name": "Acme Phone",
  "brand": "Acme",
  "platform": "android",
  "kind": "phone",
  "portraitSize": {"width": 412, "height": 915},
  "devicePixelRatio": 2.625,
  "portraitPadding": {"left": 0, "top": 48, "right": 0, "bottom": 24}
}''';

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  void _import() {
    try {
      final imported = widget.controller.importUserDevices(_text.text);
      Navigator.of(context).pop(imported);
    } on FormatException catch (error) {
      setState(() => _error = error.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      title: const Text('New device from JSON'),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480, maxHeight: 420),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Paste a device spec in the device_specs JSON format '
              '(id, name, platform, portraitSize and devicePixelRatio are '
              'required; frame artwork and safe areas are optional). The '
              'device is saved in this browser and listed under '
              '"My devices".',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: denseSpacing),
            Flexible(
              child: TextField(
                key: const Key('device_preview_import_json_field'),
                controller: _text,
                autofocus: true,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                style: theme.textTheme.bodySmall!.copyWith(
                  fontFamily: 'monospace',
                ),
                decoration: InputDecoration(
                  hintText: _placeholder,
                  hintStyle: theme.textTheme.bodySmall!.copyWith(
                    fontFamily: 'monospace',
                    color: theme.colorScheme.onSurfaceVariant.withValues(
                      alpha: 0.5,
                    ),
                  ),
                  border: const OutlineInputBorder(),
                  errorText: _error,
                  errorMaxLines: 3,
                ),
                onChanged: (_) {
                  if (_error != null) setState(() => _error = null);
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        DevToolsButton(
          key: const Key('device_preview_import_json_apply'),
          icon: Icons.add,
          label: 'Import',
          onPressed: _import,
        ),
      ],
    );
  }
}

class _CustomDeviceExpander extends StatefulWidget {
  const _CustomDeviceExpander({required this.controller});

  final PanelController controller;

  @override
  State<_CustomDeviceExpander> createState() => _CustomDeviceExpanderState();
}

class _CustomDeviceExpanderState extends State<_CustomDeviceExpander> {
  final _width = TextEditingController(text: '390');
  final _height = TextEditingController(text: '844');
  final _dpr = TextEditingController(text: '3.0');
  final _padLeft = TextEditingController(text: '0');
  final _padTop = TextEditingController(text: '0');
  final _padRight = TextEditingController(text: '0');
  final _padBottom = TextEditingController(text: '0');

  @override
  void dispose() {
    for (final controller in [
      _width,
      _height,
      _dpr,
      _padLeft,
      _padTop,
      _padRight,
      _padBottom,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _numberField(String label, TextEditingController controller, Key key) {
    return SizedBox(
      width: 84,
      child: TextField(
        key: key,
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: label,
          isDense: true,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  void _apply() {
    final width = double.tryParse(_width.text);
    final height = double.tryParse(_height.text);
    final dpr = double.tryParse(_dpr.text);
    if (width == null || width <= 0 || height == null || height <= 0) return;
    if (dpr == null || dpr <= 0) return;
    widget.controller.setCustomMetrics(
      width: width,
      height: height,
      devicePixelRatio: dpr,
      paddingLeft: double.tryParse(_padLeft.text) ?? 0,
      paddingTop: double.tryParse(_padTop.text) ?? 0,
      paddingRight: double.tryParse(_padRight.text) ?? 0,
      paddingBottom: double.tryParse(_padBottom.text) ?? 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      key: const Key('device_preview_custom_expander'),
      title: const Text('Custom…'),
      tilePadding: EdgeInsets.zero,
      childrenPadding: const EdgeInsets.only(bottom: denseSpacing),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      shape: const Border(),
      collapsedShape: const Border(),
      children: [
        Wrap(
          spacing: denseSpacing,
          runSpacing: denseSpacing,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _numberField(
              'Width',
              _width,
              const Key('device_preview_custom_width'),
            ),
            _numberField(
              'Height',
              _height,
              const Key('device_preview_custom_height'),
            ),
            _numberField('DPR', _dpr, const Key('device_preview_custom_dpr')),
          ],
        ),
        const SizedBox(height: denseSpacing),
        Wrap(
          spacing: denseSpacing,
          runSpacing: denseSpacing,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _numberField(
              'Pad left',
              _padLeft,
              const Key('device_preview_custom_pad_left'),
            ),
            _numberField(
              'Pad top',
              _padTop,
              const Key('device_preview_custom_pad_top'),
            ),
            _numberField(
              'Pad right',
              _padRight,
              const Key('device_preview_custom_pad_right'),
            ),
            _numberField(
              'Pad bottom',
              _padBottom,
              const Key('device_preview_custom_pad_bottom'),
            ),
            DevToolsButton(
              key: const Key('device_preview_custom_apply'),
              icon: Icons.check,
              label: 'Apply',
              onPressed: _apply,
            ),
          ],
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Display section
// ---------------------------------------------------------------------------

class _DisplaySection extends StatefulWidget {
  const _DisplaySection({required this.controller});

  final PanelController controller;

  @override
  State<_DisplaySection> createState() => _DisplaySectionState();
}

class _DisplaySectionState extends State<_DisplaySection> {
  /// Live slider value while dragging (committed on drag end).
  double? _draggingTextScale;

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    final theme = Theme.of(context);
    final sim = controller.simulation;
    final brightness = sim?['platformBrightness'] as String?;
    final textScale = (sim?['textScaleFactor'] as num?)?.toDouble();
    final use24h = sim?['alwaysUse24HourFormat'] as bool?;
    final sliderValue = _draggingTextScale ??
        textScale ??
        ((controller.state?.realDevice['textScaleFactor'] as num?)
                ?.toDouble() ??
            1.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _LabeledRow(
          label: 'Brightness',
          child: SegmentedButton<String>(
            key: const Key('device_preview_brightness_toggle'),
            segments: const [
              ButtonSegment(value: 'system', label: Text('System')),
              ButtonSegment(
                value: 'light',
                icon: Icon(Icons.light_mode_outlined),
                tooltip: 'Light',
              ),
              ButtonSegment(
                value: 'dark',
                icon: Icon(Icons.dark_mode_outlined),
                tooltip: 'Dark',
              ),
            ],
            selected: {brightness ?? 'system'},
            showSelectedIcon: false,
            onSelectionChanged: (selection) {
              final value = selection.first;
              controller.setBrightness(value == 'system' ? null : value);
            },
          ),
        ),
        const SizedBox(height: denseSpacing),
        _LabeledRow(
          label: 'Text scale',
          child: Row(
            children: [
              Expanded(
                child: Slider(
                  key: const Key('device_preview_text_scale_slider'),
                  min: 0.5,
                  max: 3.0,
                  divisions: 25,
                  value: sliderValue.clamp(0.5, 3.0),
                  label: sliderValue.toStringAsFixed(1),
                  onChanged: (value) =>
                      setState(() => _draggingTextScale = value),
                  onChangeEnd: (value) {
                    setState(() => _draggingTextScale = null);
                    controller.setTextScaleFactor(
                      double.parse(value.toStringAsFixed(1)),
                    );
                  },
                ),
              ),
              Text(
                textScale == null
                    ? 'system'
                    : '×${sliderValue.toStringAsFixed(1)}',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(width: denseSpacing),
              InputChip(
                key: const Key('device_preview_text_scale_system_chip'),
                label: const Text('System'),
                onPressed: textScale == null
                    ? null
                    : () => controller.setTextScaleFactor(null),
              ),
            ],
          ),
        ),
        const SizedBox(height: denseSpacing),
        _TriStateRow(
          label: '24-hour time',
          triKey: const Key('device_preview_24h_toggle'),
          value: use24h,
          onChanged: controller.setAlwaysUse24HourFormat,
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Locale section
// ---------------------------------------------------------------------------

const List<String> _commonLocales = [
  'en-US',
  'en-GB',
  'fr-FR',
  'de-DE',
  'es-ES',
  'it-IT',
  'pt-BR',
  'nl-NL',
  'ru-RU',
  'ja-JP',
  'ko-KR',
  'zh-CN',
  'zh-TW',
  'ar-SA',
  'hi-IN',
];

// At most two extra subtags: the app-side codec (`decodeLocale`) accepts
// `language[-Script][-COUNTRY]` and rejects longer tags with invalidParams,
// so the panel must not accept what the app will refuse.
final RegExp _languageTagPattern =
    RegExp(r'^[A-Za-z]{2,3}([-_][A-Za-z0-9]{2,8}){0,2}$');

class _LocaleSection extends StatefulWidget {
  const _LocaleSection({required this.controller});

  final PanelController controller;

  @override
  State<_LocaleSection> createState() => _LocaleSectionState();
}

class _LocaleSectionState extends State<_LocaleSection> {
  final _input = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  List<String> get _locales {
    final raw = widget.controller.simulation?['locales'];
    return raw is List ? raw.whereType<String>().toList() : const <String>[];
  }

  void _add(String tag) {
    final trimmed = tag.trim();
    if (trimmed.isEmpty) return;
    if (!_languageTagPattern.hasMatch(trimmed)) {
      setState(() => _error = 'Invalid language tag (e.g. fr-FR)');
      return;
    }
    setState(() => _error = null);
    _input.clear();
    final locales = _locales;
    if (locales.contains(trimmed)) return;
    widget.controller.setLocales([...locales, trimmed]);
  }

  void _remove(String tag) {
    final locales = _locales.where((locale) => locale != tag).toList();
    widget.controller.setLocales(locales.isEmpty ? null : locales);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locales = _locales;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextField(
                key: const Key('device_preview_locale_input'),
                controller: _input,
                decoration: InputDecoration(
                  labelText: 'Add locale (language tag)',
                  hintText: 'fr-FR',
                  isDense: true,
                  border: const OutlineInputBorder(),
                  errorText: _error,
                ),
                onSubmitted: _add,
              ),
            ),
            const SizedBox(width: denseSpacing),
            DevToolsButton(
              icon: Icons.add,
              label: 'Add',
              onPressed: () => _add(_input.text),
            ),
            const SizedBox(width: denseSpacing),
            PopupMenuButton<String>(
              key: const Key('device_preview_common_locales'),
              tooltip: 'Add a common locale',
              icon: const Icon(Icons.language),
              onSelected: _add,
              itemBuilder: (context) => [
                for (final locale in _commonLocales)
                  PopupMenuItem(value: locale, child: Text(locale)),
              ],
            ),
          ],
        ),
        const SizedBox(height: denseSpacing),
        if (locales.isEmpty)
          Text(
            'Using the real device locales.',
            style: theme.textTheme.bodySmall!.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          )
        else
          Wrap(
            spacing: denseSpacing,
            runSpacing: densePadding,
            children: [
              for (var i = 0; i < locales.length; i++)
                InputChip(
                  label: Text(i == 0 ? '${locales[i]} (primary)' : locales[i]),
                  onDeleted: () => _remove(locales[i]),
                ),
              InputChip(
                key: const Key('device_preview_locales_clear'),
                label: const Text('Clear'),
                avatar: const Icon(Icons.close, size: defaultIconSize),
                onPressed: () => widget.controller.setLocales(null),
              ),
            ],
          ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Accessibility section
// ---------------------------------------------------------------------------

const Map<String, String> _accessibilityLabels = {
  'accessibleNavigation': 'Accessible navigation',
  'invertColors': 'Invert colors',
  'disableAnimations': 'Disable animations',
  'boldText': 'Bold text',
  'reduceMotion': 'Reduce motion',
  'highContrast': 'High contrast',
  'onOffSwitchLabels': 'On/off switch labels',
};

class _AccessibilitySection extends StatelessWidget {
  const _AccessibilitySection({required this.controller});

  final PanelController controller;

  @override
  Widget build(BuildContext context) {
    final accessibility =
        controller.simulation?['accessibility'] as Map? ?? const {};
    return Column(
      children: [
        for (final flag in kAccessibilityFlags) ...[
          _TriStateRow(
            label: _accessibilityLabels[flag] ?? flag,
            triKey: Key('device_preview_a11y_$flag'),
            value: accessibility[flag] as bool?,
            onChanged: (value) => controller.setAccessibilityFlag(flag, value),
          ),
          if (flag != kAccessibilityFlags.last)
            const SizedBox(height: densePadding),
        ],
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Platform section
// ---------------------------------------------------------------------------

const List<String> _targetPlatforms = [
  'android',
  'iOS',
  'macOS',
  'windows',
  'linux',
  'fuchsia',
];

class _PlatformSection extends StatelessWidget {
  const _PlatformSection({required this.controller});

  final PanelController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final capable = controller.state?.canTargetPlatform ?? false;
    final current = controller.simulation?['platform'] as String?;
    final dropdown = DropdownButton<String?>(
      key: const Key('device_preview_platform_dropdown'),
      value: current,
      isDense: true,
      items: [
        const DropdownMenuItem<String?>(
          value: null,
          child: Text('Real platform'),
        ),
        for (final platform in _targetPlatforms)
          DropdownMenuItem<String?>(value: platform, child: Text(platform)),
      ],
      onChanged:
          capable ? (value) => controller.setTargetPlatform(value) : null,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _LabeledRow(
          label: 'Target platform',
          child: capable
              ? dropdown
              : Tooltip(
                  message: 'Target platform simulation requires a debug '
                      'build of the app.',
                  child: dropdown,
                ),
        ),
        const SizedBox(height: densePadding),
        Text(
          'Applying a platform override triggers a reassemble (like a hot '
          'reload).',
          style: theme.textTheme.bodySmall!.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Shared small widgets
// ---------------------------------------------------------------------------

class _LabeledRow extends StatelessWidget {
  const _LabeledRow({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        SizedBox(
          width: 110,
          child: Text(label, style: theme.textTheme.bodyMedium),
        ),
        const SizedBox(width: denseSpacing),
        Expanded(child: Align(alignment: Alignment.centerLeft, child: child)),
      ],
    );
  }
}

/// A `System | On | Off` tri-state selector for a nullable boolean override.
///
/// [systemLabel] names the null position: what the app would do on its own.
/// For most overrides that is the real device ("System"); for touch input it
/// is the simulated one, so the row says "Auto".
class _TriStateRow extends StatelessWidget {
  const _TriStateRow({
    required this.label,
    required this.value,
    required this.onChanged,
    this.triKey,
    this.systemLabel = 'System',
  });

  final String label;
  final bool? value;
  final ValueChanged<bool?> onChanged;
  final Key? triKey;
  final String systemLabel;

  @override
  Widget build(BuildContext context) {
    final selected = switch (value) {
      null => 'system',
      true => 'on',
      false => 'off',
    };
    return _LabeledRow(
      label: label,
      child: SegmentedButton<String>(
        key: triKey,
        segments: [
          ButtonSegment(value: 'system', label: Text(systemLabel)),
          const ButtonSegment(value: 'on', label: Text('On')),
          const ButtonSegment(value: 'off', label: Text('Off')),
        ],
        selected: {selected},
        showSelectedIcon: false,
        onSelectionChanged: (selection) {
          onChanged(switch (selection.first) {
            'on' => true,
            'off' => false,
            _ => null,
          });
        },
      ),
    );
  }
}

// Example app for package:device_preview.
//
// The app itself is completely ordinary: a [MaterialApp] whose layout adapts
// to [MediaQuery]. The only device_preview-specific line is the call to
// [DevicePreview.enable] below — everything else is a
// regular Flutter app that happens to make the effects of a simulation easy
// to see:
//
//  * The "Characteristics" tab shows the live values the framework observes
//    (screen size, pixel ratio, safe areas, brightness, text scale, locale,
//    platform, accessibility flags). Apply a simulation and watch them change.
//  * The "Playground" tab is realistic scrollable content — cards, a list, a
//    text field (to exercise keyboard viewInsets) — with the safe-area
//    padding visualized as translucent bands.
//
// NOTE: the real control surface for device_preview is the DevTools
// extension ("Device Preview" tab in Dart DevTools). The buttons on the
// first tab exist only to demonstrate the programmatic Dart API
// (DevicePreview.controller); a production app would ship none of
// them.

import 'package:device_preview/device_preview.dart';
import 'package:device_preview/presets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  // The single integration point: install the device-preview binding before
  // runApp. In release builds this is behaviorally identical to
  // WidgetsFlutterBinding.ensureInitialized() (simulation defaults to
  // !kReleaseMode and the wrappers are never installed when disabled).
  DevicePreview.enable();
  runApp(const DevicePreviewExampleApp());
}

/// Root widget — a stock [MaterialApp] with light and dark themes so that
/// simulated [Brightness] changes are visible immediately.
class DevicePreviewExampleApp extends StatelessWidget {
  /// Creates the example app.
  const DevicePreviewExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Device Preview Example',
      // themeMode defaults to ThemeMode.system, which follows
      // MediaQuery.platformBrightnessOf — i.e. the simulated brightness.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
      ),
      home: const HomeShell(),
    );
  }
}

/// Adaptive two-tab shell: bottom [NavigationBar] on narrow screens, a
/// [NavigationRail] on wide ones. Simulating a tablet or desktop preset
/// flips the layout live — a quick sanity check that the simulated
/// [MediaQuery] size drives responsive code exactly like a real device.
class HomeShell extends StatefulWidget {
  /// Creates the shell.
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _selectedIndex = 0;

  static const List<NavigationDestination> _destinations =
      <NavigationDestination>[
        NavigationDestination(
          icon: Icon(Icons.phone_android_outlined),
          selectedIcon: Icon(Icons.phone_android),
          label: 'Characteristics',
        ),
        NavigationDestination(
          icon: Icon(Icons.widgets_outlined),
          selectedIcon: Icon(Icons.widgets),
          label: 'Playground',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    // MediaQuery-adaptive layout: this is the simulated size when a preset
    // is active.
    final bool wide = MediaQuery.sizeOf(context).width >= 600;

    final Widget page = switch (_selectedIndex) {
      0 => const CharacteristicsPage(),
      _ => const PlaygroundPage(),
    };

    if (wide) {
      return Scaffold(
        body: SafeArea(
          child: Row(
            children: <Widget>[
              NavigationRail(
                selectedIndex: _selectedIndex,
                onDestinationSelected: (int i) =>
                    setState(() => _selectedIndex = i),
                labelType: NavigationRailLabelType.all,
                destinations: <NavigationRailDestination>[
                  for (final NavigationDestination d in _destinations)
                    NavigationRailDestination(
                      icon: d.icon,
                      selectedIcon: d.selectedIcon,
                      label: Text(d.label),
                    ),
                ],
              ),
              const VerticalDivider(thickness: 1, width: 1),
              Expanded(child: page),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: page,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int i) => setState(() => _selectedIndex = i),
        destinations: _destinations,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 1 — live device characteristics
// ---------------------------------------------------------------------------

/// Shows every device characteristic the framework can observe, read straight
/// from [MediaQuery] (and friends) so the values update live as simulations
/// are applied from DevTools or from the demo buttons below.
class CharacteristicsPage extends StatelessWidget {
  /// Creates the page.
  const CharacteristicsPage({super.key});

  String _edgeInsets(EdgeInsets insets) =>
      'L ${insets.left.toStringAsFixed(1)} · '
      'T ${insets.top.toStringAsFixed(1)} · '
      'R ${insets.right.toStringAsFixed(1)} · '
      'B ${insets.bottom.toStringAsFixed(1)}';

  @override
  Widget build(BuildContext context) {
    // Everything below is plain framework API — no device_preview imports
    // needed to *observe* a simulation. MediaQuery.of registers this widget
    // for rebuilds, which is what makes the readout live.
    final MediaQueryData media = MediaQuery.of(context);
    final Locale locale = Localizations.localeOf(context);
    final List<Locale> platformLocales =
        View.of(context).platformDispatcher.locales;

    // A 16px reference reading makes the effect of non-trivial TextScaler
    // implementations visible as a single number.
    final double effectiveScale = media.textScaler.scale(16) / 16;

    return CustomScrollView(
      slivers: <Widget>[
        const SliverAppBar.large(title: Text('Device characteristics')),
        SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            const _ApiDemoCard(),
            _Section(
              title: 'Screen',
              children: <Widget>[
                _ValueRow(
                  'MediaQuery.size',
                  '${media.size.width.toStringAsFixed(1)} × '
                      '${media.size.height.toStringAsFixed(1)} logical px',
                ),
                _ValueRow(
                  'devicePixelRatio',
                  media.devicePixelRatio.toStringAsFixed(2),
                ),
                _ValueRow('orientation', media.orientation.name),
                _ValueRow(
                  'displayFeatures',
                  media.displayFeatures.isEmpty
                      ? 'none'
                      : media.displayFeatures
                            .map((ui) => ui.type.name)
                            .join(', '),
                ),
              ],
            ),
            _Section(
              title: 'Insets (logical px)',
              children: <Widget>[
                _ValueRow('padding', _edgeInsets(media.padding)),
                _ValueRow('viewPadding', _edgeInsets(media.viewPadding)),
                _ValueRow(
                  'viewInsets (keyboard)',
                  _edgeInsets(media.viewInsets),
                ),
                _ValueRow(
                  'systemGestureInsets',
                  _edgeInsets(media.systemGestureInsets),
                ),
              ],
            ),
            _Section(
              title: 'Appearance & text',
              children: <Widget>[
                _ValueRow('platformBrightness', media.platformBrightness.name),
                _ValueRow(
                  'textScaler',
                  '×${effectiveScale.toStringAsFixed(2)}',
                ),
                _ValueRow(
                  'alwaysUse24HourFormat',
                  '${media.alwaysUse24HourFormat}',
                ),
              ],
            ),
            _Section(
              title: 'Locale & platform',
              children: <Widget>[
                _ValueRow('Localizations.localeOf', locale.toLanguageTag()),
                _ValueRow(
                  'PlatformDispatcher.locales',
                  platformLocales
                      .map((Locale l) => l.toLanguageTag())
                      .join(', '),
                ),
                _ValueRow('defaultTargetPlatform', defaultTargetPlatform.name),
              ],
            ),
            _Section(
              title: 'Accessibility',
              children: <Widget>[
                _FlagRow('accessibleNavigation', media.accessibleNavigation),
                _FlagRow('boldText', media.boldText),
                _FlagRow('disableAnimations', media.disableAnimations),
                _FlagRow('highContrast', media.highContrast),
                _FlagRow('invertColors', media.invertColors),
                _FlagRow('onOffSwitchLabels', media.onOffSwitchLabels),
              ],
            ),
            const SizedBox(height: 24),
          ]),
        ),
      ],
    );
  }
}

/// A handful of buttons exercising the programmatic API.
///
/// This exists purely to demonstrate [DevicePreviewController] from Dart —
/// the intended day-to-day control surface is the DevTools extension, which
/// drives the very same controller over the VM service.
class _ApiDemoCard extends StatelessWidget {
  const _ApiDemoCard();

  /// The controller, or null when simulation is disabled (e.g. release mode).
  DevicePreviewController? get _controller =>
      DevicePreview.maybeController;

  Future<void> _toggleOrientation(BuildContext context) async {
    final DevicePreviewController? c = _controller;
    if (c == null) {
      return;
    }
    final DeviceSimulation? simulation = c.simulation;
    if (simulation == null || !simulation.simulatesMetrics) {
      // Orientation is a property of the *simulated* screen; without a
      // simulated screen size there is nothing to rotate.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Apply a device preset first, then rotate it.'),
        ),
      );
      return;
    }
    await c.setOrientation(
      simulation.orientation == Orientation.portrait
          ? Orientation.landscape
          : Orientation.portrait,
    );
  }

  Future<void> _toggleBrightness() async {
    final DevicePreviewController? c = _controller;
    if (c == null) {
      return;
    }
    final bool simulatedDark =
        c.simulation?.platformBrightness == Brightness.dark;
    // copyWith uses a sentinel default, so explicitly passing null CLEARS
    // the override and reverts to the real device brightness.
    await c.update(
      (DeviceSimulation s) => s.copyWith(
        platformBrightness: simulatedDark ? null : Brightness.dark,
      ),
    );
  }

  Future<void> _toggleTextScale() async {
    final DevicePreviewController? c = _controller;
    if (c == null) {
      return;
    }
    final bool scaled = c.simulation?.textScaleFactor == 2.0;
    await c.update(
      (DeviceSimulation s) => s.copyWith(textScaleFactor: scaled ? null : 2.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final DevicePreviewController? controller = _controller;
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.info_outline,
                  size: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    controller == null
                        ? 'Simulation is disabled in this build mode.'
                        : 'The real control surface is the Device Preview '
                              'tab in DevTools. These buttons just demo the '
                              'Dart API.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
            if (controller != null) ...<Widget>[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  FilledButton.tonal(
                    onPressed: () =>
                        controller.applyPreset(DevicePresets.iPhoneSe3),
                    child: const Text('iPhone SE preset'),
                  ),
                  FilledButton.tonal(
                    onPressed: () => _toggleOrientation(context),
                    child: const Text('Toggle orientation'),
                  ),
                  FilledButton.tonal(
                    onPressed: _toggleBrightness,
                    child: const Text('Toggle dark brightness'),
                  ),
                  FilledButton.tonal(
                    onPressed: _toggleTextScale,
                    child: const Text('Toggle text scale 2.0'),
                  ),
                  OutlinedButton(
                    onPressed: controller.reset,
                    child: const Text('Reset'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// A titled group of value rows.
class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 4),
          ...children,
        ],
      ),
    );
  }
}

/// A single "label: value" line, tabular-styled.
class _ValueRow extends StatelessWidget {
  const _ValueRow(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: Text(label, style: text.bodyMedium)),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: text.bodyMedium?.copyWith(fontFamily: 'monospace'),
            ),
          ),
        ],
      ),
    );
  }
}

/// A boolean accessibility flag rendered as a small on/off chip.
class _FlagRow extends StatelessWidget {
  const _FlagRow(this.label, this.value);

  final String label;
  final bool value;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: <Widget>[
          Expanded(child: Text(label)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: value ? colors.primaryContainer : colors.surfaceContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              value ? 'on' : 'off',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: value
                    ? colors.onPrimaryContainer
                    : colors.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 2 — realistic content playground
// ---------------------------------------------------------------------------

/// Realistic scrollable content to eyeball a simulation with: cards, a list,
/// a text field (tap it to see keyboard `viewInsets` flow into the layout),
/// and translucent bands visualizing the safe-area `padding`.
class PlaygroundPage extends StatelessWidget {
  /// Creates the page.
  const PlaygroundPage({super.key});

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.paddingOf(context);
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Stack(
      children: <Widget>[
        CustomScrollView(
          slivers: <Widget>[
            const SliverAppBar.medium(title: Text('Playground')),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  // A text field. While a device is simulated the app only
                  // ever sees the *simulated* keyboard (the panel's Keyboard
                  // switch, or `keyboardInset` from Dart): the host's own
                  // keyboard belongs to another screen and is kept out.
                  TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Try the keyboard',
                      helperText:
                          'viewInsets show the simulated keyboard on the '
                          'first tab',
                      prefixIcon: const Icon(Icons.keyboard_alt_outlined),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // A few cards with mixed content, like a real app screen.
                  for (int i = 0; i < 3; i++)
                    Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Card ${i + 1}',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Body text reflows with the simulated screen '
                              'width and scales with the simulated text '
                              'scale factor. Toggle presets in DevTools and '
                              'watch this paragraph adapt.',
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 4),
                ]),
              ),
            ),
            // A longer list to make scrolling (and fling physics under the
            // remapped pointer coordinates) easy to test.
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) => ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text('List item ${index + 1}'),
                  subtitle: const Text('Scroll and fling to test input'),
                ),
                childCount: 30,
              ),
            ),
            // Keep the last items reachable above the bottom safe area.
            SliverToBoxAdapter(child: SizedBox(height: padding.bottom + 16)),
          ],
        ),
        // Safe-area visualization: translucent bands over the padding
        // regions. With an iPhone preset active you should see the notch
        // band at the top and the home-indicator band at the bottom.
        IgnorePointer(
          child: Stack(
            children: <Widget>[
              _SafeAreaBand.top(padding.top, colors),
              _SafeAreaBand.bottom(padding.bottom, colors),
              _SafeAreaBand.left(padding.left, colors),
              _SafeAreaBand.right(padding.right, colors),
            ],
          ),
        ),
      ],
    );
  }
}

/// One translucent edge band visualizing a safe-area inset.
class _SafeAreaBand extends StatelessWidget {
  const _SafeAreaBand.top(this.extent, this.colors)
    : left = 0,
      top = 0,
      right = 0,
      bottom = null,
      horizontal = true;

  const _SafeAreaBand.bottom(this.extent, this.colors)
    : left = 0,
      top = null,
      right = 0,
      bottom = 0,
      horizontal = true;

  const _SafeAreaBand.left(this.extent, this.colors)
    : left = 0,
      top = 0,
      right = null,
      bottom = 0,
      horizontal = false;

  const _SafeAreaBand.right(this.extent, this.colors)
    : left = null,
      top = 0,
      right = 0,
      bottom = 0,
      horizontal = false;

  final double extent;
  final ColorScheme colors;
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
  final bool horizontal;

  @override
  Widget build(BuildContext context) {
    if (extent <= 0) {
      return const SizedBox.shrink();
    }
    return Positioned(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      child: Container(
        height: horizontal ? extent : null,
        width: horizontal ? null : extent,
        color: colors.tertiary.withValues(alpha: 0.15),
      ),
    );
  }
}

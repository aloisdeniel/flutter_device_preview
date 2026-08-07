// "Device lab" — the richer of the two demo apps embedded in the landing
// page (`docs/index.html`), built to make every control of the panel visibly
// do something:
//
//  * The header paints edge to edge, so the simulated status bar, notch and
//    Dynamic Island sit over real content, and every non-zero safe-area side
//    is marked by a labeled band (`MediaQuery.padding`).
//  * A live clock follows the simulated locale and the 24-hour toggle, and
//    the date line is formatted with the simulated locale's own calendar
//    strings (via `flutter_localizations`).
//  * The greeting is translated for each locale the panel offers — Arabic
//    also flips the whole app to RTL.
//  * Foldable presets split the layout into two panes around the hinge
//    (`MediaQuery.displayFeatures`).
//  * A pulsing ring animates continuously — unless the simulation asks for
//    animations to be disabled — and the metric chips (size, DPR,
//    orientation, text scale) re-read `MediaQuery` on every change.
//
// Like `counter.dart`, this is an ordinary Flutter app: the only
// device_preview-specific lines are in [main].
//
// Build the web bundle with `tool/build_demo.sh` at the root of the
// repository (its entry point, `demo.dart`, embeds both demo apps).

import 'dart:async';
import 'dart:ui' show DisplayFeature, DisplayFeatureType;

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'src/demo_bridge.dart';
import 'src/demo_theme.dart';

void main() {
  // `true` rather than the default: the demo is a *release* web build, where
  // simulation would otherwise be off.
  DevicePreview.enable(enabled: true, padding: const EdgeInsets.all(16));
  connectDemoPanel(DevicePreview.maybeController);
  runApp(const ShowcaseApp());
}

/// The greeting, translated for every locale the demo panel offers.
const Map<String, String> _greetings = <String, String>{
  'en': 'Hello!',
  'fr': 'Bonjour !',
  'de': 'Hallo!',
  'es': '¡Hola!',
  'it': 'Ciao!',
  'pt': 'Olá!',
  'nl': 'Hallo!',
  'ru': 'Привет!',
  'ja': 'こんにちは',
  'ko': '안녕하세요',
  'zh': '你好',
  'ar': 'مرحبًا',
  'hi': 'नमस्ते',
};

/// Root widget of the showcase.
class ShowcaseApp extends StatelessWidget {
  /// Creates the showcase app.
  const ShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'device_preview showcase',
      debugShowCheckedModeBanner: false,
      // ThemeMode.system follows the simulated platform brightness.
      theme: demoTheme(demoLightScheme),
      darkTheme: demoTheme(demoDarkScheme),
      // Real localization: the delegates load per-locale Material strings
      // and date symbols, and locale resolution follows
      // PlatformDispatcher.locales — i.e. the simulated locale list. Arabic
      // flips the Directionality of the whole app.
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: <Locale>[
        for (final String language in _greetings.keys) Locale(language),
      ],
      home: const DeviceLabPage(),
    );
  }
}

/// The single screen of the showcase.
class DeviceLabPage extends StatefulWidget {
  /// Creates the screen.
  const DeviceLabPage({super.key});

  @override
  State<DeviceLabPage> createState() => _DeviceLabPageState();
}

class _DeviceLabPageState extends State<DeviceLabPage> {
  late final Timer _ticker;

  @override
  void initState() {
    super.initState();
    // Keeps the clock card live; cheap enough to leave always on.
    _ticker = Timer.periodic(
      const Duration(seconds: 1),
      (_) => setState(() {}),
    );
  }

  @override
  void dispose() {
    _ticker.cancel();
    super.dispose();
  }

  /// The vertical hinge or fold of the simulated device, when there is one
  /// that spans the screen top to bottom (a book-style foldable in portrait).
  Rect? _verticalHinge(MediaQueryData media) {
    for (final DisplayFeature feature in media.displayFeatures) {
      final bool spansHeight =
          feature.bounds.top <= 0 &&
          feature.bounds.bottom >= media.size.height;
      if (feature.type != DisplayFeatureType.cutout && spansHeight) {
        return feature.bounds;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final ColorScheme colors = Theme.of(context).colorScheme;
    final Rect? hinge = _verticalHinge(media);

    final Widget content = hinge == null
        ? _SinglePane(media: media)
        : _HingePanes(media: media, hinge: hinge);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          content,
          // The safe areas, marked and labeled. Pick a notched preset and
          // the top band frames the cutout; rotate it and the bands move to
          // the sides — exactly what SafeArea would be protecting you from.
          IgnorePointer(child: _SafeAreaBands(padding: media.padding)),
          if (hinge != null)
            // Shade the hinge itself, so "the app avoids it" reads at a
            // glance.
            Positioned.fromRect(
              rect: hinge,
              child: IgnorePointer(
                child: ColoredBox(color: colors.outline.withValues(alpha: .25)),
              ),
            ),
        ],
      ),
    );
  }
}

/// The regular one-column layout.
class _SinglePane extends StatelessWidget {
  const _SinglePane({required this.media});

  final MediaQueryData media;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        const SliverToBoxAdapter(child: _Header()),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            16 + media.padding.left,
            16,
            16 + media.padding.right,
            16 + media.padding.bottom,
          ),
          sliver: SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              const _ClockCard(),
              const SizedBox(height: 12),
              _MetricsCard(media: media),
              const SizedBox(height: 12),
              const _TypeCard(),
            ]),
          ),
        ),
      ],
    );
  }
}

/// The foldable layout: header and clock on one side of the hinge, the
/// metric cards on the other.
class _HingePanes extends StatelessWidget {
  const _HingePanes({required this.media, required this.hinge});

  final MediaQueryData media;
  final Rect hinge;

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = media.padding;
    // Pane widths in paint order; `Directionality` must not flip them, since
    // the hinge is a physical location.
    final double leftWidth = hinge.left;
    final double rightWidth = media.size.width - hinge.right;
    return Row(
      textDirection: TextDirection.ltr,
      children: <Widget>[
        SizedBox(
          width: leftWidth,
          child: ListView(
            padding: EdgeInsets.fromLTRB(
              16 + padding.left,
              0,
              16,
              16 + padding.bottom,
            ),
            children: const <Widget>[
              _Header(inPane: true),
              _ClockCard(),
            ],
          ),
        ),
        SizedBox(width: hinge.width),
        SizedBox(
          width: rightWidth,
          child: ListView(
            padding: EdgeInsets.fromLTRB(
              16,
              16 + padding.top,
              16 + padding.right,
              16 + padding.bottom,
            ),
            children: <Widget>[
              _MetricsCard(media: media),
              const SizedBox(height: 12),
              const _TypeCard(),
            ],
          ),
        ),
      ],
    );
  }
}

/// The edge-to-edge gradient header: greeting, date line, metric chips and
/// the pulsing ring.
class _Header extends StatelessWidget {
  const _Header({this.inPane = false});

  /// Whether the header renders inside a foldable pane (narrower, and the
  /// scroll view already handles the horizontal safe areas).
  final bool inPane;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme text = Theme.of(context).textTheme;
    final Locale locale = Localizations.localeOf(context);

    final String greeting =
        _greetings[locale.languageCode] ?? _greetings['en']!;
    // Locale-formatted date, e.g. "Saturday, August 8, 2026" / "samedi 8
    // août 2026" — the symbols come from the localization delegates.
    final String date = DateFormat.yMMMMEEEEd(
      locale.toLanguageTag(),
    ).format(DateTime.now());

    return Container(
      // No SafeArea on purpose: the gradient runs under the simulated status
      // bar and cutout; the *content* below starts under padding.top.
      padding: EdgeInsets.fromLTRB(
        20 + (inPane ? 0 : media.padding.left),
        20 + media.padding.top,
        20 + (inPane ? 0 : media.padding.right),
        24,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            colors.primaryContainer,
            colors.surface,
          ],
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  greeting,
                  style: text.headlineMedium!.copyWith(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: text.bodyMedium!.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: <Widget>[
                    _Chip(
                      '${media.size.width.round()} × '
                      '${media.size.height.round()}',
                    ),
                    _Chip('@${media.devicePixelRatio.toStringAsFixed(1)}x'),
                    _Chip(media.orientation.name),
                    if (media.textScaler.scale(16) != 16)
                      _Chip(
                        '×${(media.textScaler.scale(16) / 16).toStringAsFixed(2)} text',
                      ),
                    if (media.boldText) const _Chip('bold text'),
                    if (media.highContrast) const _Chip('high contrast'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const _PulsingRing(),
        ],
      ),
    );
  }
}

/// A small mono-styled metric chip.
class _Chip extends StatelessWidget {
  const _Chip(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: colors.surfaceContainer.withValues(alpha: .7),
        border: Border.all(color: colors.outlineVariant),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall!.copyWith(
          color: colors.onSurfaceVariant,
          fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
        ),
      ),
    );
  }
}

/// A ring that pulses forever — except when the simulation disables
/// animations, which freezes it (the `disableAnimations` /
/// `reduceMotion`-style accessibility toggle in the panel).
class _PulsingRing extends StatefulWidget {
  const _PulsingRing();

  @override
  State<_PulsingRing> createState() => _PulsingRingState();
}

class _PulsingRingState extends State<_PulsingRing>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Re-evaluated on every MediaQuery change: flipping the panel's
    // "No animations" toggle stops or restarts the pulse.
    final bool animate = !MediaQuery.disableAnimationsOf(context);
    if (animate && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!animate && _controller.isAnimating) {
      _controller.stop();
      _controller.value = 0;
    }
    final ColorScheme colors = Theme.of(context).colorScheme;
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        final double t = Curves.easeInOut.transform(
          (_controller.value < .5 ? _controller.value : 1 - _controller.value) *
              2,
        );
        return Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: colors.primary, width: 2 + 4 * t),
            color: colors.primary.withValues(alpha: .10 + .15 * t),
          ),
          child: Icon(Icons.science_outlined, color: colors.primary, size: 22),
        );
      },
    );
  }
}

/// A live clock following the simulated locale and 24-hour preference.
class _ClockCard extends StatelessWidget {
  const _ClockCard();

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme text = Theme.of(context).textTheme;
    // TimeOfDay.format resolves through MaterialLocalizations *and*
    // MediaQuery.alwaysUse24HourFormat — both simulated.
    final String time = TimeOfDay.now().format(context);
    final bool h24 = MediaQuery.alwaysUse24HourFormatOf(context);
    return _DemoCard(
      icon: Icons.schedule,
      title: time,
      titleStyle: text.displaySmall!.copyWith(
        color: colors.primary,
        fontWeight: FontWeight.w800,
        letterSpacing: -1,
        fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
      ),
      subtitle:
          'Locale ${Localizations.localeOf(context).toLanguageTag()} · '
          '${h24 ? '24-hour' : '12-hour'} format',
    );
  }
}

/// The safe-area and hinge numbers, straight from [MediaQuery].
class _MetricsCard extends StatelessWidget {
  const _MetricsCard({required this.media});

  final MediaQueryData media;

  String _insets(EdgeInsets insets) => insets == EdgeInsets.zero
      ? 'none'
      : 'L ${insets.left.round()} · T ${insets.top.round()} · '
            'R ${insets.right.round()} · B ${insets.bottom.round()}';

  @override
  Widget build(BuildContext context) {
    final List<DisplayFeature> features = media.displayFeatures;
    return _DemoCard(
      icon: Icons.smartphone,
      title: 'What this app is told',
      rows: <(String, String)>[
        ('safe area', _insets(media.padding)),
        ('view padding', _insets(media.viewPadding)),
        ('gesture insets', _insets(media.systemGestureInsets)),
        (
          'display features',
          features.isEmpty
              ? 'none'
              : features
                    .map(
                      (DisplayFeature f) =>
                          '${f.type.name} ${f.bounds.width.round()} × '
                          '${f.bounds.height.round()}',
                    )
                    .join(', '),
        ),
        ('brightness', media.platformBrightness.name),
      ],
      subtitle:
          'Plain MediaQuery reads — no device_preview import anywhere on '
          'this screen.',
    );
  }
}

/// A paragraph that reflows and rescales with the simulation.
class _TypeCard extends StatelessWidget {
  const _TypeCard();

  @override
  Widget build(BuildContext context) {
    return const _DemoCard(
      icon: Icons.text_fields,
      title: 'Typography',
      subtitle:
          'This paragraph wraps with the simulated width and scales with '
          'the text-scale slider. Bold text, high contrast and the other '
          'accessibility flags land here exactly as they would on a real '
          'device.',
    );
  }
}

/// Shared card chrome for the showcase sections.
class _DemoCard extends StatelessWidget {
  const _DemoCard({
    required this.icon,
    required this.title,
    this.titleStyle,
    this.rows = const <(String, String)>[],
    this.subtitle,
  });

  final IconData icon;
  final String title;
  final TextStyle? titleStyle;
  final List<(String, String)> rows;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme text = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        border: Border.all(color: colors.outlineVariant),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(icon, size: 18, color: colors.secondary),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style:
                      titleStyle ??
                      text.titleMedium!.copyWith(
                        color: colors.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ],
          ),
          for (final (String label, String value) in rows)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Text(
                      label,
                      style: text.bodySmall!.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      value,
                      textAlign: TextAlign.end,
                      style: text.bodySmall!.copyWith(
                        color: colors.onSurface,
                        fontFeatures: const <FontFeature>[
                          FontFeature.tabularFigures(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                subtitle!,
                style: text.bodySmall!.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Labeled translucent bands over every non-zero safe-area side.
class _SafeAreaBands extends StatelessWidget {
  const _SafeAreaBands({required this.padding});

  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final Color fill = colors.tertiary.withValues(alpha: .12);
    final TextStyle label = Theme.of(context).textTheme.labelSmall!.copyWith(
      color: colors.tertiary,
      fontSize: 9,
    );

    Widget band({
      double? left,
      double? top,
      double? right,
      double? bottom,
      double? width,
      double? height,
      required double value,
    }) {
      return Positioned(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
        width: width,
        height: height,
        child: Container(
          alignment: Alignment.center,
          color: fill,
          child: Text('${value.round()}', style: label),
        ),
      );
    }

    return Stack(
      textDirection: TextDirection.ltr,
      children: <Widget>[
        if (padding.top > 0)
          band(left: 0, top: 0, right: 0, height: padding.top,
              value: padding.top),
        if (padding.bottom > 0)
          band(left: 0, right: 0, bottom: 0, height: padding.bottom,
              value: padding.bottom),
        if (padding.left > 0)
          band(left: 0, top: padding.top, bottom: padding.bottom,
              width: padding.left, value: padding.left),
        if (padding.right > 0)
          band(right: 0, top: padding.top, bottom: padding.bottom,
              width: padding.right, value: padding.right),
      ],
    );
  }
}

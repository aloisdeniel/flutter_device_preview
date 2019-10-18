import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

// Sets a platform override for desktop to avoid exceptions. See
// https://flutter.dev/desktop#target-platform-override for more info.
void _enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() {
  _enablePlatformOverrideForDesktop();
  runApp(DevicePreview(
    builder: (context) => MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return PlatformApp(
      title: 'Flutter Demo',
      locale: DevicePreview.of(context).locale, // <--
      builder: DevicePreview.appBuilder, // <--
      supportedLocales: const [
        Locale("en"),
        Locale("fr", "FR"),
        Locale.fromSubtags(
          languageCode: "zh",
          scriptCode: "Hans",
          countryCode: "CN",
        ),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      android: (_) => MaterialAppData(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: mediaQuery.platformBrightness == Brightness.dark
            ? ThemeMode.dark
            : ThemeMode.light,
      ),
      ios: (_) => CupertinoAppData(theme: CupertinoThemeData()),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    final factor = mediaQuery.textScaleFactor;
    final localeCode = Localizations.localeOf(context).toString();
    final dateFormat = DateFormat.yMMMMEEEEd(localeCode);
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // If not precised `textScaleFactor`
            // is inherited from mediaQuery
            PlatformText(
              'Hello, it is ' + dateFormat.format(DateTime.now()),
              style: theme.textTheme.headline,
            ),
            PlatformText(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
    );
  }
}

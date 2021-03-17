import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class BasicApp extends StatelessWidget {
  const BasicApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      locale: WidgetsBinding.instance!.window.locale,
      supportedLocales: [
        Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
        Locale.fromSubtags(languageCode: 'fr', countryCode: 'FR'),
      ],
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Basic'),
      ),
      body: PageView(
        children: [
          ScrollExample(),
          Info(
            media: media,
          ),
        ],
      ),
    );
  }
}

class ScrollExample extends StatelessWidget {
  const ScrollExample({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...Iterable.generate(
          100,
          (i) => ListTile(
            title: Text('Tile $i'),
            onTap: () {},
          ),
        )
      ],
    );
  }
}

class Info extends StatelessWidget {
  const Info({
    Key? key,
    required this.media,
  }) : super(key: key);

  final MediaQueryData media;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        Text('locale: ${locale}'),
        Text('devicePixelRatio: ${media.devicePixelRatio}'),
        Text('padding: ${media.padding}'),
        Text('size: ${media.size}'),
        Text('viewInsets: ${media.viewInsets}'),
        Text('textScaleFactor: ${media.textScaleFactor}'),
        Text('platformBrightness: ${media.platformBrightness}'),
        Text('boldText: ${media.boldText}'),
      ],
    );
  }
}

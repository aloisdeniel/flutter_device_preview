import 'package:devtools_device_preview/devtools_device_preview.dart';
import 'package:flutter/material.dart';

void main() {
  DevicePreviewDevtools.enable();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListView(
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ListTile(
              title: const Text('Set landscape orientation'),
              onTap: () {
                DevicePreviewDevtools.setOrientation(Orientation.landscape);
              },
            ),
            ListTile(
              title: const Text('Set portrait orientation'),
              onTap: () {
                DevicePreviewDevtools.setOrientation(Orientation.portrait);
              },
            ),
            ListTile(
              title: const Text('Set bold text on'),
              onTap: () {
                DevicePreviewDevtools.setBoldText(true);
              },
            ),
            ListTile(
              title: const Text('Set bold text off'),
              onTap: () {
                DevicePreviewDevtools.setBoldText(false);
              },
            ),
            ListTile(
              title: const Text('Set brightness to dark'),
              onTap: () {
                DevicePreviewDevtools.setBrightness(Brightness.dark);
              },
            ),
            ListTile(
              title: const Text('Set brightness to light'),
              onTap: () {
                DevicePreviewDevtools.setBrightness(Brightness.light);
              },
            ),
            ListTile(
              title: const Text('Switch to iPhone12Mini'),
              onTap: () {
                DevicePreviewDevtools.setDevice(Devices.ios.iPhone12Mini);
              },
            ),
            ListTile(
              title: const Text('Switch to samsungGalaxyNote20Ultra'),
              onTap: () {
                DevicePreviewDevtools.setDevice(
                    Devices.android.samsungGalaxyNote20Ultra);
              },
            ),
            ListTile(
              title: const Text('Switch to iPadAir4'),
              onTap: () {
                DevicePreviewDevtools.setDevice(Devices.ios.iPadAir4);
              },
            ),
            ListTile(
              title: const Text('Switch to wideMonitor'),
              onTap: () {
                DevicePreviewDevtools.setDevice(Devices.windows.wideMonitor);
              },
            ),
            ListTile(
              title: const Text('Disable'),
              onTap: () {
                DevicePreviewDevtools.setDevice(null);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

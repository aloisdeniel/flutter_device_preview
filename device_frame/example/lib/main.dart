import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ExampleApp());
}

class ExampleApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _ExampleAppState createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  bool isDark = true;
  bool hasShadow = true;
  bool isKeyboard = false;
  List<DeviceIdentifier> allDevices = [
    ...Devices.ios.all,
    ...Devices.android.all,
    ...Devices.macos.all,
    ...Devices.windows.all,
  ];
  Orientation orientation = Orientation.portrait;
  Widget _frame(DeviceIdentifier id) => Center(
        child: DeviceFrame.identifier(
          identifier: id,
          isFrameVisible: hasShadow,
          orientation: orientation,
          screen: Container(
            color: Colors.blue,
            child: VirtualKeyboard(
              isEnabled: isKeyboard,
              child: FakeScreen(),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    var style = isDark ? DeviceFrameStyle.dark() : DeviceFrameStyle.light();

    return DeviceFrameTheme(
      style: style,
      child: MaterialApp(
        title: 'Device Frames',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: DefaultTabController(
          length: allDevices.length,
          child: Scaffold(
            backgroundColor: isDark ? Colors.white : Colors.black,
            appBar: AppBar(
              title: Text('Device Frames'),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    setState(() {
                      hasShadow = !hasShadow;
                    });
                  },
                  icon: Icon(Icons.settings_brightness),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isDark = !isDark;
                    });
                  },
                  icon: Icon(Icons.brightness_medium),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      orientation = orientation == Orientation.landscape
                          ? Orientation.portrait
                          : Orientation.landscape;
                    });
                  },
                  icon: Icon(Icons.rotate_90_degrees_ccw),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isKeyboard = !isKeyboard;
                    });
                  },
                  icon: Icon(Icons.keyboard),
                ),
              ],
              bottom: TabBar(
                isScrollable: true,
                tabs: [
                  ...allDevices.map((x) => Tab(text: '${x.type} ${x.name}')),
                ],
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Builder(
                  builder: (context) => AnimatedBuilder(
                    animation: DefaultTabController.of(context),
                    builder: (context, _) => _frame(
                        allDevices[DefaultTabController.of(context).index]),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FakeScreen extends StatefulWidget {
  @override
  _FakeScreenState createState() => _FakeScreenState();
}

class _FakeScreenState extends State<FakeScreen> {
  bool isDelayEnded = false;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then(
      (value) => setState(
        () => isDelayEnded = true,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final color =
        theme.platform == TargetPlatform.iOS ? Colors.cyan : Colors.green;
    return Container(
      color: color.shade300,
      padding: mediaQuery.padding,
      child: Container(
        color: color,
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 500),
          padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("${theme.platform}"),
              Text("Size: ${mediaQuery.size.width}x${mediaQuery.size.height}"),
              Text("PixelRatio: ${mediaQuery.devicePixelRatio}"),
              Text("Padding: ${mediaQuery.padding}"),
              Text("Insets: ${mediaQuery.viewInsets}"),
              Text("ViewPadding: ${mediaQuery.viewPadding}"),
              if (isDelayEnded) Text("---"),
            ],
          ),
        ),
      ),
    );
  }
}

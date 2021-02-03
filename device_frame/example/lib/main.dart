import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
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
  bool isEnabled = true;

  @override
  void initState() {
    DeviceFrame.precache(context);
    super.initState();
  }

  final GlobalKey screenKey = GlobalKey();
  List<DeviceInfo> allDevices = [
    ...Devices.ios.all,
    ...Devices.android.all,
    ...Devices.macos.all,
    ...Devices.windows.all,
    ...Devices.linux.all,
  ];
  Orientation orientation = Orientation.portrait;
  Widget _frame(DeviceInfo device) => Center(
        child: DeviceFrame(
          device: device,
          isFrameVisible: hasShadow,
          orientation: orientation,
          screen: Container(
            color: Colors.blue,
            child: VirtualKeyboard(
              isEnabled: isKeyboard,
              child: FakeScreen(key: screenKey),
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
                /*IconButton(
                  onPressed: () {
                    setState(() {
                      isEnabled = !isEnabled;
                    });
                  },
                  icon: Icon(Icons.check),
                ),*/
              ],
              bottom: TabBar(
                isScrollable: true,
                tabs: [
                  ...allDevices
                      .map((x) => Tab(text: '${x.identifier.type} ${x.name}')),
                ],
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Builder(
                  builder: (context) => !isEnabled
                      ? FakeScreen(key: screenKey)
                      : AnimatedBuilder(
                          animation: DefaultTabController.of(context),
                          builder: (context, _) => _frame(allDevices[
                              DefaultTabController.of(context).index]),
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
  const FakeScreen({Key key}) : super(key: key);
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

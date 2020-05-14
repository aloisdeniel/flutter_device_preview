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
  Orientation orientation = Orientation.portrait;
  @override
  Widget build(BuildContext context) {
    var style = isDark ? DeviceFrameStyle.dark() : DeviceFrameStyle.light();
    if (!hasShadow) {
      style = style.copyWith(
        shadowColor: Colors.transparent,
      );
    }
    return DeviceFrameTheme(
      style: style,
      child: MaterialApp(
        title: 'Device Frames',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: DefaultTabController(
          length: CupertinoDevice.values.length + AndroidDevice.values.length,
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
                  ...CupertinoDevice.values.map(
                    (d) => Tab(
                      text: d.toString().replaceAll('$CupertinoDevice.', ''),
                    ),
                  ),
                  ...AndroidDevice.values.map(
                    (d) => Tab(
                      text: d.toString().replaceAll('$AndroidDevice.', ''),
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                ...CupertinoDevice.values.map(
                  (device) => CupertinoDeviceFrame(
                    orientation: orientation,
                    isKeyboardVisible: isKeyboard,
                    device: device,
                    child: FakeScreen(),
                  ),
                ),
                ...AndroidDevice.values.map(
                  (device) => AndroidDeviceFrame(
                    orientation: orientation,
                    isKeyboardVisible: isKeyboard,
                    device: device,
                    child: FakeScreen(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FakeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return Container(
      color: theme.platform == TargetPlatform.iOS ? Colors.cyan : Colors.green,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 500),
        padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("${theme.platform}"),
              Text("Size: ${mediaQuery.size.width}x${mediaQuery.size.height}"),
              Text("PixelRatio: ${mediaQuery.devicePixelRatio}"),
              Text("Padding: ${mediaQuery.padding}"),
              Text("Insets: ${mediaQuery.viewInsets}"),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/widgets.dart';

class MediaQueryObserver extends StatefulWidget {
  final Widget child;

  const MediaQueryObserver({
    @required this.child,
  });

  @override
  _MediaQueryObserverState createState() => _MediaQueryObserverState();
}

class _MediaQueryObserverState extends State<MediaQueryObserver>
    with WidgetsBindingObserver {
  @override
  void didChangeMetrics() {
    setState(() {});
    super.didChangeMetrics();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window),
      child: widget.child,
    );
  }
}

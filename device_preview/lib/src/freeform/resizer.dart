import 'package:flutter/material.dart';

import '../device_preview.dart';

class FreeformResizer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final preview = DevicePreview.of(context);
    final media = DevicePreview.mediaQuery(context);
    const activeColor = Color(0XFF444444);
    const inactiveColor = Color(0XFFAAAAAA);
    return Container(
      height: 48,
      padding: EdgeInsets.all(12.0),
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Slider(
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          value: preview.freeformSize.width,
          min: 50,
          max: DevicePreviewState.freeformMaxSize.width,
          onChanged: (v) {
            preview.freeformSize = Size(v, preview.freeformSize.height);
          },
        ),
        SizedBox(
            width: 32,
            child: Text(
              media.size.width.round().toString(),
              textAlign: TextAlign.center,
              style: TextStyle(color: activeColor, fontSize: 11.0),
            )),
        Text(
          " x ",
          textAlign: TextAlign.center,
          style: TextStyle(color: inactiveColor, fontSize: 11.0),
        ),
        SizedBox(
          width: 32,
          child: Text(
            media.size.height.round().toString(),
            textAlign: TextAlign.center,
            style: TextStyle(color: activeColor, fontSize: 11.0),
          ),
        ),
        Slider(
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          value: preview.freeformSize.height,
          min: 50,
          max: DevicePreviewState.freeformMaxSize.height,
          onChanged: (v) {
            preview.freeformSize = Size(preview.freeformSize.width, v);
          },
        ),
      ]),
    );
  }
}

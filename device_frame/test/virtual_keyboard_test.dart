import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('keyboard rows fit in the reserved keyboard height',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: VirtualKeyboard(
          isEnabled: true,
          transitionDuration: Duration.zero,
          child: SizedBox.expand(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}

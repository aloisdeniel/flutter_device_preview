part of 'device.dart';

// Generated with https://fluttershapemaker.com and manually adjusted.
class _FramePainter extends CustomPainter {
  const _FramePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final buttonsPath = Path()
      ..moveTo(780, 442)
      ..lineTo(785.25, 442)
      ..cubicTo(786.216, 442, 787, 442.807, 787, 443.803)
      ..lineTo(787, 559.197)
      ..cubicTo(787, 560.193, 786.216, 561, 785.25, 561)
      ..lineTo(780, 561)
      ..close()
      ..moveTo(780, 634)
      ..lineTo(785.25, 634)
      ..cubicTo(786.216, 634, 787, 634.828, 787, 635.85)
      ..lineTo(787, 854.1500000000001)
      ..cubicTo(
        787,
        855.1720000000001,
        786.216,
        856.0000000000001,
        785.25,
        856.0000000000001,
      )
      ..lineTo(780, 856.0000000000001)
      ..close();
    canvas.drawPath(
      buttonsPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF272727),
    );

    final buttonsShadowPath = Path()
      ..moveTo(780, 442)
      ..lineTo(780, 561)
      ..close()
      ..moveTo(780, 634)
      ..lineTo(780, 856.0000000000001)
      ..close();
    canvas.drawPath(
      buttonsShadowPath,
      Paint()
        ..color = const Color(0x99FFFFFF)
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width * 0.018
        ..maskFilter = MaskFilter.blur(
          BlurStyle.inner,
          size.width * 0.03,
        ),
    );

    final backgroundPath = Path()
      ..moveTo(0, 168.75)
      ..cubicTo(0, 128.05700000000002, 0, 107.71000000000001, 4.693, 91.07)
      ..arcToPoint(
        const Offset(91.07, 4.693),
        radius: const Radius.elliptical(125, 125),
      )
      ..cubicTo(107.71, 0, 128.057, 0, 168.75, 0)
      ..lineTo(613.25, 0)
      ..cubicTo(653.943, 0, 674.29, 0, 690.9300000000001, 4.693)
      ..arcToPoint(
        const Offset(777.307, 91.07),
        radius: const Radius.elliptical(125, 125),
      )
      ..cubicTo(782, 107.71, 782, 128.057, 782, 168.75)
      ..lineTo(782, 1494.25)
      ..cubicTo(782, 1534.94, 782, 1555.29, 777.307, 1571.93)
      ..cubicTo(
        765.5020000000001,
        1613.79,
        732.788,
        1646.5,
        690.9300000000001,
        1658.31,
      )
      ..cubicTo(
        674.2900000000001,
        1663,
        653.9430000000001,
        1663,
        613.25,
        1663,
      )
      ..lineTo(168.75, 1663)
      ..cubicTo(
        128.05700000000002,
        1663,
        107.71000000000001,
        1663,
        91.07,
        1658.31,
      )
      ..cubicTo(
        49.211999999999996,
        1646.5,
        16.49799999999999,
        1613.79,
        4.692999999999998,
        1571.9299999999998,
      )
      ..cubicTo(0, 1555.29, 0, 1534.94, 0, 1494.25)
      ..close();
    canvas.drawPath(
      backgroundPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF272727),
    );

    final bezelPath = Path()
      ..moveTo(15, 192.6)
      ..cubicTo(15, 130.434, 15, 99.351, 27.098, 75.607)
      ..arcToPoint(
        const Offset(75.608, 27.098),
        radius: const Radius.elliptical(111, 111),
      )
      ..cubicTo(99.35, 15, 130.433, 15, 192.6, 15)
      ..lineTo(589.4, 15)
      ..cubicTo(651.566, 15, 682.649, 15, 706.393, 27.098)
      ..arcToPoint(
        const Offset(754.902, 75.608),
        radius: const Radius.elliptical(111, 111),
      )
      ..cubicTo(767, 99.35, 767, 130.433, 767, 192.6)
      ..lineTo(767, 1470.3999999999999)
      ..cubicTo(
        767,
        1532.57,
        767,
        1563.6499999999999,
        754.902,
        1587.3899999999999,
      )
      ..arcToPoint(
        const Offset(706.393, 1635.8999999999999),
        radius: const Radius.elliptical(110.97, 110.97),
      )
      ..cubicTo(682.649, 1648, 651.566, 1648, 589.4, 1648)
      ..lineTo(192.6, 1648)
      ..cubicTo(130.434, 1648, 99.351, 1648, 75.607, 1635.9)
      ..arcToPoint(
        const Offset(27.098, 1587.39),
        radius: const Radius.elliptical(110.97, 110.97),
      )
      ..cubicTo(15, 1563.65, 15, 1532.57, 15, 1470.4)
      ..close();
    canvas
      ..drawPath(
        bezelPath,
        Paint()
          ..color = const Color(0x55000000)
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.03
          ..maskFilter = MaskFilter.blur(
            BlurStyle.normal,
            size.width * 0.003,
          ),
      )
      ..drawPath(
        bezelPath,
        Paint()
          ..color = const Color(0x99FFFFFF)
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.009
          ..maskFilter = MaskFilter.blur(
            BlurStyle.normal,
            size.width * 0.006,
          ),
      )
      ..drawPath(
        bezelPath,
        Paint()
          ..style = PaintingStyle.fill
          ..color = const Color(0xFF000000),
      );

    final antennasPath = Path()
      ..moveTo(383.5, 0)
      ..lineTo(398.5, 0)
      ..lineTo(398.5, 18)
      ..lineTo(383.5, 18)
      ..close()
      ..moveTo(0, 243)
      ..lineTo(18, 243)
      ..lineTo(18, 258)
      ..lineTo(0, 258)
      ..close()
      ..moveTo(764, 243)
      ..lineTo(782, 243)
      ..lineTo(782, 258)
      ..lineTo(764, 258)
      ..close()
      ..moveTo(764, 1495)
      ..lineTo(782, 1495)
      ..lineTo(782, 1510)
      ..lineTo(764, 1510)
      ..close()
      ..moveTo(0, 1495)
      ..lineTo(18, 1495)
      ..lineTo(18, 1510)
      ..lineTo(0, 1510)
      ..close()
      ..moveTo(471, 1645)
      ..lineTo(486, 1645)
      ..lineTo(486, 1663)
      ..lineTo(471, 1663)
      ..close();
    canvas.drawPath(
      antennasPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0x40000000),
    );

    final cameraPath1 = Path()
      ..moveTo(415, 84)
      ..cubicTo(415, 97.255, 404.255, 108, 391, 108)
      ..cubicTo(377.745, 108, 367, 97.255, 367, 84)
      ..cubicTo(367, 70.745, 377.745, 60, 391, 60)
      ..cubicTo(404.255, 60, 415, 70.745, 415, 84);
    canvas.drawPath(
      cameraPath1,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF000000),
    );

    final cameraPath2 = Path()
      ..moveTo(391, 93.23)
      ..arcToPoint(
        const Offset(391, 74.769),
        radius: const Radius.elliptical(9.231, 9.231),
        largeArc: true,
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(391, 93.23100000000001),
        radius: const Radius.elliptical(9.231, 9.231),
        clockwise: false,
      );
    canvas.drawPath(
      cameraPath2,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF131423),
    );

    final cameraPath3 = Path()
      ..moveTo(398.5, 84)
      ..arcToPoint(
        const Offset(383.5, 84),
        radius: const Radius.elliptical(7.5, 7.5),
        largeArc: true,
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(398.5, 84),
        radius: const Radius.elliptical(7.5, 7.5),
        clockwise: false,
      );
    canvas.drawPath(
      cameraPath3,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF07144C),
    );

    final cameraPath4 = Path()
      ..moveTo(384.673, 83.577)
      ..cubicTo(384.795, 80.29299999999999, 387.675, 77.942, 390.96, 77.942)
      ..cubicTo(
        394.281,
        77.942,
        397.197,
        80.339,
        397.327,
        83.65799999999999,
      )
      ..quadraticBezierTo(
        397.346,
        84.12799999999999,
        397.346,
        84.57699999999998,
      )
      ..quadraticBezierTo(
        397.346,
        85.02599999999998,
        397.327,
        85.49699999999999,
      )
      ..cubicTo(
        397.197,
        88.81499999999998,
        394.281,
        91.21199999999999,
        390.96,
        91.21199999999999,
      )
      ..cubicTo(
        387.67499999999995,
        91.21199999999999,
        384.79499999999996,
        88.85999999999999,
        384.673,
        85.57699999999998,
      )
      ..arcToPoint(
        const Offset(384.673, 83.57699999999998),
        radius: const Radius.elliptical(28, 28),
      );
    canvas.drawPath(
      cameraPath4,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0x66030303),
    );

    final cameraPath5 = Path()
      ..moveTo(391, 90.058)
      ..cubicTo(
        392.593,
        90.058,
        393.885,
        88.89500000000001,
        393.885,
        87.46100000000001,
      )
      ..cubicTo(
        393.885,
        86.02700000000002,
        392.593,
        84.86500000000001,
        391,
        84.86500000000001,
      )
      ..cubicTo(
        389.407,
        84.86500000000001,
        388.115,
        86.028,
        388.115,
        87.462,
      )
      ..cubicTo(388.115, 88.896, 389.407, 90.058, 391, 90.058);
    canvas.drawPath(
      cameraPath5,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.4968234, size.height * 0.03607937),
          Offset(size.width * 0.4968234, size.height * 0.06494287),
          const [Color(0x451D869C), Color(0x4C2371C6), Color(0x4C040AAD)],
          const [0, 0.371, 1],
        ),
    );

    final cameraPath6 = Path()
      ..moveTo(391, 90.058)
      ..arcToPoint(
        const Offset(391, 86.596),
        radius: const Radius.elliptical(1.73, 1.73),
        largeArc: true,
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(391, 90.058),
        radius: const Radius.elliptical(1.73, 1.73),
        clockwise: false,
      );
    canvas.drawPath(
      cameraPath6,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.4968234, size.height * 0.03848467),
          Offset(size.width * 0.4968234, size.height * 0.06494287),
          const [Color(0x59005267), Color(0x59415967), Color(0x598700C7)],
          const [0, 0.486, 1],
        ),
    );

    final cameraPath7 = Path()
      ..moveTo(391, 88.615)
      ..arcToPoint(
        const Offset(391, 79.38499999999999),
        radius: const Radius.elliptical(4.615, 4.615),
        largeArc: true,
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(391, 88.615),
        radius: const Radius.elliptical(4.615, 4.615),
        clockwise: false,
      );
    canvas.drawPath(
      cameraPath7,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.4968234, size.height * 0.04756284),
          Offset(size.width * 0.4968234, size.height * 0.05016476),
          const [Color(0xFF5978DD), Color(0x9C312FAD), Color(0x001C1C86)],
          const [0, 0.379, 1],
        ),
    );

    final speakerPath = Path()
      ..moveTo(592.549, 16)
      ..cubicTo(
        591.525,
        16.323,
        590.5889999999999,
        16.718,
        589.775,
        17.182,
      )
      ..lineTo(589.302, 17.468999999999998)
      ..lineTo(586.495, 19.272)
      ..cubicTo(584.833, 20.340999999999998, 582.154, 21, 579.258, 21)
      ..lineTo(202.742, 21)
      ..cubicTo(
        200.02599999999998,
        21,
        197.503,
        20.42,
        195.82899999999998,
        19.468,
      )
      ..lineTo(195.50599999999997, 19.273)
      ..lineTo(192.69899999999998, 17.469)
      ..cubicTo(191.784, 16.881, 190.68099999999998, 16.387, 189.452, 16)
      ..close();
    canvas
      ..drawPath(
        speakerPath,
        Paint()
          ..style = PaintingStyle.fill
          ..color = const Color(0xFF000000),
      )
      ..drawPath(
        speakerPath,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = const Color(0xCC353535),
      );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

part of 'device.dart';

// Generated with https://fluttershapemaker.com and manually adjusted.
class _FramePainter extends CustomPainter {
  const _FramePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final buttonsPath = Path()
      ..moveTo(0, 325.431)
      ..cubicTo(0, 324.4, 1.296, 323.56399999999996, 2.896, 323.56399999999996)
      ..lineTo(6.756, 323.56399999999996)
      ..lineTo(6.756, 391.388)
      ..lineTo(2.8960000000000004, 391.388)
      ..cubicTo(
        1.2960000000000003,
        391.388,
        4.440892098500626e-16,
        390.553,
        4.440892098500626e-16,
        389.522,
      )
      ..close()
      ..moveTo(0, 448.633)
      ..cubicTo(0, 447.602, 1.296, 446.767, 2.896, 446.767)
      ..lineTo(6.756, 446.767)
      ..lineTo(6.756, 573.081)
      ..lineTo(2.8960000000000004, 573.081)
      ..cubicTo(
        1.2960000000000003,
        573.081,
        4.440892098500626e-16,
        572.245,
        4.440892098500626e-16,
        571.214,
      )
      ..close()
      ..moveTo(0, 608.548)
      ..cubicTo(0, 607.517, 1.296, 606.682, 2.896, 606.682)
      ..lineTo(6.756, 606.682)
      ..lineTo(6.756, 732.996)
      ..lineTo(2.8960000000000004, 732.996)
      ..cubicTo(
        1.2960000000000003,
        732.996,
        4.440892098500626e-16,
        732.16,
        4.440892098500626e-16,
        731.129,
      )
      ..close()
      ..moveTo(873.622, 535.747)
      ..cubicTo(873.622, 534.716, 872.491, 533.88, 871.0889999999999, 533.88)
      ..lineTo(866.866, 533.88)
      ..lineTo(866.866, 732.996)
      ..lineTo(871.0889999999999, 732.996)
      ..cubicTo(872.491, 732.996, 873.622, 732.16, 873.622, 731.129)
      ..close();
    canvas.drawPath(
      buttonsPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF454C60),
    );

    final buttonsShadowPath = Path()
      ..moveTo(6.756, 324.4)
      ..lineTo(6.756, 391.388)
      ..close()
      ..moveTo(6.756, 446.767)
      ..lineTo(6.756, 573.081)
      ..close()
      ..moveTo(6.756, 606.682)
      ..lineTo(6.756, 732.996)
      ..close()
      ..moveTo(866.866, 533.88)
      ..lineTo(866.866, 732.996)
      ..close();
    canvas.drawPath(
      buttonsShadowPath,
      Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width * 0.0125
        ..maskFilter = MaskFilter.blur(
          BlurStyle.inner,
          size.width * 0.03,
        ),
    );

    final backgroundPath = Path()
      ..moveTo(4.356, 214.05)
      ..cubicTo(
        4.356,
        139.125,
        4.356,
        101.66300000000001,
        18.936999999999998,
        73.04600000000002,
      )
      ..arcToPoint(
        const Offset(77.402, 14.58),
        radius: const Radius.elliptical(133.78, 133.78),
      )
      ..cubicTo(106.019, 0, 143.48, 0, 218.406, 0)
      ..lineTo(654.595, 0)
      ..cubicTo(729.519, 0, 766.981, 0, 795.599, 14.581)
      ..arcToPoint(
        const Offset(854.0630000000001, 73.046),
        radius: const Radius.elliptical(133.8, 133.8),
      )
      ..cubicTo(
        868.6440000000001,
        101.66300000000001,
        868.6440000000001,
        139.125,
        868.6440000000001,
        214.05,
      )
      ..lineTo(868.6440000000001, 1587.95)
      ..cubicTo(
        868.6440000000001,
        1662.8700000000001,
        868.6440000000001,
        1700.3400000000001,
        854.0630000000001,
        1728.95,
      )
      ..arcToPoint(
        const Offset(795.5990000000002, 1787.42),
        radius: const Radius.elliptical(133.78, 133.78),
      )
      ..cubicTo(766.981, 1802, 729.519, 1802, 654.595, 1802)
      ..lineTo(218.406, 1802)
      ..cubicTo(143.481, 1802, 106.019, 1802, 77.40200000000002, 1787.42)
      ..arcToPoint(
        const Offset(18.937000000000012, 1728.95),
        radius: const Radius.elliptical(133.78, 133.78),
      )
      ..cubicTo(
        4.356000000000012,
        1700.3400000000001,
        4.356000000000012,
        1662.8700000000001,
        4.356000000000012,
        1587.95,
      )
      ..close();
    canvas.drawPath(
      backgroundPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xff454C60),
    );

    final antennasPath = Path()
      ..moveTo(700.751, 12.414)
      ..lineTo(688.4639999999999, 12.414)
      ..lineTo(688.4639999999999, 0.31)
      ..lineTo(700.751, 0.31)
      ..close()
      ..moveTo(16.8, 186.049)
      ..lineTo(4.356, 186.049)
      ..lineTo(4.356, 174.227)
      ..lineTo(16.8, 174.227)
      ..close()
      ..moveTo(868.644, 186.049)
      ..lineTo(856.2, 186.049)
      ..lineTo(856.2, 174.227)
      ..lineTo(868.644, 174.227)
      ..close()
      ..moveTo(16.8, 1478.44)
      ..lineTo(4.356, 1478.44)
      ..lineTo(4.356, 1466.6100000000001)
      ..lineTo(16.8, 1466.6100000000001)
      ..close()
      ..moveTo(868.644, 1627.15)
      ..lineTo(856.2, 1627.15)
      ..lineTo(856.2, 1615.95)
      ..lineTo(868.644, 1615.95)
      ..close()
      ..moveTo(184.80499999999995, 1789.5600000000002)
      ..lineTo(184.80499999999995, 1802)
      ..lineTo(172.98199999999994, 1802)
      ..lineTo(172.98199999999994, 1789.56)
      ..close();
    canvas.drawPath(
      antennasPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0x40000000),
    );

    final bezelPath = Path()
      ..moveTo(15.556, 208.325)
      ..cubicTo(15.556, 139.325, 15.556, 104.82499999999999, 28.984, 78.47)
      ..arcToPoint(
        const Offset(82.826, 24.629999999999995),
        radius: const Radius.elliptical(123.2, 123.2),
      )
      ..cubicTo(109.18, 11.2, 143.681, 11.2, 212.681, 11.2)
      ..lineTo(660.319, 11.2)
      ..cubicTo(729.319, 11.2, 763.822, 11.2, 790.174, 24.628999999999998)
      ..arcToPoint(
        const Offset(844.016, 78.47),
        radius: const Radius.elliptical(123.2, 123.2),
      )
      ..cubicTo(857.444, 104.825, 857.444, 139.325, 857.444, 208.325)
      ..lineTo(857.444, 1593.67)
      ..cubicTo(
        857.444,
        1662.67,
        857.444,
        1697.18,
        844.016,
        1723.5300000000002,
      )
      ..arcToPoint(
        const Offset(790.174, 1777.3700000000001),
        radius: const Radius.elliptical(123.2, 123.2),
      )
      ..cubicTo(
        763.822,
        1790.8000000000002,
        729.319,
        1790.8000000000002,
        660.319,
        1790.8000000000002,
      )
      ..lineTo(212.681, 1790.8000000000002)
      ..cubicTo(
        143.681,
        1790.8000000000002,
        109.18,
        1790.8000000000002,
        82.82600000000002,
        1777.3700000000001,
      )
      ..arcToPoint(
        const Offset(28.984000000000023, 1723.5300000000002),
        radius: const Radius.elliptical(123.2, 123.2),
      )
      ..cubicTo(
        15.556000000000022,
        1697.1800000000003,
        15.556000000000022,
        1662.6700000000003,
        15.556000000000022,
        1593.67,
      )
      ..close();
    canvas
      ..drawPath(
        bezelPath,
        Paint()
          ..style = PaintingStyle.fill
          ..color = const Color(0xFF000000),
      )
      ..drawPath(
        bezelPath,
        Paint()
          ..color = const Color(0xB3FFFFFF)
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.002290951
          ..maskFilter = MaskFilter.blur(
            BlurStyle.normal,
            size.width * 0.003,
          ),
      );

    final dynamicIslandPath = Path()
      ..moveTo(520.1, 52.268)
      ..lineTo(354.767, 52.268)
      ..cubicTo(335.816, 52.268, 320.453, 67.59, 320.453, 86.491)
      ..cubicTo(320.453, 105.392, 335.816, 120.714, 354.767, 120.714)
      ..lineTo(520.1, 120.714)
      ..cubicTo(539.051, 120.714, 554.414, 105.392, 554.414, 86.491)
      ..cubicTo(
        554.414,
        67.59100000000001,
        539.0509999999999,
        52.268,
        520.1,
        52.268,
      );
    canvas.drawPath(
      dynamicIslandPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF000000),
    );

    final cameraPath1 = Path()
      ..moveTo(520.1, 96.758)
      ..cubicTo(
        525.613,
        96.758,
        530.082,
        92.301,
        530.082,
        86.80199999999999,
      )
      ..cubicTo(
        530.082,
        81.30299999999998,
        525.6129999999999,
        76.847,
        520.1,
        76.847,
      )
      ..cubicTo(
        514.5870000000001,
        76.847,
        510.117,
        81.30399999999999,
        510.117,
        86.80199999999999,
      )
      ..cubicTo(510.117, 92.3, 514.587, 96.758, 520.1, 96.758);
    canvas.drawPath(
      cameraPath1,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF131423),
    );

    final cameraPath2 = Path()
      ..moveTo(528.21, 86.802)
      ..cubicTo(
        528.21,
        82.33500000000001,
        524.5790000000001,
        78.71300000000001,
        520.1,
        78.71300000000001,
      )
      ..cubicTo(
        515.62,
        78.71300000000001,
        511.98900000000003,
        82.33500000000001,
        511.98900000000003,
        86.80300000000001,
      )
      ..cubicTo(
        511.98900000000003,
        91.27000000000001,
        515.62,
        94.891,
        520.1,
        94.891,
      )
      ..cubicTo(
        524.5790000000001,
        94.891,
        528.21,
        91.27000000000001,
        528.21,
        86.802,
      );
    canvas.drawPath(
      cameraPath2,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF07144C),
    );

    final cameraPath3 = Path()
      ..moveTo(513.258, 86.346)
      ..cubicTo(513.39, 82.804, 516.504, 80.269, 520.057, 80.269)
      ..cubicTo(523.648, 80.269, 526.802, 82.854, 526.942, 86.433)
      ..quadraticBezierTo(526.962, 86.941, 526.963, 87.424)
      ..quadraticBezierTo(
        526.963,
        87.91000000000001,
        526.942,
        88.41600000000001,
      )
      ..cubicTo(
        526.802,
        91.995,
        523.648,
        94.58000000000001,
        520.057,
        94.58000000000001,
      )
      ..cubicTo(
        516.504,
        94.58000000000001,
        513.39,
        92.04500000000002,
        513.258,
        88.50300000000001,
      )
      ..arcToPoint(
        const Offset(513.258, 86.34600000000002),
        radius: const Radius.elliptical(28, 28),
      );
    canvas.drawPath(
      cameraPath3,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0x66030303),
    );

    final cameraPath4 = Path()
      ..moveTo(520.1, 93.336)
      ..cubicTo(521.823, 93.336, 523.219, 92.082, 523.219, 90.536)
      ..cubicTo(523.219, 88.989, 521.8230000000001, 87.736, 520.1, 87.736)
      ..cubicTo(518.377, 87.736, 516.98, 88.989, 516.98, 90.536)
      ..cubicTo(516.98, 92.083, 518.3770000000001, 93.336, 520.1, 93.336);
    canvas.drawPath(
      cameraPath4,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.5004954, size.height * 0.02900555),
          Offset(size.width * 0.5004954, size.height * 0.06698890),
          const [Color(0x451D869C), Color(0x4C2371C6), Color(0x4C040AAD)],
          const [0, 0.371, 1],
        ),
    );

    final cameraPath5 = Path()
      ..moveTo(520.1, 93.336)
      ..arcToPoint(
        const Offset(521.971, 91.469),
        radius: const Radius.elliptical(1.87, 1.87),
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(520.1, 89.60199999999999),
        radius: const Radius.elliptical(1.87, 1.87),
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(518.2280000000001, 91.469),
        radius: const Radius.elliptical(1.87, 1.87),
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(520.1, 93.336),
        radius: const Radius.elliptical(1.87, 1.87),
        clockwise: false,
      );
    canvas.drawPath(
      cameraPath5,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.5004954, size.height * 0.03217092),
          Offset(size.width * 0.5004954, size.height * 0.06698890),
          const [Color(0x59005267), Color(0x59415967), Color(0x598700C7)],
          const [0, 0.486, 1],
        ),
    );

    final cameraPath6 = Path()
      ..moveTo(520.1, 91.78)
      ..arcToPoint(
        const Offset(525.091, 86.802),
        radius: const Radius.elliptical(4.985, 4.985),
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(520.1, 81.82400000000001),
        radius: const Radius.elliptical(4.985, 4.985),
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(515.109, 86.802),
        radius: const Radius.elliptical(4.984, 4.984),
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(520.1, 91.78),
        radius: const Radius.elliptical(4.984, 4.984),
        clockwise: false,
      );
    canvas.drawPath(
      cameraPath6,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.5950801, size.height * 0.04523474),
          Offset(size.width * 0.5950801, size.height * 0.04782464),
          const [Color(0xFF5978DD), Color(0x9C312FAD), Color(0x001C1C86)],
          const [0, 0.379, 1],
        ),
    );

    final speakerPath = Path()
      ..moveTo(517.187, 12.2)
      ..arcToPoint(
        const Offset(516.0020000000001, 13.373),
        radius: const Radius.elliptical(5.7, 5.7),
        clockwise: false,
      )
      ..lineTo(515.8040000000001, 13.652999999999999)
      ..lineTo(514.6820000000001, 15.336999999999998)
      ..cubicTo(
        514.0590000000001,
        16.272,
        513.0950000000001,
        16.801,
        512.0960000000001,
        16.801,
      )
      ..lineTo(361.5260000000001, 16.801)
      ..cubicTo(
        360.5890000000001,
        16.801,
        359.68400000000014,
        16.336,
        359.06100000000015,
        15.506999999999998,
      )
      ..lineTo(358.94000000000017, 15.336999999999998)
      ..lineTo(357.81800000000015, 13.652999999999999)
      ..arcToPoint(
        const Offset(356.4350000000002, 12.2),
        radius: const Radius.elliptical(5.8, 5.8),
        clockwise: false,
      )
      ..close();
    canvas
      ..drawPath(
        speakerPath,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = const Color(0xFF353535),
      )
      ..drawPath(
        speakerPath,
        Paint()
          ..style = PaintingStyle.fill
          ..color = const Color(0xFF0F0E0E),
      );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

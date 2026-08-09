part of 'device.dart';

// Generated with https://fluttershapemaker.com and manually adjusted.
class _FramePainter extends CustomPainter {
  const _FramePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final buttonsPath = Path()
      ..moveTo(872.671, 563.658)
      ..cubicTo(872.671, 562.578, 870.889, 561.703, 868.682, 561.703)
      ..lineTo(862.035, 561.703)
      ..lineTo(862.035, 770.2139999999999)
      ..lineTo(868.682, 770.2139999999999)
      ..cubicTo(870.889, 770.2139999999999, 872.671, 769.3389999999999, 872.671,
          768.2589999999999)
      ..close()
      ..moveTo(0.492, 516.151)
      ..cubicTo(0.492, 515.457, 1.918, 514.895, 3.683, 514.895)
      ..lineTo(9.001, 514.895)
      ..lineTo(9.001, 648.937)
      ..lineTo(3.683, 648.937)
      ..cubicTo(1.918, 648.937, 0.4929999999999999, 648.375, 0.4929999999999999,
          647.6800000000001)
      ..close()
      ..moveTo(0.492, 373.09799999999996)
      ..cubicTo(0.492, 372.679, 1.918, 372.34, 3.683, 372.34)
      ..lineTo(9.001, 372.34)
      ..lineTo(9.001, 453.191)
      ..lineTo(3.683, 453.191)
      ..cubicTo(1.918, 453.191, 0.4929999999999999, 452.852, 0.4929999999999999,
          452.433)
      ..close()
      ..moveTo(0.492, 686.362)
      ..cubicTo(0.492, 685.668, 1.918, 685.105, 3.683, 685.105)
      ..lineTo(9.001, 685.105)
      ..lineTo(9.001, 819.148)
      ..lineTo(3.683, 819.148)
      ..cubicTo(1.918, 819.148, 0.4929999999999999, 818.585, 0.4929999999999999,
          817.8910000000001)
      ..close();
    canvas.drawPath(
      buttonsPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFFD55918),
    );

    final buttonsShadowPath = Path()
      ..moveTo(862.035, 561.703)
      ..lineTo(862.035, 770.2139999999999)
      ..close()
      ..moveTo(9.001, 514.895)
      ..lineTo(9.001, 648.937)
      ..close()
      ..moveTo(9.001, 372.34)
      ..lineTo(9.001, 453.191)
      ..close()
      ..moveTo(9.001, 685.105)
      ..lineTo(9.001, 819.148)
      ..close();
    canvas.drawPath(
      buttonsShadowPath,
      Paint()
        ..color = Color(0xFFFFC78E)
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width * 0.0125
        ..maskFilter = MaskFilter.blur(
          BlurStyle.inner,
          size.width * 0.01,
        ),
    );

    final backgroundPath = Path()
      ..moveTo(6.874, 245.106)
      ..cubicTo(6.874, 159.31099999999998, 6.874, 116.41299999999998,
          23.567999999999998, 83.644)
      ..arcToPoint(Offset(90.502, 16.697000000000003),
          radius: Radius.elliptical(153.18, 153.18),
          rotation: 0,
          largeArc: false,
          clockwise: true)
      ..cubicTo(123.267, 0, 166.157, 0, 251.936, 0)
      ..lineTo(619.102, 0)
      ..cubicTo(704.88, 0, 747.77, 0, 780.533, 16.697)
      ..arcToPoint(Offset(847.4680000000001, 83.644),
          radius: Radius.elliptical(153.17, 153.17),
          rotation: 0,
          largeArc: false,
          clockwise: true)
      ..cubicTo(864.162, 116.41300000000001, 864.162, 159.311, 864.162, 245.106)
      ..lineTo(864.162, 1554.89)
      ..cubicTo(864.162, 1640.69, 864.162, 1683.5900000000001,
          847.4680000000001, 1716.3600000000001)
      ..arcToPoint(Offset(780.5330000000001, 1783.3000000000002),
          radius: Radius.elliptical(153.15, 153.15),
          rotation: 0,
          largeArc: false,
          clockwise: true)
      ..cubicTo(747.77, 1800, 704.88, 1800, 619.101, 1800)
      ..lineTo(251.935, 1800)
      ..cubicTo(
          166.156, 1800, 123.26599999999999, 1800, 90.50300000000001, 1783.3)
      ..arcToPoint(Offset(23.568000000000012, 1716.36),
          radius: Radius.elliptical(153.15, 153.15),
          rotation: 0,
          largeArc: false,
          clockwise: true)
      ..cubicTo(6.874000000000013, 1683.59, 6.874000000000013,
          1640.6899999999998, 6.874000000000013, 1554.8899999999999)
      ..close();
    canvas.drawPath(
      backgroundPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFFD55918),
    );

    final antennasPath = Path()
      ..moveTo(864.162, 1617.02)
      ..lineTo(849.2710000000001, 1617.02)
      ..lineTo(849.2710000000001, 1600)
      ..lineTo(864.162, 1600)
      ..close()
      ..moveTo(864.162, 202.1289999999999)
      ..lineTo(849.2710000000001, 202.1289999999999)
      ..lineTo(849.2710000000001, 185.1079999999999)
      ..lineTo(864.162, 185.1079999999999)
      ..close()
      ..moveTo(21.765, 1617.02)
      ..lineTo(6.874, 1617.02)
      ..lineTo(6.874, 1600)
      ..lineTo(21.764, 1600)
      ..close()
      ..moveTo(21.765, 202.1289999999999)
      ..lineTo(6.874, 202.1289999999999)
      ..lineTo(6.874, 185.1079999999999)
      ..lineTo(21.764, 185.1079999999999)
      ..close();
    canvas.drawPath(
      antennasPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0x40000000),
    );

    final bezelPath = Path()
      ..moveTo(19.638, 237.446)
      ..cubicTo(19.638, 158.801, 19.638, 119.478, 34.94, 89.439)
      ..arcToPoint(Offset(96.297, 28.07099999999999),
          radius: Radius.elliptical(140.4, 140.4),
          rotation: 0,
          largeArc: false,
          clockwise: true)
      ..cubicTo(126.33, 12.765999999999991, 165.64600000000002,
          12.765999999999991, 244.277, 12.765999999999991)
      ..lineTo(626.759, 12.765999999999991)
      ..cubicTo(705.39, 12.765999999999991, 744.706, 12.765999999999991,
          774.739, 28.07099999999999)
      ..arcToPoint(Offset(836.096, 89.439),
          radius: Radius.elliptical(140.4, 140.4),
          rotation: 0,
          largeArc: false,
          clockwise: true)
      ..cubicTo(851.398, 119.478, 851.398, 158.801, 851.398, 237.446)
      ..lineTo(851.398, 1562.55)
      ..cubicTo(851.398, 1641.2, 851.398, 1680.52, 836.096, 1710.56)
      ..arcToPoint(Offset(774.739, 1771.9299999999998),
          radius: Radius.elliptical(140.4, 140.4),
          rotation: 0,
          largeArc: false,
          clockwise: true)
      ..cubicTo(744.706, 1787.2299999999998, 705.39, 1787.2299999999998,
          626.759, 1787.2299999999998)
      ..lineTo(244.277, 1787.2299999999998)
      ..cubicTo(165.646, 1787.2299999999998, 126.32999999999998,
          1787.2299999999998, 96.297, 1771.9299999999998)
      ..arcToPoint(Offset(34.94, 1710.56),
          radius: Radius.elliptical(140.4, 140.4),
          rotation: 0,
          largeArc: false,
          clockwise: true)
      ..cubicTo(19.637999999999998, 1680.52, 19.637999999999998, 1641.2,
          19.637999999999998, 1562.55)
      ..close();
    canvas
      ..drawPath(
        bezelPath,
        Paint()
          ..color = const Color(0xB3FFC78E)
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.01
          ..maskFilter = MaskFilter.blur(
            BlurStyle.normal,
            size.width * 0.004,
          ),
      )
      ..drawPath(
        bezelPath,
        Paint()
          ..style = PaintingStyle.fill
          ..color = const Color(0xFF000000),
      );

    final dynamicIslandPath = Path()
      ..moveTo(523.459, 47.574)
      ..lineTo(347.577, 47.574)
      ..cubicTo(327.416, 47.574, 311.073, 63.292, 311.073, 82.681)
      ..cubicTo(311.073, 102.07, 327.416, 117.787, 347.577, 117.787)
      ..lineTo(523.4590000000001, 117.787)
      ..cubicTo(543.6200000000001, 117.787, 559.9630000000001, 102.069,
          559.9630000000001, 82.68100000000001)
      ..cubicTo(559.9630000000001, 63.29100000000001, 543.6200000000001,
          47.57400000000001, 523.4590000000001, 47.57400000000001)
      ..close();
    canvas.drawPath(
      dynamicIslandPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF000000),
    );

    final cameraPath1 = Path()
      ..moveTo(523.459, 93.213)
      ..cubicTo(529.324, 93.213, 534.078, 88.63999999999999, 534.078, 83)
      ..cubicTo(534.078, 77.36000000000001, 529.324, 72.787, 523.459, 72.787)
      ..cubicTo(517.5939999999999, 72.787, 512.84, 77.359, 512.84, 83)
      ..cubicTo(512.84, 88.641, 517.594, 93.213, 523.4590000000001, 93.213);
    canvas.drawPath(
      cameraPath1,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF131423),
    );

    final cameraPath2 = Path()
      ..moveTo(532.087, 83)
      ..cubicTo(532.087, 78.417, 528.2239999999999, 74.702, 523.459, 74.702)
      ..cubicTo(
          518.694, 74.702, 514.8309999999999, 78.417, 514.8309999999999, 83)
      ..cubicTo(514.8309999999999, 87.582, 518.694, 91.298, 523.459, 91.298)
      ..cubicTo(
          528.2239999999999, 91.298, 532.087, 87.58200000000001, 532.087, 83);
    canvas.drawPath(
      cameraPath2,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF07144C),
    );

    final cameraPath3 = Path()
      ..moveTo(516.181, 82.531)
      ..cubicTo(516.321, 78.899, 519.634, 76.298, 523.414, 76.298)
      ..cubicTo(527.234, 76.298, 530.5889999999999, 78.95, 530.7379999999999,
          82.62100000000001)
      ..quadraticBezierTo(530.76, 83.14000000000001, 530.76, 83.638)
      ..cubicTo(530.76, 83.968, 530.752, 84.31, 530.7379999999999, 84.655)
      ..cubicTo(530.5889999999999, 88.32600000000001, 527.2339999999999,
          90.97800000000001, 523.414, 90.97800000000001)
      ..cubicTo(519.634, 90.97800000000001, 516.321, 88.37800000000001, 516.181,
          84.745)
      ..arcToPoint(Offset(516.181, 82.531),
          radius: Radius.elliptical(27, 27),
          rotation: 0,
          largeArc: false,
          clockwise: true);
    canvas.drawPath(
      cameraPath3,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0x66030303),
    );

    final cameraPath4 = Path()
      ..moveTo(523.459, 89.702)
      ..cubicTo(525.2919999999999, 89.702, 526.7779999999999, 88.416,
          526.7779999999999, 86.829)
      ..cubicTo(
          526.7779999999999, 85.243, 525.2919999999999, 83.957, 523.459, 83.957)
      ..cubicTo(521.626, 83.957, 520.141, 85.243, 520.141, 86.83)
      ..cubicTo(520.141, 88.416, 521.626, 89.702, 523.459, 89.702);
    ;
    canvas.drawPath(
      cameraPath4,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.4988751, size.height * 0.03309667),
          Offset(size.width * 0.4988751, size.height * 0.07210389),
          const [Color(0x451D869C), Color(0x4C2371C6), Color(0x4C040AAD)],
          const [0, 0.371, 1],
        ),
    );

    final cameraPath5 = Path()
      ..moveTo(523.459, 89.702)
      ..cubicTo(524.559, 89.702, 525.4499999999999, 88.845, 525.4499999999999,
          87.78699999999999)
      ..cubicTo(525.4499999999999, 86.72899999999998, 524.559,
          85.87199999999999, 523.459, 85.87199999999999)
      ..cubicTo(522.3599999999999, 85.87199999999999, 521.468,
          86.72899999999998, 521.468, 87.78699999999999)
      ..cubicTo(521.468, 88.845, 522.36, 89.702, 523.459, 89.702);
    canvas.drawPath(
      cameraPath5,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.4988751, size.height * 0.03634722),
          Offset(size.width * 0.4988751, size.height * 0.07210389),
          const [Color(0x59005267), Color(0x59415967), Color(0x598700C7)],
          const [0, 0.486, 1],
        ),
    );

    final cameraPath6 = Path()
      ..moveTo(523.459, 88.106)
      ..cubicTo(526.3919999999999, 88.106, 528.7689999999999, 85.82,
          528.7689999999999, 83)
      ..cubicTo(
          528.7689999999999, 80.18, 526.3919999999999, 77.893, 523.459, 77.893)
      ..cubicTo(520.526, 77.893, 518.15, 80.18, 518.15, 83)
      ..cubicTo(518.15, 85.82, 520.5269999999999, 88.106, 523.459, 88.106);
    canvas.drawPath(
      cameraPath6,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.5996094, size.height * 0.04309667),
          Offset(size.width * 0.5996094, size.height * 0.04575667),
          const [Color(0xFF5978DD), Color(0x9C312FAD), Color(0x001C1C86)],
          const [0, 0.379, 1],
        ),
    );

    final speakerPath = Path()
      ..moveTo(603.245, 15.266)
      ..cubicTo(602.132, 15.693, 601.135, 16.249, 600.317, 16.922)
      ..lineTo(597.9830000000001, 18.841)
      ..cubicTo(
          596.624, 19.957, 594.4330000000001, 20.648, 592.0580000000001, 20.648)
      ..lineTo(278.9780000000001, 20.648)
      ..cubicTo(276.60200000000015, 20.648, 274.4110000000001, 19.958,
          273.0530000000001, 18.841)
      ..lineTo(270.7190000000001, 16.921)
      ..cubicTo(269.9010000000001, 16.249, 268.9040000000001, 15.693,
          267.7910000000001, 15.266)
      ..close();
    canvas
      ..drawPath(
        speakerPath,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.003
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

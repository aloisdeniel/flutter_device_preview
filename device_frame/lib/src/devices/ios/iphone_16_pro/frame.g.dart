part of 'device.dart';

// Generated with https://fluttershapemaker.com and manually adjusted.
class _FramePainter extends CustomPainter {
  const _FramePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final buttonsPath = Path()
      ..moveTo(0, 372.804)
      ..cubicTo(0, 371.548, 1.176, 370.529, 2.627, 370.529)
      ..lineTo(6.131, 370.529)
      ..lineTo(6.131, 453.16499999999996)
      ..lineTo(2.627, 453.16499999999996)
      ..cubicTo(
        1.1769999999999998,
        453.16499999999996,
        0,
        452.147,
        0,
        450.89099999999996,
      )
      ..close()
      ..moveTo(0, 517.132)
      ..cubicTo(
        0,
        516.0329999999999,
        1.176,
        515.1429999999999,
        2.627,
        515.1429999999999,
      )
      ..lineTo(6.131, 515.1429999999999)
      ..lineTo(6.131, 649.76)
      ..lineTo(2.627, 649.76)
      ..cubicTo(1.1769999999999998, 649.76, 0, 648.869, 0, 647.77)
      ..close()
      ..moveTo(0, 688.4019999999999)
      ..cubicTo(
        0,
        687.3029999999999,
        1.176,
        686.4119999999999,
        2.627,
        686.4119999999999,
      )
      ..lineTo(6.131, 686.4119999999999)
      ..lineTo(6.131, 821.0289999999999)
      ..lineTo(2.627, 821.0289999999999)
      ..cubicTo(
        1.1769999999999998,
        821.0289999999999,
        0,
        820.1379999999999,
        0,
        819.0399999999998,
      )
      ..close()
      ..moveTo(873, 563.1239999999999)
      ..cubicTo(
        873,
        562.0199999999999,
        871.884,
        561.1249999999999,
        870.501,
        561.1249999999999,
      )
      ..lineTo(866.336, 561.1249999999999)
      ..lineTo(866.336, 774.38)
      ..lineTo(870.501, 774.38)
      ..cubicTo(871.884, 774.38, 873, 773.485, 873, 772.38)
      ..close();
    canvas.drawPath(
      buttonsPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF434343),
    );

    final buttonsShadowPath = Path()
      ..moveTo(6.131, 370.529)
      ..lineTo(6.131, 453.16499999999996)
      ..close()
      ..moveTo(6.131, 515.1429999999999)
      ..lineTo(6.131, 649.76)
      ..close()
      ..moveTo(6.131, 686.4119999999999)
      ..lineTo(6.131, 821.0289999999999)
      ..close()
      ..moveTo(866.336, 561.1249999999999)
      ..lineTo(866.336, 774.38)
      ..close();
    canvas.drawPath(
      buttonsShadowPath,
      Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width * 0.0125
        ..maskFilter = MaskFilter.blur(
          BlurStyle.inner,
          size.width * 0.035,
        ),
    );

    final backgroundPath = Path()
      ..moveTo(5.331, 245.243)
      ..cubicTo(
        5.331,
        159.39999999999998,
        5.331,
        116.47800000000001,
        22.037,
        83.69,
      )
      ..arcToPoint(
        const Offset(89.02099999999999, 16.706000000000003),
        radius: const Radius.elliptical(153.28, 153.28),
      )
      ..cubicTo(121.808, 0, 164.729, 0, 250.57, 0)
      ..lineTo(622.428, 0)
      ..cubicTo(708.269, 0, 751.192, 0, 783.98, 16.706)
      ..arcToPoint(
        const Offset(850.961, 83.69),
        radius: const Radius.elliptical(153.26, 153.26),
      )
      ..cubicTo(
        867.668,
        116.478,
        867.668,
        159.39999999999998,
        867.668,
        245.243,
      )
      ..lineTo(867.668, 1560.76)
      ..cubicTo(867.668, 1646.6, 867.668, 1689.52, 850.961, 1722.31)
      ..arcToPoint(
        const Offset(783.98, 1789.29),
        radius: const Radius.elliptical(153.23, 153.23),
      )
      ..cubicTo(751.193, 1806, 708.27, 1806, 622.429, 1806)
      ..lineTo(250.571, 1806)
      ..cubicTo(
        164.72899999999998,
        1806,
        121.80799999999999,
        1806,
        89.02099999999999,
        1789.29,
      )
      ..arcToPoint(
        const Offset(22.036999999999992, 1722.31),
        radius: const Radius.elliptical(153.24, 153.24),
      )
      ..cubicTo(
        5.330999999999992,
        1689.52,
        5.330999999999992,
        1646.6,
        5.330999999999992,
        1560.76,
      )
      ..close();
    canvas.drawPath(
      backgroundPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF434343),
    );

    final antennasPath = Path()
      ..moveTo(686.405, 0)
      ..lineTo(686.405, 13.328)
      ..lineTo(673.7429999999999, 13.328)
      ..lineTo(673.7429999999999, 0)
      ..close()
      ..moveTo(18.66, 199.26)
      ..lineTo(5.33, 199.26)
      ..lineTo(5.33, 186.59799999999998)
      ..lineTo(18.66, 186.59799999999998)
      ..close()
      ..moveTo(867.669, 199.26)
      ..lineTo(854.34, 199.26)
      ..lineTo(854.34, 186.59799999999998)
      ..lineTo(867.669, 186.59799999999998)
      ..close()
      ..moveTo(18.66, 1620.07)
      ..lineTo(5.33, 1620.07)
      ..lineTo(5.33, 1607.4099999999999)
      ..lineTo(18.66, 1607.4099999999999)
      ..close()
      ..moveTo(867.669, 1619.3999999999999)
      ..lineTo(854.34, 1619.3999999999999)
      ..lineTo(854.34, 1607.4099999999999)
      ..lineTo(867.669, 1607.4099999999999)
      ..close()
      ..moveTo(194.59199999999998, 1792.6699999999998)
      ..lineTo(194.59199999999998, 1806)
      ..lineTo(181.93, 1806)
      ..lineTo(181.93, 1792.67)
      ..close();
    canvas.drawPath(
      antennasPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0x40000000),
    );

    final bezelPath = Path()
      ..moveTo(629.626, 11.996)
      ..cubicTo(708.749, 11.996, 748.314, 11.996, 778.536, 27.395)
      ..arcToPoint(
        const Offset(840.2719999999999, 89.137),
        radius: const Radius.elliptical(141.25, 141.25),
      )
      ..cubicTo(
        855.6729999999999,
        119.358,
        855.6729999999999,
        158.921,
        855.6729999999999,
        238.046,
      )
      ..lineTo(855.6729999999999, 1567.96)
      ..cubicTo(
        855.6729999999999,
        1647.08,
        855.6729999999999,
        1686.64,
        840.2719999999999,
        1716.8700000000001,
      )
      ..arcToPoint(
        const Offset(778.536, 1778.6000000000001),
        radius: const Radius.elliptical(141.2, 141.2),
      )
      ..cubicTo(
        748.314,
        1794.0000000000002,
        708.7489999999999,
        1794.0100000000002,
        629.626,
        1794.0100000000002,
      )
      ..lineTo(243.374, 1794.0100000000002)
      ..cubicTo(
        164.25,
        1794.0100000000002,
        124.68799999999999,
        1794.0000000000002,
        94.46699999999998,
        1778.6000000000001,
      )
      ..arcToPoint(
        const Offset(32.72499999999999, 1716.8700000000001),
        radius: const Radius.elliptical(141.25, 141.25),
      )
      ..cubicTo(
        17.325999999999986,
        1686.64,
        17.326999999999988,
        1647.0800000000002,
        17.326999999999988,
        1567.96,
      )
      ..lineTo(17.326999999999988, 238.046)
      ..cubicTo(
        17.326999999999988,
        158.921,
        17.326999999999988,
        119.35799999999999,
        32.72499999999999,
        89.137,
      )
      ..arcToPoint(
        const Offset(94.46599999999998, 27.395000000000003),
        radius: const Radius.elliptical(141.3, 141.3),
      )
      ..cubicTo(
        124.68799999999999,
        11.996000000000004,
        164.25,
        11.996000000000004,
        243.37399999999997,
        11.996000000000004,
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
      ..moveTo(524.564, 57.979)
      ..lineTo(348.436, 57.979)
      ..cubicTo(
        328.24699999999996,
        57.979,
        311.881,
        73.941,
        311.881,
        93.632,
      )
      ..cubicTo(
        311.881,
        113.32300000000001,
        328.24699999999996,
        129.286,
        348.436,
        129.286,
      )
      ..lineTo(524.564, 129.286)
      ..cubicTo(
        544.7529999999999,
        129.286,
        561.1189999999999,
        113.32300000000001,
        561.1189999999999,
        93.632,
      )
      ..cubicTo(
        561.1189999999999,
        73.94200000000001,
        544.7529999999999,
        57.978,
        524.564,
        57.978,
      );
    canvas.drawPath(
      dynamicIslandPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF000000),
    );

    final cameraPath1 = Path()
      ..moveTo(524.564, 104.328)
      ..cubicTo(530.437, 104.328, 535.198, 99.684, 535.198, 93.956)
      ..cubicTo(
        535.198,
        88.22800000000001,
        530.437,
        83.584,
        524.564,
        83.584,
      )
      ..cubicTo(
        518.6909999999999,
        83.584,
        513.93,
        88.22800000000001,
        513.93,
        93.956,
      )
      ..cubicTo(
        513.93,
        99.684,
        518.6909999999999,
        104.328,
        524.564,
        104.328,
      );
    canvas.drawPath(
      cameraPath1,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF131423),
    );

    final cameraPath2 = Path()
      ..moveTo(533.204, 93.956)
      ..cubicTo(533.204, 89.302, 529.3359999999999, 85.529, 524.564, 85.529)
      ..cubicTo(
        519.792,
        85.529,
        515.924,
        89.30199999999999,
        515.924,
        93.95599999999999,
      )
      ..cubicTo(
        515.924,
        98.60999999999999,
        519.792,
        102.38299999999998,
        524.564,
        102.38299999999998,
      )
      ..cubicTo(
        529.3359999999999,
        102.38299999999998,
        533.204,
        98.60999999999999,
        533.204,
        93.95599999999999,
      );
    canvas.drawPath(
      cameraPath2,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF07144C),
    );

    final cameraPath3 = Path()
      ..moveTo(517.275, 93.48)
      ..cubicTo(517.4159999999999, 89.791, 520.733, 87.15, 524.518, 87.15)
      ..cubicTo(
        528.344,
        87.15,
        531.7040000000001,
        89.843,
        531.8530000000001,
        93.57100000000001,
      )
      ..cubicTo(
        531.8670000000001,
        93.92200000000001,
        531.8750000000001,
        94.269,
        531.8750000000001,
        94.60400000000001,
      )
      ..quadraticBezierTo(
        531.8750000000001,
        95.11000000000001,
        531.8530000000001,
        95.63800000000002,
      )
      ..cubicTo(
        531.7040000000001,
        99.36600000000001,
        528.344,
        102.05900000000003,
        524.518,
        102.05900000000003,
      )
      ..cubicTo(
        520.7330000000001,
        102.05900000000003,
        517.416,
        99.41800000000002,
        517.275,
        95.72900000000003,
      )
      ..arcToPoint(
        const Offset(517.275, 93.48000000000003),
        radius: const Radius.elliptical(30, 30),
      );
    canvas.drawPath(
      cameraPath3,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0x66030303),
    );

    final cameraPath4 = Path()
      ..moveTo(524.564, 100.763)
      ..cubicTo(
        526.399,
        100.763,
        527.887,
        99.45700000000001,
        527.887,
        97.846,
      )
      ..cubicTo(
        527.887,
        96.23400000000001,
        526.3989999999999,
        94.928,
        524.564,
        94.928,
      )
      ..cubicTo(522.729, 94.928, 521.241, 96.234, 521.241, 97.846)
      ..cubicTo(521.241, 99.456, 522.729, 100.763, 524.564, 100.763);
    canvas.drawPath(
      cameraPath4,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.5000000, size.height * 0.03210299),
          Offset(size.width * 0.5000000, size.height * 0.07158693),
          const [Color(0x451D869C), Color(0x4C2371C6), Color(0x4C040AAD)],
          const [0, 0.371, 1],
        ),
    );

    final cameraPath5 = Path()
      ..moveTo(524.564, 100.763)
      ..cubicTo(
        525.665,
        100.763,
        526.558,
        99.89200000000001,
        526.558,
        98.81800000000001,
      )
      ..cubicTo(
        526.558,
        97.74400000000001,
        525.665,
        96.87300000000002,
        524.564,
        96.87300000000002,
      )
      ..cubicTo(
        523.463,
        96.87300000000002,
        522.5699999999999,
        97.74300000000002,
        522.5699999999999,
        98.81800000000001,
      )
      ..cubicTo(
        522.5699999999999,
        99.89200000000001,
        523.463,
        100.763,
        524.564,
        100.763,
      );
    canvas.drawPath(
      cameraPath5,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.5000000, size.height * 0.03539369),
          Offset(size.width * 0.5000000, size.height * 0.07158693),
          const [Color(0x59005267), Color(0x59415967), Color(0x598700C7)],
          const [0, 0.486, 1],
        ),
    );

    final cameraPath6 = Path()
      ..moveTo(524.564, 99.142)
      ..cubicTo(
        527.501,
        99.142,
        529.881,
        96.82,
        529.881,
        93.95599999999999,
      )
      ..cubicTo(
        529.881,
        91.09199999999998,
        527.501,
        88.76999999999998,
        524.564,
        88.76999999999998,
      )
      ..cubicTo(
        521.6279999999999,
        88.76999999999998,
        519.247,
        91.09199999999998,
        519.247,
        93.95599999999999,
      )
      ..cubicTo(519.247, 96.82, 521.6279999999999, 99.142, 524.564, 99.142);
    canvas.drawPath(
      cameraPath6,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.6008751, size.height * 0.04897342),
          Offset(size.width * 0.6008751, size.height * 0.05166556),
          const [Color(0xFF5978DD), Color(0x9C312FAD), Color(0x001C1C86)],
          const [0, 0.379, 1],
        ),
    );

    final speakerPath = Path()
      ..moveTo(522.696, 12.828)
      ..arcToPoint(
        const Offset(521.342, 14.142),
        radius: const Radius.elliptical(6, 6),
        clockwise: false,
      )
      ..lineTo(521.131, 14.44)
      ..lineTo(519.929, 16.242)
      ..cubicTo(
        519.255,
        17.252000000000002,
        518.213,
        17.826,
        517.129,
        17.826,
      )
      ..lineTo(355.871, 17.826)
      ..cubicTo(
        354.85499999999996,
        17.826,
        353.875,
        17.322,
        353.202,
        16.426000000000002,
      )
      ..lineTo(353.071, 16.242)
      ..lineTo(351.87, 14.439)
      ..arcToPoint(
        const Offset(350.303, 12.829),
        radius: const Radius.elliptical(6.1, 6.1),
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

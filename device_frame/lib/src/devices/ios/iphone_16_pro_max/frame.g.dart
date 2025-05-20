part of 'device.dart';

// Generated with https://fluttershapemaker.com and manually adjusted.
class _FramePainter extends CustomPainter {
  const _FramePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final buttonsPath = Path()
      ..moveTo(0, 343.528)
      ..cubicTo(
        0,
        342.372,
        1.176,
        341.43600000000004,
        2.627,
        341.43600000000004,
      )
      ..lineTo(6.131, 341.43600000000004)
      ..lineTo(6.131, 417.446)
      ..lineTo(2.627, 417.446)
      ..cubicTo(
        1.1769999999999998,
        417.446,
        0,
        416.51000000000005,
        0,
        415.35400000000004,
      )
      ..close()
      ..moveTo(0, 476.898)
      ..cubicTo(
        0,
        475.88800000000003,
        1.176,
        475.06800000000004,
        2.627,
        475.06800000000004,
      )
      ..lineTo(6.131, 475.06800000000004)
      ..lineTo(6.131, 598.892)
      ..lineTo(2.627, 598.892)
      ..cubicTo(
        1.1769999999999998,
        598.892,
        0,
        598.0730000000001,
        0,
        597.0630000000001,
      )
      ..close()
      ..moveTo(0, 633.822)
      ..cubicTo(0, 632.811, 1.176, 631.992, 2.627, 631.992)
      ..lineTo(6.131, 631.992)
      ..lineTo(6.131, 755.8159999999999)
      ..lineTo(2.627, 755.8159999999999)
      ..cubicTo(
        1.1769999999999998,
        755.8159999999999,
        0,
        754.997,
        0,
        753.9859999999999,
      )
      ..close()
      ..moveTo(873, 518.5889999999999)
      ..cubicTo(
        873,
        517.573,
        871.973,
        516.7499999999999,
        870.701,
        516.7499999999999,
      )
      ..lineTo(866.869, 516.7499999999999)
      ..lineTo(866.869, 712.9069999999999)
      ..lineTo(870.701, 712.9069999999999)
      ..cubicTo(
        871.9730000000001,
        712.9069999999999,
        873,
        712.084,
        873,
        711.0679999999999,
      )
      ..close();
    canvas.drawPath(
      buttonsPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF434343),
    );

    final buttonsShadowPath = Path()
      ..moveTo(6.131, 341.43600000000004)
      ..lineTo(6.131, 417.446)
      ..close()
      ..moveTo(6.131, 475.06800000000004)
      ..lineTo(6.131, 598.892)
      ..close()
      ..moveTo(6.131, 631.992)
      ..lineTo(6.131, 755.8159999999999)
      ..close()
      ..moveTo(866.869, 516.7499999999999)
      ..lineTo(866.869, 712.9069999999999)
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
      ..moveTo(4.905, 225.581)
      ..cubicTo(4.905, 146.62, 4.905, 107.13999999999999, 20.273, 76.981)
      ..arcToPoint(
        const Offset(81.894, 15.366999999999997),
        radius: const Radius.elliptical(141, 141),
      )
      ..cubicTo(112.057, 0, 151.542, 0, 230.511, 0)
      ..lineTo(642.489, 0)
      ..cubicTo(721.457, 0, 760.945, 0, 791.107, 15.367)
      ..arcToPoint(
        const Offset(852.726, 76.981),
        radius: const Radius.elliptical(140.98, 140.98),
      )
      ..cubicTo(
        868.096,
        107.13999999999999,
        868.096,
        146.62,
        868.096,
        225.581,
      )
      ..lineTo(868.096, 1586.42)
      ..cubicTo(
        868.096,
        1665.38,
        868.096,
        1704.8600000000001,
        852.726,
        1735.02,
      )
      ..arcToPoint(
        const Offset(791.107, 1796.6299999999999),
        radius: const Radius.elliptical(140.92, 140.92),
      )
      ..cubicTo(760.945, 1812, 721.457, 1812, 642.489, 1812)
      ..lineTo(230.511, 1812)
      ..cubicTo(151.542, 1812, 112.057, 1812, 81.894, 1796.63)
      ..arcToPoint(
        const Offset(20.274000000000008, 1735.0200000000002),
        radius: const Radius.elliptical(140.94, 140.94),
      )
      ..cubicTo(
        4.904000000000009,
        1704.8600000000001,
        4.904000000000009,
        1665.38,
        4.904000000000009,
        1586.4200000000003,
      )
      ..close();
    canvas.drawPath(
      backgroundPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF434343),
    );

    final antennasPath = Path()
      ..moveTo(701.956, 0)
      ..lineTo(701.956, 12.26)
      ..lineTo(690.308, 12.26)
      ..lineTo(690.308, 0)
      ..close()
      ..moveTo(17.166, 183.283)
      ..lineTo(4.905, 183.283)
      ..lineTo(4.905, 171.636)
      ..lineTo(17.165, 171.636)
      ..close()
      ..moveTo(868.096, 183.283)
      ..lineTo(855.8340000000001, 183.283)
      ..lineTo(855.8340000000001, 171.636)
      ..lineTo(868.096, 171.636)
      ..close()
      ..moveTo(17.166, 1640.98)
      ..lineTo(4.905, 1640.98)
      ..lineTo(4.905, 1629.33)
      ..lineTo(17.165, 1629.33)
      ..close()
      ..moveTo(868.096, 1489.57)
      ..lineTo(855.8340000000001, 1489.57)
      ..lineTo(855.8340000000001, 1478.53)
      ..lineTo(868.096, 1478.53)
      ..close()
      ..moveTo(182.692, 1799.74)
      ..lineTo(182.692, 1812)
      ..lineTo(171.044, 1812)
      ..lineTo(171.044, 1799.74)
      ..close();
    canvas.drawPath(
      antennasPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0x40000000),
    );

    final bezelPath = Path()
      ..moveTo(649.11, 11.033)
      ..cubicTo(721.899, 11.033, 758.296, 11.033, 786.099, 25.197)
      ..arcToPoint(
        const Offset(842.893, 81.989),
        radius: const Radius.elliptical(129.94, 129.94),
      )
      ..cubicTo(
        857.0600000000001,
        109.78800000000001,
        857.0600000000001,
        146.179,
        857.0600000000001,
        218.96,
      )
      ..lineTo(857.0600000000001, 1593.04)
      ..cubicTo(
        857.0600000000001,
        1665.82,
        857.0600000000001,
        1702.21,
        842.893,
        1730.01,
      )
      ..arcToPoint(
        const Offset(786.099, 1786.8),
        radius: const Radius.elliptical(129.95, 129.95),
      )
      ..cubicTo(758.296, 1800.97, 721.899, 1800.97, 649.11, 1800.97)
      ..lineTo(223.89, 1800.97)
      ..cubicTo(
        151.101,
        1800.97,
        114.70599999999999,
        1800.97,
        86.904,
        1786.8,
      )
      ..arcToPoint(
        const Offset(30.104999999999997, 1730.01),
        radius: const Radius.elliptical(129.98, 129.98),
      )
      ..cubicTo(
        15.939999999999998,
        1702.21,
        15.939999999999998,
        1665.82,
        15.939999999999998,
        1593.04,
      )
      ..lineTo(15.939999999999998, 218.96)
      ..cubicTo(
        15.939999999999998,
        146.179,
        15.939999999999998,
        109.78800000000001,
        30.104999999999997,
        81.99000000000001,
      )
      ..arcToPoint(
        const Offset(86.904, 25.19700000000001),
        radius: const Radius.elliptical(129.96, 129.96),
      )
      ..cubicTo(
        114.70599999999999,
        11.03300000000001,
        151.101,
        11.03300000000001,
        223.89,
        11.03300000000001,
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
      ..moveTo(517.514, 53.33)
      ..lineTo(355.486, 53.33)
      ..cubicTo(
        336.913,
        53.33,
        321.85699999999997,
        68.013,
        321.85699999999997,
        86.125,
      )
      ..cubicTo(
        321.85699999999997,
        104.237,
        336.91299999999995,
        118.92,
        355.486,
        118.92,
      )
      ..lineTo(517.514, 118.92)
      ..cubicTo(536.087, 118.92, 551.143, 104.237, 551.143, 86.125)
      ..cubicTo(551.143, 68.013, 536.087, 53.33, 517.514, 53.33);
    canvas.drawPath(
      dynamicIslandPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF000000),
    );

    final cameraPath1 = Path()
      ..moveTo(517.514, 95.964)
      ..cubicTo(522.917, 95.964, 527.297, 91.692, 527.297, 86.424)
      ..cubicTo(
        527.297,
        81.15400000000001,
        522.917,
        76.88300000000001,
        517.514,
        76.88300000000001,
      )
      ..cubicTo(
        512.111,
        76.88300000000001,
        507.731,
        81.15400000000001,
        507.731,
        86.423,
      )
      ..cubicTo(507.731, 91.693, 512.111, 95.963, 517.514, 95.963);
    canvas.drawPath(
      cameraPath1,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF131423),
    );

    final cameraPath2 = Path()
      ..moveTo(525.463, 86.423)
      ..cubicTo(525.463, 82.143, 521.904, 78.672, 517.514, 78.672)
      ..cubicTo(513.124, 78.672, 509.565, 82.142, 509.565, 86.423)
      ..cubicTo(
        509.565,
        90.70400000000001,
        513.124,
        94.175,
        517.514,
        94.175,
      )
      ..cubicTo(521.904, 94.175, 525.463, 90.705, 525.463, 86.423);
    canvas.drawPath(
      cameraPath2,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF07144C),
    );

    final cameraPath3 = Path()
      ..moveTo(510.809, 85.986)
      ..cubicTo(510.93800000000005, 82.592, 513.99, 80.162, 517.472, 80.162)
      ..cubicTo(520.991, 80.162, 524.082, 82.64, 524.22, 86.069)
      ..arcToPoint(
        const Offset(524.22, 87.96900000000001),
        radius: const Radius.elliptical(24, 24),
      )
      ..cubicTo(
        524.082,
        91.39900000000002,
        520.991,
        93.87700000000001,
        517.472,
        93.87700000000001,
      )
      ..cubicTo(
        513.99,
        93.87700000000001,
        510.938,
        91.447,
        510.80899999999997,
        88.05300000000001,
      )
      ..arcToPoint(
        const Offset(510.78799999999995, 87.019),
        radius: const Radius.elliptical(28, 28),
      )
      ..quadraticBezierTo(
        510.78799999999995,
        86.50500000000001,
        510.80899999999997,
        85.986,
      );
    canvas.drawPath(
      cameraPath3,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0x66030303),
    );

    final cameraPath4 = Path()
      ..moveTo(517.514, 92.684)
      ..cubicTo(519.202, 92.684, 520.571, 91.483, 520.571, 90.001)
      ..cubicTo(
        520.571,
        88.519,
        519.202,
        87.31800000000001,
        517.514,
        87.31800000000001,
      )
      ..cubicTo(
        515.826,
        87.31800000000001,
        514.457,
        88.51800000000001,
        514.457,
        90.001,
      )
      ..cubicTo(514.457, 91.484, 515.826, 92.684, 517.514, 92.684);
    canvas.drawPath(
      cameraPath4,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.5000000, size.height * 0.02943157),
          Offset(size.width * 0.5000000, size.height * 0.06562914),
          const [Color(0x451D869C), Color(0x4C2371C6), Color(0x4C040AAD)],
          const [0, 0.371, 1],
        ),
    );

    final cameraPath5 = Path()
      ..moveTo(517.514, 92.684)
      ..cubicTo(518.527, 92.684, 519.348, 91.884, 519.348, 90.895)
      ..cubicTo(
        519.348,
        89.90599999999999,
        518.5269999999999,
        89.106,
        517.514,
        89.106,
      )
      ..cubicTo(
        516.5010000000001,
        89.106,
        515.6800000000001,
        89.907,
        515.6800000000001,
        90.896,
      )
      ..cubicTo(
        515.6800000000001,
        91.883,
        516.5010000000001,
        92.684,
        517.514,
        92.684,
      );
    canvas.drawPath(
      cameraPath5,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.5000000, size.height * 0.03244812),
          Offset(size.width * 0.5000000, size.height * 0.06562914),
          const [Color(0x59005267), Color(0x59415967), Color(0x598700C7)],
          const [0, 0.486, 1],
        ),
    );

    final cameraPath6 = Path()
      ..moveTo(517.514, 91.193)
      ..cubicTo(
        520.215,
        91.193,
        522.405,
        89.05799999999999,
        522.405,
        86.423,
      )
      ..cubicTo(
        522.405,
        83.78800000000001,
        520.2149999999999,
        81.653,
        517.514,
        81.653,
      )
      ..cubicTo(
        514.8130000000001,
        81.653,
        512.623,
        83.789,
        512.623,
        86.423,
      )
      ..cubicTo(
        512.623,
        89.058,
        514.8130000000001,
        91.193,
        517.514,
        91.193,
      );
    canvas.drawPath(
      cameraPath6,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.5927995, size.height * 0.04489790),
          Offset(size.width * 0.5927995, size.height * 0.04736589),
          const [Color(0xFF5978DD), Color(0x9C312FAD), Color(0x001C1C86)],
          const [0, 0.379, 1],
        ),
    );

    final speakerPath = Path()
      ..moveTo(515.668, 11.84)
      ..cubicTo(515.24, 12.156, 514.851, 12.54, 514.518, 12.983)
      ..lineTo(514.322, 13.26)
      ..lineTo(513.217, 14.918)
      ..cubicTo(
        512.6039999999999,
        15.838,
        511.657,
        16.355999999999998,
        510.675,
        16.355999999999998,
      )
      ..lineTo(362.32500000000005, 16.355999999999998)
      ..cubicTo(
        361.40400000000005,
        16.355999999999998,
        360.51500000000004,
        15.899999999999999,
        359.90200000000004,
        15.085999999999999,
      )
      ..lineTo(359.783, 14.918)
      ..lineTo(358.678, 13.26)
      ..arcToPoint(
        const Offset(357.332, 11.84),
        radius: const Radius.elliptical(5.7, 5.7),
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

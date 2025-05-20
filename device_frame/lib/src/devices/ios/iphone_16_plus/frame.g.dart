part of 'device.dart';

// Generated with https://fluttershapemaker.com and manually adjusted.
class _FramePainter extends CustomPainter {
  const _FramePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final buttonsPath = Path()
      ..moveTo(0, 342.271)
      ..cubicTo(0, 341.106, 1.1, 340.16200000000003, 2.457, 340.16200000000003)
      ..lineTo(5.733, 340.16200000000003)
      ..lineTo(5.733, 416.77500000000003)
      ..lineTo(2.457, 416.77500000000003)
      ..cubicTo(
        1.0999999999999999,
        416.77500000000003,
        0,
        415.831,
        0,
        414.66600000000005,
      )
      ..close()
      ..moveTo(0, 475.603)
      ..cubicTo(0, 474.593, 1.1, 473.773, 2.457, 473.773)
      ..lineTo(5.733, 473.773)
      ..lineTo(5.733, 597.58)
      ..lineTo(2.457, 597.58)
      ..cubicTo(1.1, 597.58, 0, 596.761, 0, 595.75)
      ..close()
      ..moveTo(0, 633.121)
      ..cubicTo(0, 632.11, 1.21, 631.2909999999999, 2.703, 631.2909999999999)
      ..lineTo(6.307, 631.2909999999999)
      ..lineTo(6.307, 755.097)
      ..lineTo(2.703, 755.097)
      ..cubicTo(1.2099999999999997, 755.097, 0, 754.278, 0, 753.268)
      ..close()
      ..moveTo(873, 517.29)
      ..cubicTo(
        873,
        516.274,
        871.973,
        515.4509999999999,
        870.701,
        515.4509999999999,
      )
      ..lineTo(866.869, 515.4509999999999)
      ..lineTo(866.869, 711.58)
      ..lineTo(870.701, 711.58)
      ..cubicTo(871.9730000000001, 711.58, 873, 710.7570000000001, 873, 709.741)
      ..close();
    canvas.drawPath(
      buttonsPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF4E4E4E),
    );

    final buttonsShadowPath = Path()
      ..moveTo(5.733, 340.16200000000003)
      ..lineTo(5.733, 416.77500000000003)
      ..close()
      ..moveTo(5.733, 473.773)
      ..lineTo(5.733, 597.58)
      ..close()
      ..moveTo(5.733, 631.2909999999999)
      ..lineTo(5.733, 755.097)
      ..close()
      ..moveTo(866.869, 515.4509999999999)
      ..lineTo(866.869, 711.58)
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
      ..moveTo(4.905, 218.684)
      ..cubicTo(4.905, 142.137, 4.905, 103.864, 19.805, 74.62700000000001)
      ..arcToPoint(
        const Offset(79.551, 14.897000000000013),
        radius: const Radius.elliptical(136.7, 136.7),
      )
      ..cubicTo(108.795, 0, 147.078, 0, 223.645, 0)
      ..lineTo(649.355, 0)
      ..cubicTo(725.9200000000001, 0, 764.206, 0, 793.4490000000001, 14.897)
      ..arcToPoint(
        const Offset(853.1920000000001, 74.627),
        radius: const Radius.elliptical(136.7, 136.7),
      )
      ..cubicTo(
        868.0960000000001,
        103.86399999999999,
        868.0960000000001,
        142.137,
        868.0960000000001,
        218.68399999999997,
      )
      ..lineTo(868.0960000000001, 1567.32)
      ..cubicTo(
        868.0960000000001,
        1643.86,
        868.0960000000001,
        1682.1399999999999,
        853.1920000000001,
        1711.37,
      )
      ..arcToPoint(
        const Offset(793.4490000000001, 1771.1),
        radius: const Radius.elliptical(136.66, 136.66),
      )
      ..cubicTo(764.206, 1786, 725.9200000000001, 1786, 649.355, 1786)
      ..lineTo(223.64500000000004, 1786)
      ..cubicTo(
        147.07800000000003,
        1786,
        108.79500000000004,
        1786,
        79.55100000000004,
        1771.1,
      )
      ..arcToPoint(
        const Offset(19.805000000000042, 1711.37),
        radius: const Radius.elliptical(136.66, 136.66),
      )
      ..cubicTo(
        4.905000000000042,
        1682.1399999999999,
        4.905000000000042,
        1643.86,
        4.905000000000042,
        1567.32,
      )
      ..close();
    canvas.drawPath(
      backgroundPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF4E4E4E),
    );

    final antennasPath = Path()
      ..moveTo(703.182, 0)
      ..lineTo(703.182, 12.258)
      ..lineTo(690.921, 12.258)
      ..lineTo(690.921, 0)
      ..close()
      ..moveTo(17.166, 183.258)
      ..lineTo(4.905, 183.258)
      ..lineTo(4.905, 171.613)
      ..lineTo(17.165, 171.613)
      ..close()
      ..moveTo(868.096, 183.258)
      ..lineTo(855.8340000000001, 183.258)
      ..lineTo(855.8340000000001, 171.613)
      ..lineTo(868.096, 171.613)
      ..close()
      ..moveTo(17.166, 1614.39)
      ..lineTo(4.905, 1614.39)
      ..lineTo(4.905, 1602.74)
      ..lineTo(17.165, 1602.74)
      ..close()
      ..moveTo(868.096, 1614.39)
      ..lineTo(855.8340000000001, 1614.39)
      ..lineTo(855.8340000000001, 1602.74)
      ..lineTo(868.096, 1602.74)
      ..close()
      ..moveTo(182.692, 1773.74)
      ..lineTo(182.692, 1786)
      ..lineTo(171.044, 1786)
      ..lineTo(171.044, 1773.74)
      ..close();
    canvas.drawPath(
      antennasPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0x40000000),
    );

    final bezelPath = Path()
      ..moveTo(15.94, 212.065)
      ..cubicTo(15.94, 141.697, 15.94, 106.514, 29.637999999999998, 79.637)
      ..arcToPoint(
        const Offset(84.561, 24.727000000000004),
        radius: const Radius.elliptical(125.66, 125.66),
      )
      ..cubicTo(
        111.44500000000001,
        11.033000000000003,
        146.638,
        11.033000000000003,
        217.024,
        11.033000000000003,
      )
      ..lineTo(655.976, 11.033000000000003)
      ..cubicTo(
        726.362,
        11.033000000000003,
        761.558,
        11.033000000000003,
        788.44,
        24.728,
      )
      ..arcToPoint(
        const Offset(843.365, 79.637),
        radius: const Radius.elliptical(125.7, 125.7),
      )
      ..cubicTo(
        857.0600000000001,
        106.514,
        857.0600000000001,
        141.697,
        857.0600000000001,
        212.065,
      )
      ..lineTo(857.0600000000001, 1573.94)
      ..cubicTo(
        857.0600000000001,
        1644.3,
        857.0600000000001,
        1679.49,
        843.365,
        1706.3700000000001,
      )
      ..arcToPoint(
        const Offset(788.44, 1761.2800000000002),
        radius: const Radius.elliptical(125.73, 125.73),
      )
      ..cubicTo(
        761.5580000000001,
        1774.9700000000003,
        726.3620000000001,
        1774.9700000000003,
        655.9760000000001,
        1774.9700000000003,
      )
      ..lineTo(217.024, 1774.9700000000003)
      ..cubicTo(
        146.638,
        1774.9700000000003,
        111.44500000000001,
        1774.9700000000003,
        84.561,
        1761.2800000000002,
      )
      ..arcToPoint(
        const Offset(29.638000000000005, 1706.3700000000001),
        radius: const Radius.elliptical(125.7, 125.7),
      )
      ..cubicTo(
        15.940000000000005,
        1679.49,
        15.940000000000005,
        1644.3000000000002,
        15.940000000000005,
        1573.94,
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
      ..moveTo(517.947, 57)
      ..lineTo(355.053, 57)
      ..cubicTo(336.381, 57, 321.244, 72.092, 321.244, 90.71000000000001)
      ..cubicTo(
        321.244,
        109.32700000000001,
        336.38100000000003,
        124.41900000000001,
        355.053,
        124.41900000000001,
      )
      ..lineTo(517.947, 124.41900000000001)
      ..cubicTo(
        536.619,
        124.41900000000001,
        551.756,
        109.32700000000001,
        551.756,
        90.709,
      )
      ..cubicTo(551.756, 72.092, 536.6189999999999, 57, 517.947, 57);
    canvas.drawPath(
      dynamicIslandPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF000000),
    );

    final cameraPath1 = Path()
      ..moveTo(517.947, 100.823)
      ..cubicTo(
        523.379,
        100.823,
        527.782,
        96.43299999999999,
        527.782,
        91.01599999999999,
      )
      ..cubicTo(527.782, 85.6, 523.379, 81.21, 517.947, 81.21)
      ..cubicTo(512.516, 81.21, 508.112, 85.6, 508.112, 91.01599999999999)
      ..cubicTo(
        508.112,
        96.43199999999999,
        512.5160000000001,
        100.823,
        517.947,
        100.823,
      );
    canvas.drawPath(
      cameraPath1,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF131423),
    );

    final cameraPath2 = Path()
      ..moveTo(525.938, 91.016)
      ..cubicTo(525.938, 86.616, 522.361, 83.048, 517.947, 83.048)
      ..cubicTo(513.533, 83.048, 509.956, 86.616, 509.956, 91.016)
      ..cubicTo(
        509.956,
        95.41600000000001,
        513.534,
        98.98400000000001,
        517.947,
        98.98400000000001,
      )
      ..cubicTo(522.36, 98.98400000000001, 525.938, 95.417, 525.938, 91.016);
    canvas.drawPath(
      cameraPath2,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF07144C),
    );

    final cameraPath3 = Path()
      ..moveTo(511.206, 90.566)
      ..cubicTo(511.336, 87.078, 514.404, 84.581, 517.905, 84.581)
      ..cubicTo(521.443, 84.581, 524.55, 87.12700000000001, 524.689, 90.652)
      ..arcToPoint(
        const Offset(524.689, 92.606),
        radius: const Radius.elliptical(25, 25),
      )
      ..cubicTo(
        524.55,
        96.131,
        521.443,
        98.67699999999999,
        517.905,
        98.67699999999999,
      )
      ..cubicTo(
        514.404,
        98.67699999999999,
        511.33599999999996,
        96.17999999999999,
        511.20599999999996,
        92.692,
      )
      ..arcToPoint(
        const Offset(511.20599999999996, 90.56599999999999),
        radius: const Radius.elliptical(29, 29),
      );
    canvas.drawPath(
      cameraPath3,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0x66030303),
    );

    final cameraPath4 = Path()
      ..moveTo(517.947, 97.452)
      ..cubicTo(519.645, 97.452, 521.021, 96.217, 521.021, 94.694)
      ..cubicTo(521.021, 93.17, 519.645, 91.936, 517.947, 91.936)
      ..cubicTo(516.249, 91.936, 514.874, 93.17, 514.874, 94.69300000000001)
      ..cubicTo(
        514.874,
        96.21600000000002,
        516.25,
        97.45200000000001,
        517.947,
        97.45200000000001,
      );
    canvas.drawPath(
      cameraPath4,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.5000000, size.height * 0.03191489),
          Offset(size.width * 0.5000000, size.height * 0.06966349),
          const [Color(0x451D869C), Color(0x4C2371C6), Color(0x4C040AAD)],
          const [0, 0.371, 1],
        ),
    );

    final cameraPath5 = Path()
      ..moveTo(517.947, 97.452)
      ..arcToPoint(
        const Offset(519.791, 95.612),
        radius: const Radius.elliptical(1.84, 1.84),
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(517.947, 93.774),
        radius: const Radius.elliptical(1.84, 1.84),
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(516.103, 95.613),
        radius: const Radius.elliptical(1.84, 1.84),
        clockwise: false,
      )
      ..cubicTo(516.103, 96.628, 516.929, 97.452, 517.947, 97.452);
    canvas.drawPath(
      cameraPath5,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.5000000, size.height * 0.03506047),
          Offset(size.width * 0.5000000, size.height * 0.06966349),
          const [Color(0x59005267), Color(0x59415967), Color(0x598700C7)],
          const [0, 0.486, 1],
        ),
    );

    final cameraPath6 = Path()
      ..moveTo(517.947, 95.92)
      ..arcToPoint(
        const Offset(522.865, 91.016),
        radius: const Radius.elliptical(4.91, 4.91),
        clockwise: false,
      )
      ..cubicTo(522.865, 88.308, 520.663, 86.113, 517.947, 86.113)
      ..arcToPoint(
        const Offset(513.03, 91.016),
        radius: const Radius.elliptical(4.91, 4.91),
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(517.947, 95.91900000000001),
        radius: const Radius.elliptical(4.91, 4.91),
        clockwise: false,
      );
    canvas.drawPath(
      cameraPath6,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.5932955, size.height * 0.04804367),
          Offset(size.width * 0.5932955, size.height * 0.05061758),
          const [Color(0xFF5978DD), Color(0x9C312FAD), Color(0x001C1C86)],
          const [0, 0.379, 1],
        ),
    );

    final speakerPath = Path()
      ..moveTo(515.668, 11.838)
      ..cubicTo(
        515.24,
        12.154,
        514.851,
        12.537999999999998,
        514.518,
        12.981,
      )
      ..lineTo(514.322, 13.257)
      ..lineTo(513.217, 14.916)
      ..cubicTo(
        512.6039999999999,
        15.836,
        511.657,
        16.354,
        510.675,
        16.355,
      )
      ..lineTo(362.32500000000005, 16.355)
      ..cubicTo(
        361.40400000000005,
        16.355,
        360.51500000000004,
        15.898,
        359.90200000000004,
        15.083,
      )
      ..lineTo(359.783, 14.916)
      ..lineTo(358.678, 13.256)
      ..arcToPoint(
        const Offset(357.332, 11.838000000000001),
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

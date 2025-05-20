part of 'device.dart';

// Generated with https://fluttershapemaker.com and manually adjusted.
class _FramePainter extends CustomPainter {
  const _FramePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final buttonsPath = Path()
      ..moveTo(0.276, 313.735)
      ..cubicTo(0.276, 312.617, 1.571, 311.711, 3.168, 311.711)
      ..lineTo(7.024, 311.711)
      ..lineTo(7.024, 385.25300000000004)
      ..lineTo(3.168, 385.25300000000004)
      ..cubicTo(
        1.5710000000000002,
        385.25300000000004,
        0.27600000000000025,
        384.34700000000004,
        0.27600000000000025,
        383.22900000000004,
      )
      ..close()
      ..moveTo(0.276, 446.651)
      ..cubicTo(
        0.276,
        445.533,
        1.571,
        444.62600000000003,
        3.168,
        444.62600000000003,
      )
      ..lineTo(7.024, 444.62600000000003)
      ..lineTo(7.024, 581.59)
      ..lineTo(3.168, 581.59)
      ..cubicTo(
        1.5710000000000002,
        581.59,
        0.27600000000000025,
        580.6840000000001,
        0.27600000000000025,
        579.566,
      )
      ..close()
      ..moveTo(0.276, 620.048)
      ..cubicTo(0.276, 618.93, 1.571, 618.024, 3.168, 618.024)
      ..lineTo(7.024, 618.024)
      ..lineTo(7.024, 754.988)
      ..lineTo(3.168, 754.988)
      ..cubicTo(
        1.5710000000000002,
        754.988,
        0.27600000000000025,
        754.0820000000001,
        0.27600000000000025,
        752.964,
      )
      ..close()
      ..moveTo(872.723, 541.108)
      ..cubicTo(872.723, 539.9899999999999, 871.593, 539.084, 870.193, 539.084)
      ..lineTo(865.976, 539.084)
      ..lineTo(865.976, 754.9879999999999)
      ..lineTo(870.193, 754.9879999999999)
      ..cubicTo(
        871.593,
        754.9879999999999,
        872.723,
        754.082,
        872.723,
        752.9639999999999,
      )
      ..close();
    canvas.drawPath(
      buttonsPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF454C60),
    );

    final buttonsShadowPath = Path()
      ..moveTo(7.024, 313.735)
      ..lineTo(7.024, 385.25300000000004)
      ..close()
      ..moveTo(7.024, 446.651)
      ..lineTo(7.024, 581.59)
      ..close()
      ..moveTo(7.024, 620.048)
      ..lineTo(7.024, 754.988)
      ..close()
      ..moveTo(865.976, 541.108)
      ..lineTo(865.976, 754.9879999999999)
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
      ..moveTo(5, 232.096)
      ..cubicTo(
        5,
        150.85500000000002,
        5,
        110.23400000000001,
        20.811999999999998,
        79.20400000000001,
      )
      ..arcToPoint(
        const Offset(84.21, 15.811),
        radius: const Radius.elliptical(145.07, 145.07),
      )
      ..cubicTo(115.242, 0, 155.866, 0, 237.113, 0)
      ..lineTo(635.887, 0)
      ..cubicTo(717.1339999999999, 0, 757.76, 0, 788.7919999999999, 15.81)
      ..arcToPoint(
        const Offset(852.1909999999999, 79.204),
        radius: const Radius.elliptical(145.1, 145.1),
      )
      ..cubicTo(868, 110.234, 868, 150.855, 868, 232.096)
      ..lineTo(868, 1559.9)
      ..cubicTo(868, 1641.14, 868, 1681.77, 852.191, 1712.8000000000002)
      ..arcToPoint(
        const Offset(788.792, 1776.1900000000003),
        radius: const Radius.elliptical(145.15, 145.15),
      )
      ..cubicTo(757.76, 1792, 717.134, 1792, 635.887, 1792)
      ..lineTo(237.113, 1792)
      ..cubicTo(
        155.86599999999999,
        1792,
        115.242,
        1792,
        84.21000000000001,
        1776.19,
      )
      ..arcToPoint(
        const Offset(20.812000000000005, 1712.8),
        radius: const Radius.elliptical(145.1, 145.1),
      )
      ..cubicTo(5, 1681.77, 5, 1641.14, 5, 1559.9)
      ..close();
    canvas.drawPath(
      backgroundPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF454C60),
    );

    final antennasPath = Path()
      ..moveTo(685.119, 12.85)
      ..lineTo(672.268, 12.85)
      ..lineTo(672.268, 0)
      ..lineTo(685.119, 0)
      ..close()
      ..moveTo(17.145, 201.735)
      ..lineTo(5, 201.735)
      ..lineTo(5, 188.91600000000003)
      ..lineTo(17.145, 188.91600000000003)
      ..close()
      ..moveTo(868, 201.637)
      ..lineTo(855.148, 201.637)
      ..lineTo(855.148, 188.788)
      ..lineTo(868, 188.788)
      ..close()
      ..moveTo(17.145, 1603.08)
      ..lineTo(5, 1603.08)
      ..lineTo(5, 1590.27)
      ..lineTo(17.145, 1590.27)
      ..close()
      ..moveTo(868, 1603.21)
      ..lineTo(854.16, 1603.21)
      ..lineTo(854.16, 1591.3500000000001)
      ..lineTo(868, 1591.3500000000001)
      ..close()
      ..moveTo(200.73199999999997, 1779.15)
      ..lineTo(200.73199999999997, 1792)
      ..lineTo(187.88099999999997, 1792)
      ..lineTo(187.88099999999997, 1779.15)
      ..close();
    canvas.drawPath(
      antennasPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0x40000000),
    );

    final bezelPath = Path()
      ..moveTo(722.255, 12.145)
      ..lineTo(150.745, 12.145)
      ..cubicTo(
        76.96000000000001,
        12.145,
        17.14500000000001,
        71.955,
        17.14500000000001,
        145.735,
      )
      ..lineTo(17.14500000000001, 1646.26)
      ..cubicTo(
        17.14500000000001,
        1720.04,
        76.96000000000001,
        1779.86,
        150.745,
        1779.86,
      )
      ..lineTo(722.255, 1779.86)
      ..cubicTo(796.04, 1779.86, 855.855, 1720.04, 855.855, 1646.26)
      ..lineTo(855.855, 145.735)
      ..cubicTo(
        855.855,
        71.95500000000001,
        796.04,
        12.14500000000001,
        722.255,
        12.14500000000001,
      );
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
      ..moveTo(525.904, 56.675)
      ..lineTo(347.096, 56.675)
      ..cubicTo(
        326.601,
        56.675,
        309.985,
        73.289,
        309.985,
        93.78299999999999,
      )
      ..cubicTo(
        309.985,
        114.27799999999999,
        326.601,
        130.892,
        347.096,
        130.892,
      )
      ..lineTo(525.904, 130.892)
      ..cubicTo(
        546.4,
        130.892,
        563.015,
        114.27799999999999,
        563.015,
        93.78299999999999,
      )
      ..cubicTo(
        563.015,
        73.28899999999999,
        546.4,
        56.67499999999999,
        525.904,
        56.67499999999999,
      );
    canvas.drawPath(
      dynamicIslandPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF000000),
    );

    final cameraPath1 = Path()
      ..moveTo(525.904, 104.916)
      ..cubicTo(531.866, 104.916, 536.7, 100.082, 536.7, 94.121)
      ..cubicTo(
        536.7,
        88.16,
        531.8660000000001,
        83.32499999999999,
        525.904,
        83.32499999999999,
      )
      ..cubicTo(
        519.9419999999999,
        83.32499999999999,
        515.108,
        88.15899999999999,
        515.108,
        94.12099999999998,
      )
      ..cubicTo(
        515.108,
        100.08299999999997,
        519.9419999999999,
        104.91599999999998,
        525.904,
        104.91599999999998,
      );
    canvas.drawPath(
        cameraPath1,
        Paint()
          ..style = PaintingStyle.fill
          ..color = const Color(0xFF131423));

    final cameraPath2 = Path()
      ..moveTo(534.676, 94.12)
      ..arcToPoint(
        const Offset(525.904, 85.35000000000001),
        radius: const Radius.elliptical(8.77, 8.77),
      )
      ..arcToPoint(
        const Offset(534.676, 94.12),
        radius: const Radius.elliptical(8.772, 8.772),
        largeArc: true,
        clockwise: false,
      );
    canvas.drawPath(
      cameraPath2,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF07144C),
    );

    final cameraPath3 = Path()
      ..moveTo(518.504, 93.625)
      ..cubicTo(518.647, 89.785, 522.015, 87.036, 525.8580000000001, 87.036)
      ..cubicTo(
        529.7410000000001,
        87.036,
        533.152,
        89.839,
        533.3040000000001,
        93.72,
      )
      ..quadraticBezierTo(
        533.3260000000001,
        94.27,
        533.3260000000001,
        94.795,
      )
      ..quadraticBezierTo(
        533.3260000000001,
        95.321,
        533.3040000000001,
        95.87,
      )
      ..cubicTo(
        533.152,
        99.751,
        529.7410000000001,
        102.554,
        525.8580000000001,
        102.554,
      )
      ..cubicTo(
        522.0150000000001,
        102.554,
        518.647,
        99.804,
        518.504,
        95.965,
      )
      ..arcToPoint(
        const Offset(518.504, 93.625),
        radius: const Radius.elliptical(33, 33),
      );
    canvas.drawPath(
      cameraPath3,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0x66030303),
    );

    final cameraPath4 = Path()
      ..moveTo(525.904, 101.205)
      ..cubicTo(527.767, 101.205, 529.278, 99.845, 529.278, 98.169)
      ..cubicTo(
        529.278,
        96.49199999999999,
        527.767,
        95.13199999999999,
        525.904,
        95.13199999999999,
      )
      ..cubicTo(
        524.0409999999999,
        95.13199999999999,
        522.53,
        96.49199999999999,
        522.53,
        98.169,
      )
      ..cubicTo(
        522.53,
        99.846,
        524.0409999999999,
        101.205,
        525.904,
        101.205,
      );
    canvas.drawPath(
      cameraPath4,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.5000000, size.height * 0.03162667),
          Offset(size.width * 0.5000000, size.height * 0.07304241),
          const [Color(0x451D869C), Color(0x4C2371C6), Color(0x4C040AAD)],
          const [0, 0.371, 1],
        ),
    );

    final cameraPath5 = Path()
      ..moveTo(525.904, 101.205)
      ..arcToPoint(
        const Offset(525.904, 97.157),
        radius: const Radius.elliptical(2.024, 2.024),
        largeArc: true,
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(525.904, 101.205),
        radius: const Radius.elliptical(2.024, 2.024),
        clockwise: false,
      );
    canvas.drawPath(
      cameraPath5,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.5000000, size.height * 0.03507757),
          Offset(size.width * 0.5000000, size.height * 0.07304241),
          const [Color(0x59005267), Color(0x59415967), Color(0x598700C7)],
          const [0, 0.486, 1],
        ),
    );

    final cameraPath6 = Path()
      ..moveTo(525.904, 99.518)
      ..arcToPoint(
        const Offset(525.904, 88.72200000000001),
        radius: const Radius.elliptical(5.398, 5.398),
        largeArc: true,
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(525.904, 99.518),
        radius: const Radius.elliptical(5.398, 5.398),
        clockwise: false,
      );
    canvas.drawPath(
      cameraPath6,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.6024101, size.height * 0.04932199),
          Offset(size.width * 0.6024101, size.height * 0.05214621),
          const [Color(0xFF5978DD), Color(0x9C312FAD), Color(0x001C1C86)],
          const [0, 0.379, 1],
        ),
    );

    final speakerPath = Path()
      ..moveTo(523.311, 13)
      ..cubicTo(522.864, 13.3, 522.457, 13.661, 522.104, 14.08)
      ..lineTo(521.889, 14.35)
      ..lineTo(520.677, 15.972999999999999)
      ..arcToPoint(
        const Offset(517.8340000000001, 17.398),
        radius: const Radius.elliptical(3.55, 3.55),
      )
      ..lineTo(355.167, 17.398)
      ..arcToPoint(
        const Offset(352.45399999999995, 16.137),
        radius: const Radius.elliptical(3.55, 3.55),
      )
      ..lineTo(352.32399999999996, 15.973)
      ..lineTo(351.11199999999997, 14.351)
      ..arcToPoint(
        const Offset(349.69, 13),
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

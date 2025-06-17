part of 'device.dart';

// Generated with https://fluttershapemaker.com and manually adjusted.
class _FramePainter extends CustomPainter {
  const _FramePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final buttonsPath = Path()
      ..moveTo(1120, 100)
      ..cubicTo(1120.83, 100, 1121.5, 100.672, 1121.5, 101.5)
      ..lineTo(1121.5, 148.5)
      ..arcToPoint(
        const Offset(1120, 150),
        radius: const Radius.elliptical(1.5, 1.5),
      )
      ..lineTo(1116.5, 150)
      ..lineTo(1116.5, 100)
      ..close()
      ..moveTo(1120, 161)
      ..cubicTo(1120.83, 161, 1121.5, 161.672, 1121.5, 162.5)
      ..lineTo(1121.5, 209.5)
      ..arcToPoint(
        const Offset(1120, 211),
        radius: const Radius.elliptical(1.5, 1.5),
      )
      ..lineTo(1116.5, 211)
      ..lineTo(1116.5, 161)
      ..close()
      ..moveTo(987.5, 1.5)
      ..arcToPoint(
        const Offset(989, 0),
        radius: const Radius.elliptical(1.5, 1.5),
      )
      ..lineTo(1046, 0)
      ..cubicTo(1046.83, 0, 1047.5, 0.672, 1047.5, 1.5)
      ..lineTo(1047.5, 5)
      ..lineTo(987.5, 5)
      ..close();
    canvas.drawPath(
      buttonsPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF3B393B),
    );

    final buttonsShadowPath = Path()
      ..moveTo(1116.5, 100)
      ..lineTo(1116.5, 150)
      ..close()
      ..moveTo(1116.5, 161)
      ..lineTo(1116.5, 211)
      ..close()
      ..moveTo(987.5, 5)
      ..lineTo(1047.5, 5)
      ..close();
    canvas.drawPath(
      buttonsShadowPath,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width * 0.009
        ..maskFilter = MaskFilter.blur(
          BlurStyle.inner,
          size.width * 0.03,
        ),
    );

    final backgroundPath = Path()
      ..moveTo(0, 100.5)
      ..cubicTo(0, 74.44200000000001, 0, 61.413, 3.426, 50.869)
      ..arcToPoint(
        const Offset(48.369, 5.926),
        radius: const Radius.elliptical(70, 70),
      )
      ..cubicTo(58.913, 2.5, 71.942, 2.5, 98, 2.5)
      ..lineTo(1021, 2.5)
      ..cubicTo(1047.06, 2.5, 1060.09, 2.5, 1070.63, 5.926)
      ..arcToPoint(
        const Offset(1115.5700000000002, 50.869),
        radius: const Radius.elliptical(69.99, 69.99),
      )
      ..cubicTo(1119, 61.413, 1119, 74.442, 1119, 100.5)
      ..lineTo(1119, 1367.5)
      ..cubicTo(1119, 1393.56, 1119, 1406.59, 1115.57, 1417.13)
      ..arcToPoint(
        const Offset(1070.6299999999999, 1462.0700000000002),
        radius: const Radius.elliptical(69.98, 69.98),
      )
      ..cubicTo(
        1060.09,
        1465.5000000000002,
        1047.06,
        1465.5000000000002,
        1020.9999999999999,
        1465.5000000000002,
      )
      ..lineTo(98, 1465.5000000000002)
      ..cubicTo(
        71.94200000000001,
        1465.5000000000002,
        58.913,
        1465.5000000000002,
        48.369,
        1462.0700000000002,
      )
      ..arcToPoint(
        const Offset(3.426000000000002, 1417.13),
        radius: const Radius.elliptical(69.99, 69.99),
      )
      ..cubicTo(0, 1406.59, 0, 1393.56, 0, 1367.5)
      ..close();
    canvas.drawPath(
      backgroundPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF3B393B),
    );

    final antennasPath = Path()
      ..moveTo(0.5, 67)
      ..lineTo(8.5, 67)
      ..lineTo(8.5, 77)
      ..lineTo(0, 77)
      ..close()
      ..moveTo(1109.5, 67)
      ..lineTo(1118.4, 67)
      ..lineTo(1118.8400000000001, 77)
      ..lineTo(1109.5000000000002, 77)
      ..close();
    canvas.drawPath(
      antennasPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0x40000000),
    );

    final bezelPath = Path()
      ..moveTo(5.5, 113.6)
      ..cubicTo(
        5.5,
        76.637,
        5.5,
        58.154999999999994,
        12.693999999999999,
        44.03699999999999,
      )
      ..arcToPoint(
        const Offset(41.537, 15.193999999999992),
        radius: const Radius.elliptical(66, 66),
      )
      ..cubicTo(55.655, 8, 74.137, 8, 111.1, 8)
      ..lineTo(1007.9, 8)
      ..cubicTo(1044.86, 8, 1063.35, 8, 1077.46, 15.193999999999999)
      ..arcToPoint(
        const Offset(1106.31, 44.037),
        radius: const Radius.elliptical(66.02, 66.02),
      )
      ..cubicTo(1113.5, 58.155, 1113.5, 76.637, 1113.5, 113.6)
      ..lineTo(1113.5, 1354.3999999999999)
      ..cubicTo(
        1113.5,
        1391.36,
        1113.5,
        1409.85,
        1106.31,
        1423.9599999999998,
      )
      ..arcToPoint(
        const Offset(1077.46, 1452.8099999999997),
        radius: const Radius.elliptical(66.04, 66.04),
      )
      ..cubicTo(
        1063.3500000000001,
        1459.9999999999998,
        1044.8600000000001,
        1459.9999999999998,
        1007.9000000000001,
        1459.9999999999998,
      )
      ..lineTo(111.1, 1459.9999999999998)
      ..cubicTo(
        74.137,
        1459.9999999999998,
        55.654999999999994,
        1459.9999999999998,
        41.53699999999999,
        1452.8099999999997,
      )
      ..arcToPoint(
        const Offset(12.693999999999992, 1423.9599999999998),
        radius: const Radius.elliptical(66.02, 66.02),
      )
      ..cubicTo(5.5, 1409.85, 5.5, 1391.36, 5.5, 1354.4)
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
          ..strokeWidth = size.width * 0.00075
          ..maskFilter = MaskFilter.blur(
            BlurStyle.normal,
            size.width * 0.0015,
          ),
      );

    final cameraPath1 = Path()
      ..moveTo(1089.5, 690.003)
      ..arcToPoint(
        const Offset(1094.5, 695.0060000000001),
        radius: const Radius.elliptical(5, 5),
        clockwise: false,
      )
      ..cubicTo(
        1097.27,
        695.0060000000001,
        1099.51,
        692.7660000000001,
        1099.51,
        690.003,
      )
      ..arcToPoint(
        const Offset(1094.5, 685),
        radius: const Radius.elliptical(5.005, 5.005),
        clockwise: false,
      )
      ..cubicTo(1091.74, 685, 1089.5, 687.24, 1089.5, 690.003);
    canvas.drawPath(
      cameraPath1,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF131423),
    );

    final cameraPath2 = Path()
      ..moveTo(1094.5, 694.068)
      ..arcToPoint(
        const Offset(1094.508, 685.936),
        radius: const Radius.elliptical(4.066, 4.066),
        largeArc: true,
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(1094.5, 694.068),
        radius: const Radius.elliptical(4.066, 4.066),
        clockwise: false,
      );
    canvas.drawPath(
      cameraPath2,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF07144C),
    );

    final cameraPath3 = Path()
      ..moveTo(1094.73, 686.574)
      ..cubicTo(
        1096.51,
        686.64,
        1097.79,
        688.2009999999999,
        1097.79,
        689.981,
      )
      ..cubicTo(1097.79, 691.781, 1096.49, 693.362, 1094.69, 693.432)
      ..arcToPoint(
        const Offset(1093.69, 693.432),
        radius: const Radius.elliptical(12, 12),
      )
      ..cubicTo(
        1091.89,
        693.362,
        1090.5900000000001,
        691.7810000000001,
        1090.5900000000001,
        689.981,
      )
      ..cubicTo(
        1090.5900000000001,
        688.201,
        1091.8700000000001,
        686.64,
        1093.65,
        686.574,
      )
      ..arcToPoint(
        const Offset(1094.73, 686.574),
        radius: const Radius.elliptical(14, 14),
      );
    canvas.drawPath(
      cameraPath3,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0x66030303),
    );

    final cameraPath4 = Path()
      ..moveTo(1091.22, 690.003)
      ..cubicTo(
        1091.22,
        690.8660000000001,
        1091.8500000000001,
        691.566,
        1092.63,
        691.566,
      )
      ..cubicTo(
        1093.4,
        691.566,
        1094.0300000000002,
        690.866,
        1094.0300000000002,
        690.003,
      )
      ..cubicTo(
        1094.0300000000002,
        689.139,
        1093.4,
        688.4390000000001,
        1092.63,
        688.4390000000001,
      )
      ..cubicTo(
        1091.8500000000001,
        688.4390000000001,
        1091.22,
        689.1390000000001,
        1091.22,
        690.003,
      );
    canvas.drawPath(
      cameraPath4,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.9799554, size.height * 0.4706705),
          Offset(size.width * 0.9710339, size.height * 0.4706705),
          const [Color(0x451D869C), Color(0x4C2371C6), Color(0x4C040AAD)],
          const [0, 0.371, 1],
        ),
    );

    final cameraPath5 = Path()
      ..moveTo(1091.22, 690.003)
      ..cubicTo(
        1091.22,
        690.5210000000001,
        1091.64,
        690.941,
        1092.16,
        690.941,
      )
      ..arcToPoint(
        const Offset(1092.16, 689.065),
        radius: const Radius.elliptical(0.938, 0.938),
        largeArc: true,
        clockwise: false,
      )
      ..cubicTo(1091.64, 689.065, 1091.22, 689.485, 1091.22, 690.003);
    canvas.drawPath(
      cameraPath5,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.9792068, size.height * 0.4706705),
          Offset(size.width * 0.9710339, size.height * 0.4706705),
          const [Color(0x59005267), Color(0x59415967), Color(0x598700C7)],
          const [0, 0.486, 1],
        ),
    );

    final cameraPath6 = Path()
      ..moveTo(1092, 690.003)
      ..arcToPoint(
        const Offset(1097.002, 690.003),
        radius: const Radius.elliptical(2.501, 2.501),
        largeArc: true,
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(1092, 690.003),
        radius: const Radius.elliptical(2.501, 2.501),
        clockwise: false,
      );
    canvas.drawPath(
      cameraPath6,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.9778610, size.height * 0.4706705),
          Offset(size.width * 0.9757754, size.height * 0.4706705),
          const [Color(0xFF5978DD), Color(0x9C312FAD), Color(0x001C1C86)],
          const [0, 0.379, 1],
        ),
    );

    canvas.drawCircle(
      Offset(size.width * 0.9754902, size.height * 0.5324379),
      size.width * 0.001783422,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xB3272727),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

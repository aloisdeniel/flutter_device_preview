part of 'device.dart';

// Generated with https://fluttershapemaker.com and manually adjusted.
class _FramePainter extends CustomPainter {
  const _FramePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final buttonsPath = Path()
      ..moveTo(1313, 806.925)
      ..cubicTo(1313, 805.309, 1311.16, 804, 1308.88, 804)
      ..lineTo(1302, 804)
      ..lineTo(1302, 1116)
      ..lineTo(1308.88, 1116)
      ..cubicTo(1311.16, 1116, 1313, 1114.69, 1313, 1113.08)
      ..close()
      ..moveTo(0, 738.875)
      ..cubicTo(0, 737.839, 1.843, 737, 4.125, 737)
      ..lineTo(11, 737)
      ..lineTo(11, 937)
      ..lineTo(4.125, 937)
      ..cubicTo(1.843, 937, 0, 936.161, 0, 935.125)
      ..close()
      ..moveTo(0, 985.875)
      ..cubicTo(0, 984.839, 1.843, 984, 4.125, 984)
      ..lineTo(11, 984)
      ..lineTo(11, 1184)
      ..lineTo(4.125, 1184)
      ..cubicTo(1.843, 1184, 0, 1183.16, 0, 1182.12)
      ..close()
      ..moveTo(0, 530.172)
      ..cubicTo(0, 529.525, 1.843, 529, 4.125, 529)
      ..lineTo(11, 529)
      ..lineTo(11, 654)
      ..lineTo(4.125, 654)
      ..cubicTo(1.843, 654, 0, 653.475, 0, 652.828)
      ..close();
    canvas.drawPath(
      buttonsPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFFC0CDD6),
    );

    final buttonsShadowPath = Path()
      ..moveTo(1302, 804)
      ..lineTo(1302, 1116)
      ..close()
      ..moveTo(11, 737)
      ..lineTo(11, 937)
      ..close()
      ..moveTo(11, 984)
      ..lineTo(11, 1184)
      ..close()
      ..moveTo(11, 529)
      ..lineTo(11, 654)
      ..close();
    canvas.drawPath(
      buttonsShadowPath,
      Paint()
        ..color = const Color(0xFF000000)
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width * 0.0105
        ..maskFilter = MaskFilter.blur(
          BlurStyle.inner,
          size.width * 0.04,
        ),
    );

    final backgroundPath = Path()
      ..moveTo(9, 340.8)
      ..cubicTo(9, 221.50900000000001, 9, 161.863, 32.216, 116.30000000000001)
      ..arcToPoint(Offset(125.3, 23.216),
          radius: Radius.elliptical(213, 213),
          rotation: 0,
          largeArc: false,
          clockwise: true)
      ..cubicTo(170.863, 0, 230.509, 0, 349.8, 0)
      ..lineTo(963.2, 0)
      ..cubicTo(1082.49, 0, 1142.14, 0, 1187.7, 23.216)
      ..arcToPoint(Offset(1280.78, 116.30000000000001),
          radius: Radius.elliptical(212.98, 212.98),
          rotation: 0,
          largeArc: false,
          clockwise: true)
      ..cubicTo(1304, 161.863, 1304, 221.509, 1304, 340.8)
      ..lineTo(1304, 2371.2000000000003)
      ..cubicTo(1304, 2490.4900000000002, 1304, 2550.1400000000003, 1280.78,
          2595.7000000000003)
      ..cubicTo(1260.36, 2635.78, 1227.78, 2668.36, 1187.7, 2688.78)
      ..cubicTo(1142.14, 2712, 1082.49, 2712, 963.2, 2712)
      ..lineTo(349.8, 2712)
      ..cubicTo(
          230.50900000000001, 2712, 170.863, 2712, 125.30000000000001, 2688.78)
      ..arcToPoint(Offset(32.21600000000001, 2595.7000000000003),
          radius: Radius.elliptical(212.98, 212.98),
          rotation: 0,
          largeArc: false,
          clockwise: true)
      ..cubicTo(9, 2550.14, 9, 2490.49, 9, 2371.2)
      ..close();
    canvas.drawPath(
      backgroundPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFFB9C5CD),
      // ..color = const Color(0xFF5F6E78),
      // ..color = const Color(0xFFC0CDD6),
    );

    final antennasPath = Path()
      ..moveTo(1304, 2438)
      ..lineTo(1282, 2438)
      ..lineTo(1282, 2418)
      ..lineTo(1304, 2418)
      ..close()
      ..moveTo(31, 2438)
      ..lineTo(9, 2438)
      ..lineTo(9, 2418)
      ..lineTo(31, 2418)
      ..close()
      ..moveTo(1304, 294)
      ..lineTo(1282, 294)
      ..lineTo(1282, 274)
      ..lineTo(1304, 274)
      ..close()
      ..moveTo(31, 294)
      ..lineTo(9, 294)
      ..lineTo(9, 274)
      ..lineTo(31, 274)
      ..close();
    canvas.drawPath(
      antennasPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0x20000000),
    );

    final bezelPath = Path()
      ..moveTo(29, 346.4)
      ..cubicTo(29, 232.14899999999997, 29, 175.02399999999997, 51.235,
          131.38599999999997)
      ..arcToPoint(Offset(140.386, 42.23499999999997),
          radius: Radius.elliptical(204, 204),
          rotation: 0,
          largeArc: false,
          clockwise: true)
      ..cubicTo(184.024, 20, 241.149, 20, 355.4, 20)
      ..lineTo(957.6, 20)
      ..cubicTo(1071.85, 20, 1128.98, 20, 1172.6100000000001, 42.235)
      ..arcToPoint(Offset(1261.7700000000002, 131.386),
          radius: Radius.elliptical(204, 204),
          rotation: 0,
          largeArc: false,
          clockwise: true)
      ..cubicTo(1284, 175.024, 1284, 232.149, 1284, 346.4)
      ..lineTo(1284, 2365.6)
      ..cubicTo(1284, 2479.85, 1284, 2536.98, 1261.77, 2580.6099999999997)
      ..arcToPoint(Offset(1172.61, 2669.7699999999995),
          radius: Radius.elliptical(204, 204),
          rotation: 0,
          largeArc: false,
          clockwise: true)
      ..cubicTo(1128.98, 2692, 1071.85, 2692, 957.6, 2692)
      ..lineTo(355.4, 2692)
      ..cubicTo(241.14899999999997, 2692, 184.02399999999997, 2692,
          140.38599999999997, 2669.77)
      ..arcToPoint(Offset(51.23499999999997, 2580.61),
          radius: Radius.elliptical(204, 204),
          rotation: 0,
          largeArc: false,
          clockwise: true)
      ..cubicTo(29, 2536.98, 29, 2479.85, 29, 2365.6)
      ..close();
    canvas
      ..drawPath(
        bezelPath,
        Paint()
          ..color = const Color(0xFFC0CDD6)
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.005
          ..maskFilter = MaskFilter.blur(
            BlurStyle.normal,
            size.width * 0.003,
          ),
      )
      ..drawPath(
        bezelPath,
        Paint()
          ..style = PaintingStyle.fill
          ..color = const Color(0xFF000000),
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
      );

    final dynamicIslandPath = Path()
      ..moveTo(529.093, 99)
      ..lineTo(784.9069999999999, 99)
      ..cubicTo(814.229, 99, 838, 122.953, 838, 152.5)
      ..cubicTo(838, 182.047, 814.229, 206, 784.907, 206)
      ..lineTo(529.093, 206)
      ..cubicTo(499.771, 206, 476, 182.047, 476, 152.5)
      ..cubicTo(476, 122.953, 499.771, 99, 529.093, 99)
      ..close();
    canvas.drawPath(
      dynamicIslandPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF000000),
    );

    final cameraPath1 = Path()
      ..moveTo(529.093, 168.55)
      ..cubicTo(520.563, 168.55, 513.6479999999999, 161.58200000000002,
          513.6479999999999, 152.98600000000002)
      ..cubicTo(513.6479999999999, 144.39000000000001, 520.5629999999999,
          137.42300000000003, 529.093, 137.42300000000003)
      ..cubicTo(537.623, 137.42300000000003, 544.539, 144.39100000000002,
          544.539, 152.98600000000002)
      ..cubicTo(544.539, 161.58100000000002, 537.624, 168.55, 529.093, 168.55);
    canvas.drawPath(
      cameraPath1,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF131423),
    );

    final cameraPath2 = Path()
      ..moveTo(516.544, 152.986)
      ..cubicTo(516.544, 146.00199999999998, 522.163, 140.34099999999998,
          529.093, 140.34099999999998)
      ..cubicTo(536.024, 140.34099999999998, 541.6429999999999,
          146.00199999999998, 541.6429999999999, 152.986)
      ..cubicTo(541.6429999999999, 159.97, 536.0239999999999, 165.632, 529.093,
          165.632)
      ..cubicTo(522.163, 165.632, 516.544, 159.97, 516.544, 152.986);
    canvas.drawPath(
      cameraPath2,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF07144C),
    );

    final cameraPath3 = Path()
      ..moveTo(539.68, 152.273)
      ..cubicTo(539.4749999999999, 146.737, 534.6569999999999, 142.773, 529.16,
          142.773)
      ..cubicTo(523.603, 142.773, 518.7239999999999, 146.814, 518.506, 152.409)
      ..cubicTo(518.486, 152.935, 518.475, 153.45499999999998, 518.475, 153.959)
      ..cubicTo(518.475, 154.46300000000002, 518.486, 154.983, 518.506,
          155.50900000000001)
      ..cubicTo(518.7239999999999, 161.104, 523.603, 165.145, 529.16, 165.145)
      ..cubicTo(534.6569999999999, 165.145, 539.475, 161.18200000000002, 539.68,
          155.64600000000002)
      ..quadraticBezierTo(539.7109999999999, 154.8, 539.712, 153.959)
      ..cubicTo(539.713, 153.118, 539.7, 152.835, 539.68, 152.273);
    canvas.drawPath(
      cameraPath3,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0x66030303),
    );

    final cameraPath4 = Path()
      ..moveTo(529.093, 163.2)
      ..cubicTo(526.428, 163.2, 524.2669999999999, 161.23999999999998,
          524.2669999999999, 158.82299999999998)
      ..cubicTo(524.2669999999999, 156.40499999999997, 526.4279999999999,
          154.445, 529.093, 154.445)
      ..cubicTo(531.759, 154.445, 533.92, 156.405, 533.92, 158.82299999999998)
      ..cubicTo(533.92, 161.23999999999998, 531.759, 163.2, 529.093, 163.2);
    canvas.drawPath(
      cameraPath4,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.5003808, size.height * 0.03650442),
          Offset(size.width * 0.5003808, size.height * 0.07595870),
          const [Color(0x451D869C), Color(0x4C2371C6), Color(0x4C040AAD)],
          const [0, 0.371, 1],
        ),
    );

    final cameraPath5 = Path()
      ..moveTo(529.093, 163.2)
      ..cubicTo(527.4939999999999, 163.2, 526.197, 161.893, 526.197,
          160.28199999999998)
      ..cubicTo(526.197, 158.67099999999996, 527.494, 157.36399999999998,
          529.093, 157.36399999999998)
      ..cubicTo(530.693, 157.36399999999998, 531.9889999999999, 158.67,
          531.9889999999999, 160.28199999999998)
      ..cubicTo(531.9889999999999, 161.89299999999997, 530.6929999999999, 163.2,
          529.093, 163.2);
    canvas.drawPath(
      cameraPath5,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.5003808, size.height * 0.03979240),
          Offset(size.width * 0.5003808, size.height * 0.07595870),
          const [Color(0x59005267), Color(0x59415967), Color(0x598700C7)],
          const [0, 0.486, 1],
        ),
    );

    final cameraPath6 = Path()
      ..moveTo(529.093, 160.768)
      ..cubicTo(524.828, 160.768, 521.371, 157.284, 521.371, 152.986)
      ..cubicTo(521.371, 148.689, 524.828, 145.20499999999998, 529.093,
          145.20499999999998)
      ..cubicTo(533.358, 145.20499999999998, 536.8159999999999, 148.689,
          536.8159999999999, 152.986)
      ..cubicTo(536.8159999999999, 157.284, 533.358, 160.768, 529.093, 160.768);
    canvas.drawPath(
      cameraPath6,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.4029650, size.height * 0.05336209),
          Offset(size.width * 0.4029650, size.height * 0.05605236),
          const [Color(0xFF5978DD), Color(0x9C312FAD), Color(0x001C1C86)],
          const [0, 0.379, 1],
        ),
    );

    final speakerPath = Path()
      ..moveTo(785.867, 23.5)
      ..arcToPoint(Offset(783.4019999999999, 25.468),
          radius: Radius.elliptical(8, 8),
          rotation: 0,
          largeArc: false,
          clockwise: false)
      ..lineTo(781.646, 27.572)
      ..cubicTo(780.64, 28.776, 779.043, 29.5, 777.3299999999999, 29.5)
      ..lineTo(541.67, 29.5)
      ..cubicTo(539.9559999999999, 29.5, 538.3589999999999, 28.776,
          537.3539999999999, 27.572)
      ..lineTo(535.5989999999999, 25.468)
      ..arcToPoint(Offset(533.1339999999999, 23.5),
          radius: Radius.elliptical(8, 8),
          rotation: 0,
          largeArc: false,
          clockwise: false)
      ..close();
    canvas
      ..drawPath(
        speakerPath,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.005
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

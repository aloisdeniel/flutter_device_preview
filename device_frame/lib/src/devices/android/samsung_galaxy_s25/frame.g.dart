part of 'device.dart';

// Generated with https://fluttershapemaker.com and manually adjusted.
class _FramePainter extends CustomPainter {
  const _FramePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final buttonsPath = Path()
      ..moveTo(864, 328)
      ..lineTo(870, 328)
      ..arcToPoint(
        const Offset(872, 330),
        radius: const Radius.elliptical(2, 2),
      )
      ..lineTo(872, 572)
      ..arcToPoint(
        const Offset(870, 574),
        radius: const Radius.elliptical(2, 2),
      )
      ..lineTo(864, 574)
      ..close()
      ..moveTo(864, 690)
      ..lineTo(870, 690)
      ..arcToPoint(
        const Offset(872, 692),
        radius: const Radius.elliptical(2, 2),
      )
      ..lineTo(872, 825)
      ..arcToPoint(
        const Offset(870, 827),
        radius: const Radius.elliptical(2, 2),
      )
      ..lineTo(864, 827)
      ..close();
    canvas.drawPath(
      buttonsPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF4F5359),
    );

    final buttonsShadowPath = Path()
      ..moveTo(864, 328)
      ..lineTo(864, 574)
      ..close()
      ..moveTo(864, 690)
      ..lineTo(864, 827)
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

    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, size.width * 0.9931193, size.height),
        bottomRight: Radius.circular(size.width * 0.1192661),
        bottomLeft: Radius.circular(size.width * 0.1192661),
        topLeft: Radius.circular(size.width * 0.1192661),
        topRight: Radius.circular(size.width * 0.1192661),
      ),
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF4F5359),
    );

    final bezelPath = Path()
      ..moveTo(11, 158.25)
      ..cubicTo(11, 109.521, 11, 85.156, 19.726, 66.227)
      ..arcToPoint(
        const Offset(66.227, 19.727000000000004),
        radius: const Radius.elliptical(95, 95),
      )
      ..cubicTo(85.157, 11, 109.521, 11, 158.25, 11)
      ..lineTo(707.75, 11)
      ..cubicTo(756.479, 11, 780.844, 11, 799.773, 19.726)
      ..arcToPoint(
        const Offset(846.274, 66.227),
        radius: const Radius.elliptical(95, 95),
      )
      ..cubicTo(855, 85.157, 855, 109.521, 855, 158.25)
      ..lineTo(855, 1646.75)
      ..cubicTo(855, 1695.48, 855, 1719.84, 846.274, 1738.77)
      ..arcToPoint(
        const Offset(799.773, 1785.27),
        radius: const Radius.elliptical(95, 95),
      )
      ..cubicTo(780.844, 1794, 756.479, 1794, 707.75, 1794)
      ..lineTo(158.25, 1794)
      ..cubicTo(109.521, 1794, 85.156, 1794, 66.227, 1785.27)
      ..arcToPoint(
        const Offset(19.727000000000004, 1738.77),
        radius: const Radius.elliptical(95, 95),
      )
      ..cubicTo(11, 1719.84, 11, 1695.48, 11, 1646.75)
      ..close();
    canvas
      ..drawPath(
        bezelPath,
        Paint()
          ..color = const Color(0x99FFFFFF)
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.004
          ..maskFilter = MaskFilter.blur(
            BlurStyle.normal,
            size.width * 0.004,
          ),
      )
      ..drawPath(
        bezelPath,
        Paint()
          ..color = const Color(0x55000000)
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
      );

    final antennasPath = Path()
      ..moveTo(313, 0)
      ..lineTo(326, 0)
      ..lineTo(326, 13)
      ..lineTo(313, 13)
      ..close()
      ..moveTo(115, 1792)
      ..lineTo(128, 1792)
      ..lineTo(128, 1805)
      ..lineTo(115, 1805)
      ..close()
      ..moveTo(737.5, 1792)
      ..lineTo(750.5, 1792)
      ..lineTo(750.5, 1805)
      ..lineTo(737.5, 1805)
      ..close()
      ..moveTo(0, 149)
      ..lineTo(13, 149)
      ..lineTo(13, 160)
      ..lineTo(0, 160)
      ..close()
      ..moveTo(853, 149)
      ..lineTo(866, 149)
      ..lineTo(866, 160)
      ..lineTo(853, 160)
      ..close()
      ..moveTo(0, 1645)
      ..lineTo(13, 1645)
      ..lineTo(13, 1657)
      ..lineTo(0, 1657)
      ..close();
    canvas.drawPath(
      antennasPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0x29000000),
    );

    final cameraPath1 = Path()
      ..moveTo(453, 71)
      ..cubicTo(453, 82.04599999999999, 444.046, 91, 433, 91)
      ..cubicTo(421.954, 91, 413, 82.04599999999999, 413, 71)
      ..cubicTo(413, 59.95400000000001, 421.954, 51, 433, 51)
      ..cubicTo(444.046, 51, 453, 59.954, 453, 71);
    canvas.drawPath(
      cameraPath1,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF000000),
    );

    final cameraPath2 = Path()
      ..moveTo(433, 84)
      ..cubicTo(440.18, 84, 446, 78.18, 446, 71)
      ..cubicTo(446, 63.81999999999999, 440.18, 58, 433, 58)
      ..cubicTo(425.82, 58, 420, 63.82, 420, 71)
      ..cubicTo(420, 78.18, 425.82, 84, 433, 84);
    canvas.drawPath(
      cameraPath2,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF131423),
    );

    final cameraPath3 = Path()
      ..moveTo(443.562, 71)
      ..cubicTo(443.562, 65.166, 438.834, 60.438, 433, 60.438)
      ..cubicTo(427.166, 60.438, 422.438, 65.165, 422.438, 71)
      ..cubicTo(422.438, 76.835, 427.166, 81.563, 433, 81.563)
      ..cubicTo(438.834, 81.563, 443.562, 76.833, 443.562, 71);
    canvas.drawPath(
      cameraPath3,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF07144C),
    );

    final cameraPath4 = Path()
      ..moveTo(424.09, 70.404)
      ..cubicTo(
        424.262,
        65.78,
        428.31699999999995,
        62.468999999999994,
        432.94399999999996,
        62.468999999999994,
      )
      ..cubicTo(
        437.621,
        62.468999999999994,
        441.72799999999995,
        65.844,
        441.91099999999994,
        70.518,
      )
      ..quadraticBezierTo(
        441.93699999999995,
        71.179,
        441.93799999999993,
        71.812,
      )
      ..cubicTo(
        441.93799999999993,
        72.233,
        441.92799999999994,
        72.66799999999999,
        441.91099999999994,
        73.107,
      )
      ..cubicTo(
        441.72799999999995,
        77.781,
        437.6209999999999,
        81.157,
        432.94399999999996,
        81.157,
      )
      ..cubicTo(
        428.31699999999995,
        81.157,
        424.26199999999994,
        77.845,
        424.09,
        73.221,
      )
      ..arcToPoint(
        const Offset(424.09, 70.404),
        radius: const Radius.elliptical(37, 37),
      );
    canvas.drawPath(
      cameraPath4,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0x66030303),
    );

    final cameraPath5 = Path()
      ..moveTo(433, 79.531)
      ..cubicTo(435.244, 79.531, 437.062, 77.894, 437.062, 75.875)
      ..cubicTo(437.062, 73.856, 435.244, 72.219, 433, 72.219)
      ..cubicTo(430.756, 72.219, 428.938, 73.856, 428.938, 75.875)
      ..cubicTo(428.938, 77.894, 430.756, 79.531, 433, 79.531);
    canvas.drawPath(
      cameraPath5,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.4965596, size.height * 0.02825485),
          Offset(size.width * 0.4965596, size.height * 0.05041551),
          const [Color(0x451D869C), Color(0x4C2371C6), Color(0x4C040AAD)],
          const [0, 0.371, 1],
        ),
    );

    final cameraPath6 = Path()
      ..moveTo(433, 79.531)
      ..arcToPoint(
        const Offset(433, 74.655),
        radius: const Radius.elliptical(2.438, 2.438),
        largeArc: true,
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(433, 79.531),
        radius: const Radius.elliptical(2.438, 2.438),
        clockwise: false,
      );
    canvas.drawPath(
      cameraPath6,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.4965596, size.height * 0.03010139),
          Offset(size.width * 0.4965596, size.height * 0.05041551),
          const [Color(0x59005267), Color(0x59415967), Color(0x598700C7)],
          const [0, 0.486, 1],
        ),
    );

    final cameraPath7 = Path()
      ..moveTo(433, 77.5)
      ..arcToPoint(
        const Offset(433, 64.5),
        radius: const Radius.elliptical(6.5, 6.5),
        largeArc: true,
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(433, 77.5),
        radius: const Radius.elliptical(6.5, 6.5),
        clockwise: false,
      );
    canvas.drawPath(
      cameraPath7,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.4965596, size.height * 0.03550914),
          Offset(size.width * 0.4965596, size.height * 0.03888532),
          const [Color(0xFF5978DD), Color(0x9C312FAD), Color(0x001C1C86)],
          const [0, 0.379, 1],
        ),
    );

    final speakerPath = Path()
      ..moveTo(593.451, 12)
      ..cubicTo(
        592.8050000000001,
        12.239,
        592.208,
        12.517,
        591.676,
        12.834,
      )
      ..lineTo(591.293, 13.076)
      ..lineTo(589.052, 14.579)
      ..cubicTo(587.7470000000001, 15.454, 585.633, 16, 583.335, 16)
      ..lineTo(282.665, 16)
      ..cubicTo(280.51000000000005, 16, 278.517, 15.52, 277.202, 14.74)
      ..lineTo(276.948, 14.58)
      ..lineTo(274.707, 13.076)
      ..arcToPoint(
        const Offset(272.55, 12),
        radius: const Radius.elliptical(10.3, 10.3),
        clockwise: false,
      )
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

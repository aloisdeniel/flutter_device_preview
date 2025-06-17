part of 'device.dart';

// Generated with https://fluttershapemaker.com and manually adjusted.
class _FramePainter extends CustomPainter {
  const _FramePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final buttonsPath = Path()
      ..moveTo(784, 455)
      ..lineTo(790, 455)
      ..arcToPoint(
        const Offset(792, 457),
        radius: const Radius.elliptical(2, 2),
      )
      ..lineTo(792, 585)
      ..arcToPoint(
        const Offset(790, 587),
        radius: const Radius.elliptical(2, 2),
      )
      ..lineTo(784, 587)
      ..close()
      ..moveTo(784, 663)
      ..lineTo(790, 663)
      ..arcToPoint(
        const Offset(792, 665),
        radius: const Radius.elliptical(2, 2),
      )
      ..lineTo(792, 901)
      ..arcToPoint(
        const Offset(790, 903),
        radius: const Radius.elliptical(2, 2),
      )
      ..lineTo(784, 903)
      ..close();
    canvas.drawPath(
      buttonsPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF272727),
    );

    final buttonsShadowPath = Path()
      ..moveTo(784, 455)
      ..lineTo(784, 587)
      ..close()
      ..moveTo(784, 663)
      ..lineTo(784, 903)
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
      ..moveTo(0, 175.44)
      ..cubicTo(0, 138.776, 0, 120.445, 3.512, 105.291)
      ..cubicTo(15.234, 54.721, 54.721, 15.234, 105.291, 3.512)
      ..cubicTo(120.445, 0, 138.776, 0, 175.44, 0)
      ..lineTo(610.56, 0)
      ..cubicTo(647.2239999999999, 0, 665.555, 0, 680.709, 3.512)
      ..cubicTo(
        731.279,
        15.234,
        770.766,
        54.721000000000004,
        782.4879999999999,
        105.291,
      )
      ..cubicTo(786, 120.445, 786, 138.776, 786, 175.44)
      ..lineTo(786, 1493.56)
      ..cubicTo(786, 1530.22, 786, 1548.56, 782.488, 1563.71)
      ..cubicTo(
        770.7660000000001,
        1614.28,
        731.279,
        1653.77,
        680.7090000000001,
        1665.49,
      )
      ..cubicTo(
        665.5550000000001,
        1669,
        647.224,
        1669,
        610.5600000000001,
        1669,
      )
      ..lineTo(175.44, 1669)
      ..cubicTo(138.776, 1669, 120.445, 1669, 105.291, 1665.49)
      ..cubicTo(
        54.721,
        1653.77,
        15.233999999999995,
        1614.28,
        3.5120000000000005,
        1563.71,
      )
      ..cubicTo(0, 1548.56, 0, 1530.22, 0, 1493.56)
      ..close();
    canvas.drawPath(
      backgroundPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF272727),
    );

    final bezelPath = Path()
      ..moveTo(16, 181.2)
      ..cubicTo(
        16,
        137.274,
        16,
        115.31099999999999,
        21.775,
        97.53599999999999,
      )
      ..arcToPoint(
        const Offset(97.536, 21.775999999999982),
        radius: const Radius.elliptical(118, 118),
      )
      ..cubicTo(115.311, 16, 137.274, 16, 181.2, 16)
      ..lineTo(604.8, 16)
      ..cubicTo(648.726, 16, 670.689, 16, 688.4639999999999, 21.775)
      ..arcToPoint(
        const Offset(764.2249999999999, 97.536),
        radius: const Radius.elliptical(118, 118),
      )
      ..cubicTo(770, 115.311, 770, 137.274, 770, 181.2)
      ..lineTo(770, 1487.8)
      ..cubicTo(770, 1531.73, 770, 1553.69, 764.225, 1571.46)
      ..arcToPoint(
        const Offset(688.464, 1647.22),
        radius: const Radius.elliptical(117.98, 117.98),
      )
      ..cubicTo(
        670.6890000000001,
        1653,
        648.7260000000001,
        1653,
        604.8000000000001,
        1653,
      )
      ..lineTo(181.2, 1653)
      ..cubicTo(
        137.274,
        1653,
        115.31099999999999,
        1653,
        97.53599999999999,
        1647.22,
      )
      ..arcToPoint(
        const Offset(21.775999999999982, 1571.46),
        radius: const Radius.elliptical(117.98, 117.98),
      )
      ..cubicTo(16, 1553.69, 16, 1531.73, 16, 1487.8)
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
      ..moveTo(385.5, 0)
      ..lineTo(400.5, 0)
      ..lineTo(400.5, 18)
      ..lineTo(385.5, 18)
      ..close()
      ..moveTo(0, 262)
      ..lineTo(18, 262)
      ..lineTo(18, 277)
      ..lineTo(0, 277)
      ..close()
      ..moveTo(768, 262)
      ..lineTo(786, 262)
      ..lineTo(786, 277)
      ..lineTo(768, 277)
      ..close()
      ..moveTo(768, 1485)
      ..lineTo(786, 1485)
      ..lineTo(786, 1500)
      ..lineTo(768, 1500)
      ..close()
      ..moveTo(0, 1485)
      ..lineTo(18, 1485)
      ..lineTo(18, 1500)
      ..lineTo(0, 1500)
      ..close()
      ..moveTo(479, 1651)
      ..lineTo(494, 1651)
      ..lineTo(494, 1669)
      ..lineTo(479, 1669)
      ..close();
    canvas.drawPath(
      antennasPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0x40000000),
    );

    final cameraPath1 = Path()
      ..moveTo(419, 95)
      ..cubicTo(419, 109.359, 407.359, 121, 393, 121)
      ..cubicTo(378.641, 121, 367, 109.359, 367, 95)
      ..cubicTo(367, 80.641, 378.641, 69, 393, 69)
      ..cubicTo(407.359, 69, 419, 80.64, 419, 95);
    canvas.drawPath(
      cameraPath1,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF000000),
    );

    final cameraPath2 = Path()
      ..moveTo(393, 105)
      ..cubicTo(398.523, 105, 403, 100.523, 403, 95)
      ..cubicTo(403, 89.477, 398.523, 85, 393, 85)
      ..cubicTo(387.477, 85, 383, 89.477, 383, 95)
      ..cubicTo(383, 100.523, 387.477, 105, 393, 105);
    canvas.drawPath(
      cameraPath2,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF131423),
    );

    final cameraPath3 = Path()
      ..moveTo(401.125, 95)
      ..arcToPoint(
        const Offset(384.875, 95),
        radius: const Radius.elliptical(8.125, 8.125),
        largeArc: true,
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(401.125, 95),
        radius: const Radius.elliptical(8.125, 8.125),
        clockwise: false,
      );
    canvas.drawPath(
      cameraPath3,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF07144C),
    );

    final cameraPath4 = Path()
      ..moveTo(386.146, 94.541)
      ..cubicTo(386.278, 90.984, 389.398, 88.438, 392.957, 88.438)
      ..cubicTo(396.555, 88.438, 399.714, 91.034, 399.854, 94.628)
      ..arcToPoint(
        const Offset(399.854, 96.621),
        radius: const Radius.elliptical(24, 24),
      )
      ..cubicTo(399.714, 100.216, 396.555, 102.812, 392.957, 102.812)
      ..cubicTo(
        389.39799999999997,
        102.812,
        386.278,
        100.26599999999999,
        386.146,
        96.709,
      )
      ..arcToPoint(
        const Offset(386.125, 95.625),
        radius: const Radius.elliptical(30, 30),
      )
      ..quadraticBezierTo(386.125, 95.085, 386.146, 94.541);
    canvas.drawPath(
      cameraPath4,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0x66030303),
    );

    final cameraPath5 = Path()
      ..moveTo(393, 101.562)
      ..cubicTo(394.726, 101.562, 396.125, 100.303, 396.125, 98.75)
      ..cubicTo(396.125, 97.197, 394.726, 95.938, 393, 95.938)
      ..cubicTo(391.274, 95.938, 389.875, 97.197, 389.875, 98.75)
      ..cubicTo(389.875, 100.303, 391.274, 101.562, 393, 101.562);
    canvas.drawPath(
      cameraPath5,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.4962121, size.height * 0.04134212),
          Offset(size.width * 0.4962121, size.height * 0.07249850),
          const [Color(0x451D869C), Color(0x4C2371C6), Color(0x4C040AAD)],
          const [0, 0.371, 1],
        ),
    );

    final cameraPath6 = Path()
      ..moveTo(393, 101.562)
      ..arcToPoint(
        const Offset(393.001, 97.813),
        radius: const Radius.elliptical(1.874, 1.874),
        largeArc: true,
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(393, 101.562),
        radius: const Radius.elliptical(1.874, 1.874),
        clockwise: false,
      );
    canvas.drawPath(
      cameraPath6,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.4962121, size.height * 0.04393829),
          Offset(size.width * 0.4962121, size.height * 0.07249850),
          const [Color(0x59005267), Color(0x59415967), Color(0x598700C7)],
          const [0, 0.486, 1],
        ),
    );

    final cameraPath7 = Path()
      ..moveTo(393, 100)
      ..arcToPoint(
        const Offset(393, 90),
        radius: const Radius.elliptical(5, 5),
        largeArc: true,
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(393, 100),
        radius: const Radius.elliptical(5, 5),
        clockwise: false,
      );
    canvas.drawPath(
      cameraPath7,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.4962121, size.height * 0.05373757),
          Offset(size.width * 0.4962121, size.height * 0.05654643),
          const [Color(0xFF5978DD), Color(0x9C312FAD), Color(0x001C1C86)],
          const [0, 0.379, 1],
        ),
    );

    final speakerPath = Path()
      ..moveTo(609.524, 17)
      ..cubicTo(608.43, 17.321, 607.43, 17.715, 606.562, 18.175)
      ..lineTo(606.054, 18.46)
      ..lineTo(603.031, 20.264)
      ..cubicTo(601.23, 21.339, 598.332, 22, 595.204, 22)
      ..lineTo(189.796, 22)
      ..cubicTo(186.862, 22, 184.13299999999998, 21.42, 182.319, 20.46)
      ..lineTo(181.969, 20.264)
      ..lineTo(178.947, 18.46)
      ..cubicTo(177.969, 17.876, 176.791, 17.386, 175.477, 17)
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

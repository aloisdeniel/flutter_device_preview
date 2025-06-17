part of 'device.dart';

// Generated with https://fluttershapemaker.com and manually adjusted.
class _FramePainter extends CustomPainter {
  const _FramePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final buttonsPath = Path()
      ..moveTo(0, 371.319)
      ..cubicTo(0, 370.055, 1.193, 369.031, 2.665, 369.031)
      ..lineTo(6.218, 369.031)
      ..lineTo(6.218, 452.146)
      ..lineTo(2.665, 452.146)
      ..cubicTo(1.193, 452.146, 0, 451.122, 0, 449.85900000000004)
      ..close()
      ..moveTo(0, 515.969)
      ..cubicTo(0, 514.873, 1.193, 513.984, 2.665, 513.984)
      ..lineTo(6.218, 513.984)
      ..lineTo(6.218, 648.299)
      ..lineTo(2.665, 648.299)
      ..cubicTo(1.193, 648.299, 0, 647.41, 0, 646.314)
      ..close()
      ..moveTo(0, 686.854)
      ..cubicTo(0, 685.758, 1.312, 684.869, 2.931, 684.869)
      ..lineTo(6.84, 684.869)
      ..lineTo(6.84, 819.183)
      ..lineTo(2.93, 819.183)
      ..cubicTo(
        1.3110000000000002,
        819.183,
        -0.0009999999999998899,
        818.295,
        -0.0009999999999998899,
        817.198,
      )
      ..close()
      ..moveTo(873, 562.523)
      ..cubicTo(873, 561.421, 871.886, 560.528, 870.507, 560.528)
      ..lineTo(866.351, 560.528)
      ..lineTo(866.351, 773.303)
      ..lineTo(870.507, 773.303)
      ..cubicTo(871.886, 773.303, 873, 772.41, 873, 771.308)
      ..close();
    canvas.drawPath(
      buttonsPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF4E4E4E),
    );

    final buttonsShadowPath = Path()
      ..moveTo(6.218, 369.031)
      ..lineTo(6.218, 452.146)
      ..close()
      ..moveTo(6.218, 513.984)
      ..lineTo(6.218, 648.299)
      ..close()
      ..moveTo(6.218, 684.869)
      ..lineTo(6.218, 819.183)
      ..close()
      ..moveTo(866.351, 560.528)
      ..lineTo(866.351, 773.303)
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
      ..moveTo(5.32, 237.244)
      ..cubicTo(5.32, 154.201, 5.32, 112.679, 21.48, 80.96100000000001)
      ..arcToPoint(
        const Offset(86.27600000000001, 16.161000000000016),
        radius: const Radius.elliptical(148.28, 148.28),
      )
      ..cubicTo(117.993, 0, 159.512, 0, 242.552, 0)
      ..lineTo(630.448, 0)
      ..cubicTo(713.486, 0, 755.009, 0, 786.7239999999999, 16.161)
      ..arcToPoint(
        const Offset(851.5169999999999, 80.961),
        radius: const Radius.elliptical(148.26, 148.26),
      )
      ..cubicTo(
        867.6809999999999,
        112.679,
        867.6809999999999,
        154.201,
        867.6809999999999,
        237.24399999999997,
      )
      ..lineTo(867.6809999999999, 1540.76)
      ..cubicTo(
        867.6809999999999,
        1623.8,
        867.6809999999999,
        1665.32,
        851.5169999999999,
        1697.04,
      )
      ..arcToPoint(
        const Offset(786.7239999999999, 1761.84),
        radius: const Radius.elliptical(148.3, 148.3),
      )
      ..cubicTo(755.009, 1778, 713.486, 1778, 630.448, 1778)
      ..lineTo(242.552, 1778)
      ..cubicTo(159.512, 1778, 117.993, 1778, 86.27599999999998, 1761.84)
      ..arcToPoint(
        const Offset(21.479999999999976, 1697.04),
        radius: const Radius.elliptical(148.3, 148.3),
      )
      ..cubicTo(
        5.319999999999975,
        1665.32,
        5.319999999999975,
        1623.8,
        5.319999999999975,
        1540.76,
      )
      ..close();
    canvas.drawPath(
      backgroundPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF4E4E4E),
    );

    final antennasPath = Path()
      ..moveTo(688.161, 0)
      ..lineTo(688.161, 13.298)
      ..lineTo(674.8629999999999, 13.298)
      ..lineTo(674.8629999999999, 0)
      ..close()
      ..moveTo(18.617, 198.812)
      ..lineTo(5.319, 198.812)
      ..lineTo(5.319, 186.178)
      ..lineTo(18.617, 186.178)
      ..close()
      ..moveTo(867.6809999999999, 199.477)
      ..lineTo(854.3829999999999, 199.477)
      ..lineTo(854.3829999999999, 186.84300000000002)
      ..lineTo(867.6809999999999, 186.84300000000002)
      ..close()
      ..moveTo(18.617, 1591.82)
      ..lineTo(5.319, 1591.82)
      ..lineTo(5.319, 1579.1899999999998)
      ..lineTo(18.617, 1579.1899999999998)
      ..close()
      ..moveTo(867.6809999999999, 1591.82)
      ..lineTo(854.3829999999999, 1591.82)
      ..lineTo(854.3829999999999, 1579.1899999999998)
      ..lineTo(867.6809999999999, 1579.1899999999998)
      ..close()
      ..moveTo(198.137, 1764.7)
      ..lineTo(198.137, 1778)
      ..lineTo(185.504, 1778)
      ..lineTo(185.504, 1764.7)
      ..close();
    canvas.drawPath(
      antennasPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0x40000000),
    );

    final bezelPath = Path()
      ..moveTo(17.287, 230.063)
      ..cubicTo(
        17.287,
        153.72299999999998,
        17.287,
        115.55299999999998,
        32.143,
        86.39499999999998,
      )
      ..arcToPoint(
        const Offset(91.71000000000001, 26.82499999999998),
        radius: const Radius.elliptical(136.3, 136.3),
      )
      ..cubicTo(120.866, 11.97, 159.034, 11.97, 235.37, 11.97)
      ..lineTo(637.6279999999999, 11.97)
      ..cubicTo(
        713.9639999999999,
        11.97,
        752.135,
        11.97,
        781.2909999999999,
        26.826999999999998,
      )
      ..arcToPoint(
        const Offset(840.858, 86.396),
        radius: const Radius.elliptical(136.33, 136.33),
      )
      ..cubicTo(
        855.712,
        115.554,
        855.712,
        153.724,
        855.712,
        230.06400000000002,
      )
      ..lineTo(855.712, 1547.94)
      ..cubicTo(
        855.712,
        1624.28,
        855.712,
        1662.45,
        840.858,
        1691.6100000000001,
      )
      ..arcToPoint(
        const Offset(781.2909999999999, 1751.18),
        radius: const Radius.elliptical(136.44, 136.44),
      )
      ..cubicTo(
        752.135,
        1766.03,
        713.9639999999999,
        1766.03,
        637.6279999999999,
        1766.03,
      )
      ..lineTo(235.371, 1766.03)
      ..cubicTo(
        159.034,
        1766.03,
        120.86600000000001,
        1766.03,
        91.709,
        1751.18,
      )
      ..arcToPoint(
        const Offset(32.143, 1691.6100000000001),
        radius: const Radius.elliptical(136.4, 136.4),
      )
      ..cubicTo(
        17.287,
        1662.45,
        17.287,
        1624.2800000000002,
        17.287,
        1547.94,
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
      ..moveTo(524.598, 61.838)
      ..lineTo(348.402, 61.838)
      ..cubicTo(
        328.20599999999996,
        61.838,
        311.83299999999997,
        78.211,
        311.83299999999997,
        98.408,
      )
      ..cubicTo(
        311.83299999999997,
        118.606,
        328.20599999999996,
        134.97899999999998,
        348.402,
        134.97899999999998,
      )
      ..lineTo(524.598, 134.97899999999998)
      ..cubicTo(
        544.794,
        134.97899999999998,
        561.1669999999999,
        118.60599999999998,
        561.1669999999999,
        98.40899999999999,
      )
      ..cubicTo(
        561.1669999999999,
        78.21099999999998,
        544.7939999999999,
        61.837999999999994,
        524.598,
        61.837999999999994,
      );
    canvas.drawPath(
      dynamicIslandPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF000000),
    );

    final cameraPath1 = Path()
      ..moveTo(524.598, 109.38)
      ..cubicTo(
        530.473,
        109.38,
        535.236,
        104.61699999999999,
        535.236,
        98.741,
      )
      ..cubicTo(
        535.236,
        92.86500000000001,
        530.473,
        88.102,
        524.598,
        88.102,
      )
      ..cubicTo(
        518.723,
        88.102,
        513.9599999999999,
        92.86500000000001,
        513.9599999999999,
        98.741,
      )
      ..cubicTo(
        513.9599999999999,
        104.61699999999999,
        518.723,
        109.38,
        524.598,
        109.38,
      );
    canvas.drawPath(
      cameraPath1,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF131423),
    );

    final cameraPath2 = Path()
      ..moveTo(533.241, 98.741)
      ..arcToPoint(
        const Offset(515.9549999999999, 98.741),
        radius: const Radius.elliptical(8.644, 8.644),
        largeArc: true,
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(533.241, 98.741),
        radius: const Radius.elliptical(8.644, 8.644),
        clockwise: false,
      );
    canvas.drawPath(
      cameraPath2,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF07144C),
    );

    final cameraPath3 = Path()
      ..moveTo(517.306, 98.253)
      ..cubicTo(517.447, 94.469, 520.7660000000001, 91.759, 524.552, 91.759)
      ..cubicTo(528.379, 91.759, 531.74, 94.522, 531.89, 98.346)
      ..quadraticBezierTo(531.912, 98.887, 531.912, 99.406)
      ..cubicTo(
        531.912,
        99.75,
        531.904,
        100.10600000000001,
        531.89,
        100.46600000000001,
      )
      ..cubicTo(
        531.74,
        104.29,
        528.379,
        107.05300000000001,
        524.552,
        107.05300000000001,
      )
      ..cubicTo(
        520.7660000000001,
        107.05300000000001,
        517.447,
        104.34300000000002,
        517.306,
        100.55900000000001,
      )
      ..arcToPoint(
        const Offset(517.306, 98.25300000000001),
        radius: const Radius.elliptical(32, 32),
      );
    canvas.drawPath(
      cameraPath3,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0x66030303),
    );

    final cameraPath4 = Path()
      ..moveTo(524.598, 105.723)
      ..cubicTo(
        526.434,
        105.723,
        527.9219999999999,
        104.383,
        527.9219999999999,
        102.731,
      )
      ..cubicTo(
        527.9219999999999,
        101.07799999999999,
        526.4339999999999,
        99.738,
        524.598,
        99.738,
      )
      ..cubicTo(
        522.7620000000001,
        99.738,
        521.2729999999999,
        101.078,
        521.2729999999999,
        102.731,
      )
      ..cubicTo(
        521.2729999999999,
        104.38399999999999,
        522.762,
        105.723,
        524.598,
        105.723,
      );
    canvas.drawPath(
      cameraPath4,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.5000000, size.height * 0.03477953),
          Offset(size.width * 0.5000000, size.height * 0.07591620),
          const [Color(0x451D869C), Color(0x4C2371C6), Color(0x4C040AAD)],
          const [0, 0.371, 1],
        ),
    );

    final cameraPath5 = Path()
      ..moveTo(524.598, 105.723)
      ..arcToPoint(
        const Offset(524.598, 101.733),
        radius: const Radius.elliptical(1.995, 1.995),
        largeArc: true,
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(524.598, 105.723),
        radius: const Radius.elliptical(1.995, 1.995),
        clockwise: false,
      );
    canvas.drawPath(
      cameraPath5,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.5000000, size.height * 0.03820754),
          Offset(size.width * 0.5000000, size.height * 0.07591620),
          const [Color(0x59005267), Color(0x59415967), Color(0x598700C7)],
          const [0, 0.486, 1],
        ),
    );

    final cameraPath6 = Path()
      ..moveTo(524.598, 104.06)
      ..arcToPoint(
        const Offset(524.598, 93.422),
        radius: const Radius.elliptical(5.318, 5.318),
        largeArc: true,
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(524.598, 104.06),
        radius: const Radius.elliptical(5.319, 5.319),
        largeArc: true,
        clockwise: false,
      );
    canvas.drawPath(
      cameraPath6,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.6009141, size.height * 0.05235602),
          Offset(size.width * 0.6009141, size.height * 0.05516085),
          const [Color(0xFF5978DD), Color(0x9C312FAD), Color(0x001C1C86)],
          const [0, 0.379, 1],
        ),
    );

    final speakerPath = Path()
      ..moveTo(522.827, 12.8)
      ..cubicTo(
        522.323,
        13.155000000000001,
        521.867,
        13.594000000000001,
        521.479,
        14.110000000000001,
      )
      ..lineTo(521.2700000000001, 14.406)
      ..lineTo(520.07, 16.206)
      ..cubicTo(
        519.398,
        17.214,
        518.3580000000001,
        17.786,
        517.277,
        17.786,
      )
      ..lineTo(356.38700000000006, 17.786)
      ..cubicTo(
        355.3740000000001,
        17.785,
        354.39700000000005,
        17.283,
        353.72600000000006,
        16.39,
      )
      ..lineTo(353.59600000000006, 16.206)
      ..lineTo(352.3960000000001, 14.405999999999999)
      ..arcToPoint(
        const Offset(350.8380000000001, 12.800999999999998),
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

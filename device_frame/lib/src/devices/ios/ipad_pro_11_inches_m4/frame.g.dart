part of 'device.dart';

// Generated with https://fluttershapemaker.com and manually adjusted.
class _FramePainter extends CustomPainter {
  const _FramePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final buttonsPath = Path()
      ..moveTo(925, 103)
      ..arcToPoint(
        const Offset(926.5, 104.5),
        radius: const Radius.elliptical(1.5, 1.5),
      )
      ..lineTo(926.5, 154)
      ..arcToPoint(
        const Offset(925, 155.5),
        radius: const Radius.elliptical(1.5, 1.5),
      )
      ..lineTo(921.5, 155.5)
      ..lineTo(921.5, 103)
      ..close()
      ..moveTo(789, 1.5)
      ..arcToPoint(
        const Offset(790.5, 0),
        radius: const Radius.elliptical(1.5, 1.5),
      )
      ..lineTo(849.5, 0)
      ..arcToPoint(
        const Offset(851, 1.5),
        radius: const Radius.elliptical(1.5, 1.5),
      )
      ..lineTo(851, 5)
      ..lineTo(789, 5)
      ..close()
      ..moveTo(925, 165.5)
      ..arcToPoint(
        const Offset(926.5, 167),
        radius: const Radius.elliptical(1.5, 1.5),
      )
      ..lineTo(926.5, 216.5)
      ..arcToPoint(
        const Offset(925, 218),
        radius: const Radius.elliptical(1.5, 1.5),
      )
      ..lineTo(921.5, 218)
      ..lineTo(921.5, 165.5)
      ..close();
    canvas.drawPath(
      buttonsPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF3B393B),
    );

    final buttonsShadowPath = Path()
      ..moveTo(921.5, 103)
      ..lineTo(921.5, 155.5)
      ..close()
      ..moveTo(921.5, 165.5)
      ..lineTo(921.5, 218)
      ..close()
      ..moveTo(789, 5)
      ..lineTo(851, 5)
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
      ..moveTo(823.2, 2.75)
      ..cubicTo(850.0020000000001, 2.75, 863.404, 2.75, 874.249, 6.274)
      ..arcToPoint(
        const Offset(920.476, 52.5),
        radius: const Radius.elliptical(72, 72),
      )
      ..cubicTo(924, 63.346, 924, 76.748, 924, 103.55)
      ..lineTo(924, 1201.45)
      ..cubicTo(924, 1228.25, 924, 1241.65, 920.476, 1252.5)
      ..arcToPoint(
        const Offset(874.249, 1298.73),
        radius: const Radius.elliptical(72.02, 72.02),
      )
      ..cubicTo(
        863.404,
        1302.25,
        850.0020000000001,
        1302.25,
        823.2,
        1302.25,
      )
      ..lineTo(100.8, 1302.25)
      ..cubicTo(
        73.99799999999999,
        1302.25,
        60.596,
        1302.25,
        49.751,
        1298.73,
      )
      ..arcToPoint(
        const Offset(3.524000000000001, 1252.5),
        radius: const Radius.elliptical(72.02, 72.02),
      )
      ..cubicTo(0, 1241.65, 0, 1228.25, 0, 1201.45)
      ..lineTo(0, 103.55)
      ..cubicTo(0, 76.748, 0, 63.346, 3.524, 52.5)
      ..arcToPoint(
        const Offset(49.751, 6.275),
        radius: const Radius.elliptical(72, 72),
      )
      ..cubicTo(60.596, 2.75, 73.998, 2.75, 100.8, 2.75)
      ..close();
    canvas.drawPath(
      backgroundPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF3B393B),
    );

    final antennasPath = Path()
      ..moveTo(923.6, 69.125)
      ..lineTo(924, 79.125)
      ..lineTo(915.8750000000001, 79.125)
      ..lineTo(915.8750000000001, 69.125)
      ..close()
      ..moveTo(9.875, 69.125)
      ..lineTo(9.875, 79.125)
      ..lineTo(1.073, 79.125)
      ..lineTo(1.523, 69.125)
      ..close();
    canvas.drawPath(
      antennasPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0x40000000),
    );

    final bezelPath = Path()
      ..moveTo(807, 7.5)
      ..cubicTo(846.204, 7.5, 865.806, 7.5, 880.779, 15.129999999999999)
      ..arcToPoint(
        const Offset(911.37, 45.72),
        radius: const Radius.elliptical(70, 70),
      )
      ..cubicTo(919, 60.695, 919, 80.297, 919, 119.5)
      ..lineTo(919, 1185.5)
      ..cubicTo(919, 1224.7, 919, 1244.31, 911.37, 1259.28)
      ..arcToPoint(
        const Offset(880.779, 1289.87),
        radius: const Radius.elliptical(70, 70),
      )
      ..cubicTo(865.806, 1297.5, 846.204, 1297.5, 807, 1297.5)
      ..lineTo(117, 1297.5)
      ..cubicTo(
        77.79599999999999,
        1297.5,
        58.194,
        1297.5,
        43.221000000000004,
        1289.87,
      )
      ..arcToPoint(
        const Offset(12.630000000000003, 1259.28),
        radius: const Radius.elliptical(70, 70),
      )
      ..cubicTo(5, 1244.31, 5, 1224.7, 5, 1185.5)
      ..lineTo(5, 119.5)
      ..cubicTo(5, 80.29599999999999, 5, 60.695, 12.629999999999999, 45.72)
      ..arcToPoint(
        const Offset(43.221000000000004, 15.129999999999999),
        radius: const Radius.elliptical(70, 70),
      )
      ..cubicTo(58.194, 7.5, 77.796, 7.5, 117, 7.5)
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
          ..strokeWidth = size.width * 0.0008
          ..maskFilter = MaskFilter.blur(
            BlurStyle.normal,
            size.width * 0.0015,
          ),
      );

    final cameraPath1 = Path()
      ..moveTo(895, 607.5)
      ..arcToPoint(
        const Offset(905.001, 607.499),
        radius: const Radius.elliptical(5, 5),
        largeArc: true,
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(895, 607.5),
        radius: const Radius.elliptical(5, 5),
        clockwise: false,
      );
    canvas.drawPath(
      cameraPath1,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF131423),
    );

    final cameraPath2 = Path()
      ..moveTo(900, 611.562)
      ..arcToPoint(
        const Offset(900, 603.438),
        radius: const Radius.elliptical(4.061, 4.061),
        largeArc: true,
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(900, 611.562),
        radius: const Radius.elliptical(4.061, 4.061),
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
      ..moveTo(900.229, 604.073)
      ..cubicTo(
        902.008,
        604.139,
        903.2810000000001,
        605.699,
        903.2810000000001,
        607.4789999999999,
      )
      ..cubicTo(
        903.2810000000001,
        609.2769999999999,
        901.9830000000001,
        610.857,
        900.186,
        610.9269999999999,
      )
      ..arcToPoint(
        const Offset(899.1890000000001, 610.9269999999999),
        radius: const Radius.elliptical(12, 12),
      )
      ..cubicTo(
        897.392,
        610.8569999999999,
        896.094,
        609.2769999999999,
        896.094,
        607.4789999999999,
      )
      ..cubicTo(
        896.094,
        605.699,
        897.3670000000001,
        604.1389999999999,
        899.1460000000001,
        604.073,
      )
      ..arcToPoint(
        const Offset(900.229, 604.073),
        radius: const Radius.elliptical(14, 14),
      );
    canvas.drawPath(
      cameraPath3,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0x66030303),
    );

    final cameraPath4 = Path()
      ..moveTo(896.719, 607.5)
      ..cubicTo(
        896.719,
        608.363,
        897.3480000000001,
        609.062,
        898.125,
        609.062,
      )
      ..cubicTo(
        898.9019999999999,
        609.062,
        899.531,
        608.363,
        899.531,
        607.5,
      )
      ..cubicTo(
        899.531,
        606.637,
        898.9019999999999,
        605.938,
        898.125,
        605.938,
      )
      ..cubicTo(
        897.3480000000001,
        605.938,
        896.719,
        606.637,
        896.719,
        607.5,
      );
    canvas.drawPath(
      cameraPath4,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.9762675, size.height * 0.4662318),
          Offset(size.width * 0.9654800, size.height * 0.4662318),
          const [Color(0x451D869C), Color(0x4C2371C6), Color(0x4C040AAD)],
          const [0, 0.371, 1],
        ),
    );

    final cameraPath5 = Path()
      ..moveTo(896.719, 607.5)
      ..arcToPoint(
        const Offset(898.5930000000001, 607.502),
        radius: const Radius.elliptical(0.937, 0.937),
        largeArc: true,
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(896.719, 607.5),
        radius: const Radius.elliptical(0.937, 0.937),
        clockwise: false,
      );
    canvas.drawPath(
      cameraPath5,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.9753689, size.height * 0.4662318),
          Offset(size.width * 0.9654800, size.height * 0.4662318),
          const [Color(0x59005267), Color(0x59415967), Color(0x598700C7)],
          const [0, 0.486, 1],
        ),
    );

    final cameraPath6 = Path()
      ..moveTo(897.5, 607.5)
      ..arcToPoint(
        const Offset(902.5, 607.5),
        radius: const Radius.elliptical(2.5, 2.5),
        largeArc: true,
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(897.5, 607.5),
        radius: const Radius.elliptical(2.5, 2.5),
        clockwise: false,
      );
    canvas.drawPath(
      cameraPath6,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.9737389, size.height * 0.4662318),
          Offset(size.width * 0.9712104, size.height * 0.4662318),
          const [Color(0xFF5978DD), Color(0x9C312FAD), Color(0x001C1C86)],
          const [0, 0.379, 1],
        ),
    );

    canvas.drawCircle(
      Offset(size.width * 0.9708738, size.height * 0.5356869),
      size.width * 0.002157497,
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

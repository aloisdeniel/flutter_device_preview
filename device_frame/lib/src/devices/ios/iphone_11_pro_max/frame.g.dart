part of 'device.dart';

// Generated with https://fluttershapemaker.com and manually adjusted.
class _FramePainter extends CustomPainter {
  const _FramePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final buttonsPath = Path()
      ..moveTo(32.958, 215.279)
      ..lineTo(3.787, 215.279)
      ..arcToPoint(
        const Offset(0, 219.064),
        radius: const Radius.elliptical(3.786, 3.786),
        clockwise: false,
      )
      ..lineTo(0, 273.725)
      ..arcToPoint(
        const Offset(3.787, 277.509),
        radius: const Radius.elliptical(3.785, 3.785),
        clockwise: false,
      )
      ..lineTo(32.957, 277.509)
      ..arcToPoint(
        const Offset(36.744, 273.725),
        radius: const Radius.elliptical(3.785, 3.785),
        clockwise: false,
      )
      ..lineTo(36.744, 219.06400000000002)
      ..arcToPoint(
        const Offset(32.958, 215.27900000000002),
        radius: const Radius.elliptical(3.786, 3.786),
        clockwise: false,
      )
      ..moveTo(3.788, 331.331)
      ..arcToPoint(
        const Offset(0, 335.112),
        radius: const Radius.elliptical(3.775, 3.775),
        clockwise: false,
      )
      ..lineTo(0, 443.45500000000004)
      ..arcToPoint(
        const Offset(3.788, 447.24000000000007),
        radius: const Radius.elliptical(3.78, 3.78),
        clockwise: false,
      )
      ..lineTo(32.955999999999996, 447.24000000000007)
      ..arcToPoint(
        const Offset(36.74399999999999, 443.45500000000004),
        radius: const Radius.elliptical(3.78, 3.78),
        clockwise: false,
      )
      ..lineTo(36.74399999999999, 335.112)
      ..arcToPoint(
        const Offset(32.955999999999996, 331.331),
        radius: const Radius.elliptical(3.775, 3.775),
        clockwise: false,
      )
      ..close()
      ..moveTo(3.788, 477.095)
      ..arcToPoint(
        const Offset(0, 480.876),
        radius: const Radius.elliptical(3.775, 3.775),
        clockwise: false,
      )
      ..lineTo(0, 589.218)
      ..arcToPoint(
        const Offset(3.788, 593.0039999999999),
        radius: const Radius.elliptical(3.78, 3.78),
        clockwise: false,
      )
      ..lineTo(32.955999999999996, 593.0039999999999)
      ..arcToPoint(
        const Offset(36.74399999999999, 589.218),
        radius: const Radius.elliptical(3.78, 3.78),
        clockwise: false,
      )
      ..lineTo(36.74399999999999, 480.876)
      ..arcToPoint(
        const Offset(32.955999999999996, 477.09499999999997),
        radius: const Radius.elliptical(3.775, 3.775),
        clockwise: false,
      )
      ..close()
      ..moveTo(869.212, 369.242)
      ..arcToPoint(
        const Offset(873, 373.023),
        radius: const Radius.elliptical(3.776, 3.776),
      )
      ..lineTo(873, 548.758)
      ..arcToPoint(
        const Offset(869.212, 552.543),
        radius: const Radius.elliptical(3.78, 3.78),
      )
      ..lineTo(840.044, 552.543)
      ..arcToPoint(
        const Offset(836.256, 548.758),
        radius: const Radius.elliptical(3.78, 3.78),
      )
      ..lineTo(836.256, 373.023)
      ..arcToPoint(
        const Offset(840.044, 369.242),
        radius: const Radius.elliptical(3.776, 3.776),
      )
      ..close();
    canvas.drawPath(
      buttonsPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF4E5C52),
    );

    final backgroundPath = Path()
      ..moveTo(121.599, 0)
      ..cubicTo(56.645, 0, 4.356, 52.256, 4.356, 117.169)
      ..lineTo(4.356, 1638.83)
      ..cubicTo(4.356, 1703.74, 56.645, 1756, 121.59899999999999, 1756)
      ..lineTo(751.4010000000001, 1756)
      ..cubicTo(816.355, 1756, 868.644, 1703.74, 868.644, 1638.83)
      ..lineTo(868.644, 117.169)
      ..cubicTo(868.644, 52.256, 816.355, 0, 751.401, 0)
      ..close();
    canvas.drawPath(
      backgroundPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF3C4940),
    );

    final glassPath1 = Path()
      ..moveTo(745.555, 6.582)
      ..lineTo(129.597, 6.582)
      ..cubicTo(
        64.534,
        6.582,
        11.791000000000011,
        59.292,
        11.791000000000011,
        124.314,
      )
      ..lineTo(11.791000000000011, 1632.92)
      ..cubicTo(
        11.791000000000011,
        1697.94,
        64.53400000000002,
        1750.65,
        129.597,
        1750.65,
      )
      ..lineTo(745.555, 1750.65)
      ..cubicTo(810.617, 1750.65, 863.361, 1697.94, 863.361, 1632.92)
      ..lineTo(863.361, 124.314)
      ..cubicTo(
        863.361,
        59.29199999999999,
        810.617,
        6.581999999999994,
        745.555,
        6.581999999999994,
      );
    canvas.drawPath(
      glassPath1,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF000000),
    );

    final glassPath2 = Path()
      ..moveTo(795.59, 32.436)
      ..cubicTo(792.981, 32.178, 794.2130000000001, 34.778, 800.068, 40.198)
      ..cubicTo(819.385, 58.08, 831.38, 83.963, 831.38, 112.77199999999999)
      ..lineTo(831.38, 1644.35)
      ..cubicTo(
        831.38,
        1673.1599999999999,
        819.385,
        1699.04,
        800.068,
        1716.9199999999998,
      )
      ..cubicTo(
        794.213,
        1722.34,
        792.981,
        1724.9399999999998,
        795.59,
        1724.6799999999998,
      )
      ..cubicTo(
        797.1560000000001,
        1724.5299999999997,
        800.105,
        1723.34,
        804.263,
        1721.1299999999999,
      )
      ..cubicTo(832.496, 1706.07, 848.89, 1673.6, 848.89, 1639.11)
      ..lineTo(848.89, 118.01)
      ..cubicTo(
        848.89,
        83.518,
        832.496,
        51.04400000000001,
        804.263,
        35.992000000000004,
      )
      ..cubicTo(
        800.105,
        33.775000000000006,
        797.1560000000001,
        32.592000000000006,
        795.59,
        32.43600000000001,
      );
    canvas.drawPath(
      glassPath2,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.9496804, size.height * 0.4555888),
          Offset(size.width * 0.9723826, size.height * 0.4555888),
          const [Color(0xff404040), Color(0xff838383), Color(0xffA7A7A7)],
          [0, 0.6, 1],
        ),
    );

    final glassPath3 = Path()
      ..moveTo(77.41, 32.436)
      ..cubicTo(80.02, 32.178, 78.788, 34.778, 72.93299999999999, 40.198)
      ..cubicTo(53.615, 58.08, 41.62, 83.963, 41.62, 112.772)
      ..lineTo(41.62, 1644.35)
      ..cubicTo(
        41.62,
        1673.1599999999999,
        53.614,
        1699.04,
        72.932,
        1716.9199999999998,
      )
      ..cubicTo(
        78.787,
        1722.34,
        80.018,
        1724.9399999999998,
        77.409,
        1724.6799999999998,
      )
      ..cubicTo(
        75.84400000000001,
        1724.5299999999997,
        72.89500000000001,
        1723.34,
        68.736,
        1721.1299999999999,
      )
      ..cubicTo(
        40.504000000000005,
        1706.07,
        24.109,
        1673.6,
        24.109,
        1639.11,
      )
      ..lineTo(24.109, 118.01)
      ..cubicTo(
        24.109,
        83.518,
        40.504000000000005,
        51.04400000000001,
        68.736,
        35.992000000000004,
      )
      ..cubicTo(
        72.89500000000001,
        33.775000000000006,
        75.84400000000001,
        32.592000000000006,
        77.409,
        32.43600000000001,
      );
    canvas.drawPath(
      glassPath3,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.05031959, size.height * 0.4555888),
          Offset(size.width * 0.02761741, size.height * 0.4555888),
          const [Color(0xFF404040), Color(0xFF838383), Color(0xFFA7A7A7)],
          [0, 0.6, 1],
        ),
    );

    final glassPath4 = Path()
      ..moveTo(122.78, 1736.05)
      ..cubicTo(103.482, 1736.05, 85.53, 1730.53, 70.374, 1721.01)
      ..lineTo(70.374, 1708.3799999999999)
      ..cubicTo(84.818, 1717.85, 102.11, 1723.36, 120.749, 1723.36)
      ..lineTo(753.3720000000001, 1723.36)
      ..cubicTo(
        772.0120000000001,
        1723.36,
        789.3040000000001,
        1717.85,
        803.748,
        1708.3799999999999,
      )
      ..lineTo(803.748, 1721.01)
      ..cubicTo(
        788.5920000000001,
        1730.53,
        770.6400000000001,
        1736.05,
        751.3420000000001,
        1736.05,
      )
      ..close();
    canvas.drawPath(
      glassPath4,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.08061168, size.height * 0.9728815),
          Offset(size.width * 0.9206735, size.height * 0.9728815),
          const [
            Color(0x214F4F4F),
            Color(0xff4F4F4F),
            Color(0xF34F4F4F),
            Color(0x004F4F4F),
          ],
          [0, 0.07, 0.937, 1],
        ),
    );

    final glassPath5 = Path()
      ..moveTo(122.78, 19.955)
      ..cubicTo(103.482, 19.955, 85.53, 25.470999999999997, 70.374, 34.992)
      ..lineTo(70.374, 47.617999999999995)
      ..cubicTo(
        84.818,
        38.14999999999999,
        102.11,
        32.63799999999999,
        120.749,
        32.63799999999999,
      )
      ..lineTo(458.32, 32.63799999999999)
      ..lineTo(753.887, 33.63799999999999)
      ..cubicTo(
        772.5269999999999,
        33.70099999999999,
        789.819,
        39.14999999999999,
        804.2629999999999,
        48.617999999999995,
      )
      ..lineTo(804.2629999999999, 35.992)
      ..cubicTo(
        789.107,
        26.471999999999998,
        771.155,
        21.020999999999997,
        751.857,
        20.955,
      )
      ..lineTo(458.32, 19.955)
      ..close();

    canvas.drawPath(
      glassPath5,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(size.width * 0.08061168, size.height * 0.02711731),
          Offset(size.width * 0.9234536, size.height * 0.02711731),
          const [
            Color(0x214F4F4F),
            Color(0xFF4F4F4F),
            Color(0xF34F4F4F),
            Color(0x004F4F4F),
          ],
          [0, 0.07, 0.937, 1],
        ),
    );

    final borderPath = Path()
      ..moveTo(7.024, 1591.88)
      ..lineTo(16.279, 1591.88)
      ..lineTo(16.279, 164.682)
      ..lineTo(7.024, 164.682)
      ..close()
      ..moveTo(866.273, 1602.91)
      ..lineTo(857.019, 1602.91)
      ..lineTo(857.019, 1639.48)
      ..cubicTo(857.019, 1698.49, 809.183, 1745.91, 750.134, 1745.91)
      ..lineTo(122.865, 1745.91)
      ..cubicTo(
        63.81699999999999,
        1745.91,
        16.278999999999996,
        1698.4,
        16.278999999999996,
        1639.39,
      )
      ..lineTo(16.278999999999996, 1602.8100000000002)
      ..lineTo(7.024, 1602.8100000000002)
      ..lineTo(7.024, 1634.5500000000002)
      ..cubicTo(
        7.024,
        1700.4300000000003,
        60.101,
        1753.4800000000002,
        126.028,
        1753.4800000000002,
      )
      ..lineTo(746.972, 1753.4800000000002)
      ..cubicTo(
        812.899,
        1753.4800000000002,
        866.273,
        1700.5300000000002,
        866.273,
        1634.6400000000003,
      )
      ..close()
      ..moveTo(126.028, 3.36)
      ..cubicTo(60.101, 3.35, 7.024, 56.404, 7.024, 122.29)
      ..lineTo(7.024, 153.752)
      ..lineTo(16.279, 153.752)
      ..lineTo(16.279, 118.709)
      ..cubicTo(
        16.279,
        59.697,
        63.816,
        12.183999999999997,
        122.865,
        12.194000000000003,
      )
      ..lineTo(750.432, 12.293000000000003)
      ..cubicTo(
        809.481,
        12.302000000000003,
        857.019,
        59.79600000000001,
        857.019,
        118.808,
      )
      ..lineTo(857.019, 153.851)
      ..lineTo(866.273, 153.851)
      ..lineTo(866.273, 122.39)
      ..cubicTo(
        866.273,
        56.504000000000005,
        813.196,
        3.4710000000000036,
        747.269,
        3.4599999999999937,
      )
      ..close()
      ..moveTo(857.019, 1591.9699999999998)
      ..lineTo(866.273, 1591.9699999999998)
      ..lineTo(866.273, 164.78)
      ..lineTo(857.019, 164.78)
      ..close();
    canvas.drawPath(
      borderPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF57645B),
    );

    final cameraPath1 = Path()
      ..moveTo(521.78, 75.811)
      ..cubicTo(
        528.015,
        75.811,
        533.0699999999999,
        70.76,
        533.0699999999999,
        64.52900000000001,
      )
      ..cubicTo(
        533.0699999999999,
        58.298000000000016,
        528.015,
        53.24600000000001,
        521.78,
        53.24600000000001,
      )
      ..cubicTo(
        515.545,
        53.24600000000001,
        510.48999999999995,
        58.29700000000001,
        510.48999999999995,
        64.52900000000001,
      )
      ..cubicTo(
        510.48999999999995,
        70.76100000000001,
        515.545,
        75.811,
        521.78,
        75.811,
      );
    canvas.drawPath(
      cameraPath1,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF161616),
    );

    final cameraPath2 = Path()
      ..moveTo(521.78, 73.569)
      ..cubicTo(526.776, 73.569, 530.826, 69.521, 530.826, 64.529)
      ..cubicTo(
        530.826,
        59.535999999999994,
        526.7760000000001,
        55.489,
        521.78,
        55.489,
      )
      ..cubicTo(
        516.7839999999999,
        55.489,
        512.7339999999999,
        59.535999999999994,
        512.7339999999999,
        64.529,
      )
      ..cubicTo(
        512.7339999999999,
        69.52199999999999,
        516.7839999999999,
        73.56899999999999,
        521.78,
        73.56899999999999,
      );
    canvas.drawPath(
      cameraPath2,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF0A0D13),
    );

    final cameraPath3 = Path()
      ..moveTo(521.78, 71.416)
      ..arcToPoint(
        const Offset(528.672, 64.52799999999999),
        radius: const Radius.elliptical(6.89, 6.89),
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(521.78, 57.64099999999999),
        radius: const Radius.elliptical(6.89, 6.89),
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(514.8879999999999, 64.52799999999999),
        radius: const Radius.elliptical(6.89, 6.89),
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(521.78, 71.416),
        radius: const Radius.elliptical(6.89, 6.89),
        clockwise: false,
      );
    canvas.drawPath(
      cameraPath3,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF091427),
    );

    final cameraPath4 = Path()
      ..moveTo(517.035, 59.92)
      ..cubicTo(
        516.218,
        60.007000000000005,
        515.0559999999999,
        61.254000000000005,
        514.9699999999999,
        63.704,
      )
      ..cubicTo(
        514.8839999999999,
        66.154,
        515.9599999999999,
        67.487,
        516.5619999999999,
        67.487,
      )
      ..cubicTo(
        517.1639999999999,
        67.487,
        519.6589999999999,
        63.919,
        517.0349999999999,
        59.92099999999999,
      );
    canvas.drawPath(
      cameraPath4,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0x8E235A91),
    );

    final cameraPath5 = Path()
      ..moveTo(522.905, 59.063)
      ..cubicTo(
        521.616,
        59.46,
        521.3679999999999,
        61.541000000000004,
        521.4169999999999,
        62.730000000000004,
      )
      ..cubicTo(
        521.4669999999999,
        63.92,
        523.1529999999999,
        67.041,
        525.1859999999999,
        66.34700000000001,
      )
      ..cubicTo(
        527.2189999999999,
        65.65400000000001,
        527.5659999999999,
        63.077000000000005,
        526.723,
        61.34300000000001,
      )
      ..cubicTo(
        525.88,
        59.60800000000001,
        524.343,
        58.369000000000014,
        522.905,
        59.06300000000001,
      );
    canvas.drawPath(
      cameraPath5,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0x8E235A91),
    );

    final sensorsPath = Path()
      ..moveTo(279.786, 72.061)
      ..arcToPoint(
        const Offset(287.323, 64.52900000000001),
        radius: const Radius.elliptical(7.534, 7.534),
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(279.786, 56.997000000000014),
        radius: const Radius.elliptical(7.534, 7.534),
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(272.249, 64.52900000000001),
        radius: const Radius.elliptical(7.535, 7.535),
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(279.786, 72.061),
        radius: const Radius.elliptical(7.535, 7.535),
        clockwise: false,
      )
      ..moveTo(581.365, 78.00800000000001)
      ..cubicTo(
        588.813,
        78.00800000000001,
        594.852,
        71.97300000000001,
        594.852,
        64.52900000000001,
      )
      ..cubicTo(
        594.852,
        57.08500000000001,
        588.813,
        51.05100000000001,
        581.365,
        51.05100000000001,
      )
      ..cubicTo(
        573.917,
        51.05100000000001,
        567.878,
        57.08500000000001,
        567.878,
        64.52900000000001,
      )
      ..cubicTo(
        567.878,
        71.97300000000001,
        573.916,
        78.00800000000001,
        581.365,
        78.00800000000001,
      )
      ..moveTo(343.162, 75.63)
      ..cubicTo(349.296, 75.63, 354.269, 70.66, 354.269, 64.53)
      ..cubicTo(
        354.269,
        58.400000000000006,
        349.296,
        53.43,
        343.16200000000003,
        53.43,
      )
      ..cubicTo(
        337.0280000000001,
        53.43,
        332.05500000000006,
        58.4,
        332.05500000000006,
        64.53,
      )
      ..cubicTo(
        332.05500000000006,
        70.66,
        337.0280000000001,
        75.63,
        343.16200000000003,
        75.63,
      );
    canvas.drawPath(
      sensorsPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0x11FFFFFF),
    );

    final speakerPath = Path()
      ..moveTo(394.432, 59.263)
      ..arcToPoint(
        const Offset(388.384, 65.307),
        radius: const Radius.elliptical(6.03, 6.03),
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(394.432, 71.351),
        radius: const Radius.elliptical(6.03, 6.03),
        clockwise: false,
      )
      ..lineTo(477.73400000000004, 71.351)
      ..arcToPoint(
        const Offset(483.78200000000004, 65.307),
        radius: const Radius.elliptical(6.03, 6.03),
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(477.73400000000004, 59.263000000000005),
        radius: const Radius.elliptical(6.03, 6.03),
        clockwise: false,
      )
      ..close();
    canvas.drawPath(
      speakerPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xCC151515),
    );

    final antennasPath = Path()
      ..moveTo(7.024, 164.682)
      ..lineTo(16.279, 164.682)
      ..lineTo(16.279, 153.75099999999998)
      ..lineTo(7.024, 153.75099999999998)
      ..close()
      ..moveTo(716.157, 12.193)
      ..lineTo(716.157, 3.36)
      ..lineTo(705.22, 3.36)
      ..lineTo(705.22, 12.193)
      ..close()
      ..moveTo(156.843, 1745.91)
      ..lineTo(156.843, 1753.48)
      ..lineTo(167.78099999999998, 1753.48)
      ..lineTo(167.78099999999998, 1745.91)
      ..close()
      ..moveTo(857.019, 164.78)
      ..lineTo(866.273, 164.78)
      ..lineTo(866.273, 153.85)
      ..lineTo(857.019, 153.85)
      ..close()
      ..moveTo(857.019, 1602.91)
      ..lineTo(866.273, 1602.91)
      ..lineTo(866.273, 1591.97)
      ..lineTo(857.019, 1591.97)
      ..close()
      ..moveTo(7.024000000000001, 1602.8100000000002)
      ..lineTo(16.279000000000003, 1602.8100000000002)
      ..lineTo(16.279000000000003, 1591.88)
      ..lineTo(7.024, 1591.88)
      ..close();
    canvas.drawPath(
      antennasPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF424F46),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

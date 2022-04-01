// ignore_for_file: require_trailing_commas, non_constant_identifier_names

part of 'device.dart';

// Generated manually with https://fluttershapemaker.com/
class _FramePainter extends CustomPainter {
  const _FramePainter();

  @override
  void paint(Canvas canvas, Size size) {

    Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    paint_0_fill.color = Color(0xff3A4245).withOpacity(1.0);
    // These lines differ from other frames as they were developed natively in
    // Figma and the svg was save with a parametric rounded rect instead of a
    // custom path.
    canvas.drawRRect(RRect.fromRectAndCorners(Rect.fromLTWH(size.width*0.0003710935,size.height*0.007120380,size.width*0.9964216,size.height*0.9926980),bottomRight: Radius.circular(size.width*0.05891892),bottomLeft:  Radius.circular(size.width*0.05891892),topLeft:  Radius.circular(size.width*0.05891892),topRight:  Radius.circular(size.width*0.05891892)),paint_0_fill);

    Paint paint_1_fill = Paint()..style=PaintingStyle.fill;
    paint_1_fill.color = Color(0xff121515).withOpacity(1.0);
    canvas.drawRRect(RRect.fromRectAndCorners(Rect.fromLTWH(size.width*0.004589843,size.height*0.01005611,size.width*0.9885297,size.height*0.9869802),bottomRight: Radius.circular(size.width*0.05405405),bottomLeft:  Radius.circular(size.width*0.05405405),topLeft:  Radius.circular(size.width*0.05405405),topRight:  Radius.circular(size.width*0.05405405)),paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(1844.07,183.302);
    path_2.cubicTo(1847.21,183.302,1849.75,184.073,1849.75,185.025);
    path_2.lineTo(1849.75,267.72);
    path_2.cubicTo(1849.75,268.671,1847.21,269.442,1844.07,269.442);
    path_2.lineTo(1844.07,183.302);
    path_2.close();

    Paint paint_2_fill = Paint()..style=PaintingStyle.fill;
    paint_2_fill.color = Color(0xff121515).withOpacity(1.0);
    canvas.drawPath(path_2,paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(1844.07,288.202);
    path_3.cubicTo(1847.21,288.202,1849.75,288.973,1849.75,289.925);
    path_3.lineTo(1849.75,372.619);
    path_3.cubicTo(1849.75,373.571,1847.21,374.342,1844.07,374.342);
    path_3.lineTo(1844.07,288.202);
    path_3.close();

    Paint paint_3_fill = Paint()..style=PaintingStyle.fill;
    paint_3_fill.color = Color(0xff121515).withOpacity(1.0);
    canvas.drawPath(path_3,paint_3_fill);

    Path path_4 = Path();
    path_4.moveTo(1632.58,18.5701);
    path_4.cubicTo(1632.58,15.6187,1633.49,13.2262,1634.6,13.2262);
    path_4.lineTo(1731.7,13.2262);
    path_4.cubicTo(1732.81,13.2262,1733.72,15.6187,1733.72,18.5701);
    path_4.lineTo(1632.58,18.5701);
    path_4.close();

    Paint paint_4_fill = Paint()..style=PaintingStyle.fill;
    paint_4_fill.color = Color(0xff121515).withOpacity(1.0);
    canvas.drawPath(path_4,paint_4_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
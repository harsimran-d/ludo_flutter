import 'package:flutter/material.dart';

class WinArea extends StatelessWidget {
  const WinArea({super.key, required this.boxWidth});
  final double boxWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: SizedBox(
          height: boxWidth * 3,
          width: boxWidth * 3,
          child: CustomPaint(
            painter: TrianglePainter(
              topTriangleColor: const Color(0xFF479D52),
              bottomTriangleColor: Colors.blue,
              leftTriangleColor: Colors.red,
              rightTriangleColor: const Color.fromARGB(255, 255, 216, 21),
              borderColor: Colors.black,
              borderWidth: 1,
            ),
          ),
        ),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color topTriangleColor;
  final Color bottomTriangleColor;
  final Color leftTriangleColor;
  final Color rightTriangleColor;
  final Color borderColor;
  final double borderWidth;

  TrianglePainter({
    required this.topTriangleColor,
    required this.bottomTriangleColor,
    required this.leftTriangleColor,
    required this.rightTriangleColor,
    required this.borderColor,
    required this.borderWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final topPaint = Paint()..color = topTriangleColor;
    final bottomPaint = Paint()..color = bottomTriangleColor;
    final leftPaint = Paint()..color = leftTriangleColor;
    final rightPaint = Paint()..color = rightTriangleColor;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    Path topTriangle = Path()
      ..moveTo(size.width / 2, size.width / 2)
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(topTriangle, topPaint);

    Path bottomTriangle = Path()
      ..moveTo(size.width / 2, size.height / 2)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(bottomTriangle, bottomPaint);

    Path leftTriangle = Path()
      ..moveTo(size.width / 2, size.height / 2)
      ..lineTo(0, 0)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(leftTriangle, leftPaint);

    Path rightTriangle = Path()
      ..moveTo(size.width / 2, size.height / 2)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(rightTriangle, rightPaint);

    canvas.drawLine(Offset.zero, Offset(size.width, size.height), borderPaint);
    canvas.drawLine(Offset(0, size.height), Offset(size.width, 0), borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

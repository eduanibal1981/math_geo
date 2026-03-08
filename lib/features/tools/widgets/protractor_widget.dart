import 'dart:math';
import 'package:flutter/material.dart';

class ProtractorWidget extends StatelessWidget {
  final double radiusPix;

  const ProtractorWidget({Key? key, this.radiusPix = 150}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radiusPix * 2,
      height: radiusPix,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: CustomPaint(
        painter: _ProtractorPainter(),
      ),
    );
  }
}

class _ProtractorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.height;
    final Offset center = Offset(size.width / 2, size.height);

    final bgPaint = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..style = PaintingStyle.fill;
    
    final borderPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(0, size.height)
      ..arcTo(
          Rect.fromCircle(center: center, radius: radius),
          pi, pi, true)
      ..lineTo(0, size.height);

    canvas.drawPath(path, bgPaint);
    canvas.drawPath(path, borderPaint);

    // Inner semi-circle
    final innerRadius = radius * 0.9;
    canvas.drawArc(
        Rect.fromCircle(center: center, radius: innerRadius),
        pi, pi, false, borderPaint);

    final linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1;

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    for (int i = 0; i <= 180; i += 1) {
      double angle = pi + (i * pi / 180);
      double lineLength = (i % 10 == 0) ? 15 : ((i % 5 == 0) ? 10 : 5);

      Offset outerPoint = Offset(
        center.dx + innerRadius * cos(angle),
        center.dy + innerRadius * sin(angle),
      );
      Offset innerPoint = Offset(
        center.dx + (innerRadius - lineLength) * cos(angle),
        center.dy + (innerRadius - lineLength) * sin(angle),
      );

      canvas.drawLine(outerPoint, innerPoint, linePaint);

      if (i % 10 == 0) {
        textPainter.text = TextSpan(
          text: i.toString(),
          style: const TextStyle(color: Colors.black, fontSize: 8),
        );
        textPainter.layout();

        double textRadius = innerRadius - 25;
        Offset textCenter = Offset(
          center.dx + textRadius * cos(angle),
          center.dy + textRadius * sin(angle),
        );

        canvas.save();
        canvas.translate(textCenter.dx, textCenter.dy);
        canvas.rotate(angle + pi / 2); // Rotate text so it's readable along arc
        textPainter.paint(canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));
        canvas.restore();
      }
    }
    
    // Base lines and center mark
    canvas.drawLine(Offset(size.width / 2 - 20, size.height), Offset(size.width / 2 + 20, size.height), linePaint);
    canvas.drawLine(Offset(size.width / 2, size.height - 20), Offset(size.width / 2, size.height), linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

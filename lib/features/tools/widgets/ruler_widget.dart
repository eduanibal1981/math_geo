import 'package:flutter/material.dart';

class RulerWidget extends StatelessWidget {
  final double lengthPixels;

  const RulerWidget({Key? key, this.lengthPixels = 300}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: lengthPixels,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: CustomPaint(
        painter: _RulerPainter(),
      ),
    );
  }
}

class _RulerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1;

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    int maxCm = 15; // Assuming fixed simple scale
    double cmPixelStep = size.width / maxCm;

    for (int i = 0; i <= maxCm; i++) {
      double x = i * cmPixelStep;
      // Draw CM line
      canvas.drawLine(Offset(x, 0), Offset(x, 20), paint);
      
      // Draw text
      textPainter.text = TextSpan(
        text: i.toString(),
        style: const TextStyle(color: Colors.black, fontSize: 10),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, 22),
      );

      // Draw MM lines
      if (i < maxCm) {
        double mmStep = cmPixelStep / 10;
        for (int j = 1; j < 10; j++) {
          double mmX = x + j * mmStep;
          double lineLength = (j == 5) ? 15 : 10;
          canvas.drawLine(Offset(mmX, 0), Offset(mmX, lineLength), paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

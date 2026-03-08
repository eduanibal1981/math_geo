import 'package:flutter/material.dart';

class SetSquareWidget extends StatelessWidget {
  final double sizePix;

  const SetSquareWidget({Key? key, this.sizePix = 200}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizePix,
      height: sizePix,
      child: CustomPaint(
        painter: _SetSquarePainter(),
      ),
    );
  }
}

class _SetSquarePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Path outerPath = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..close();

    final Path innerPath = Path()
      ..moveTo(20, 60)
      ..lineTo(20, size.height - 20)
      ..lineTo(size.width - 60, size.height - 20)
      ..close();

    final Path shapePath = Path.combine(
      PathOperation.difference,
      outerPath,
      innerPath,
    );

    final paintBg = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..style = PaintingStyle.fill;
    
    final borderPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    canvas.drawPath(shapePath, paintBg);
    
    canvas.drawPath(outerPath, borderPaint);
    canvas.drawPath(innerPath, borderPaint);

    final linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1;

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    // Marks along the left edge (y-axis)
    int maxCm = 10;
    double pixelPerCm = size.height / maxCm;
    
    for (int i = 0; i <= maxCm; i++) {
       double y = size.height - (i * pixelPerCm);
       canvas.drawLine(Offset(0, y), Offset(10, y), linePaint);
       
       if (i > 0 && i < maxCm) {
          textPainter.text = TextSpan(
             text: i.toString(),
             style: const TextStyle(color: Colors.black, fontSize: 8),
          );
          textPainter.layout();
          textPainter.paint(canvas, Offset(12, y - textPainter.height / 2));
       }

       // mm lines
       if (i < maxCm) {
          double mmStep = pixelPerCm / 10;
          for (int j = 1; j < 10; j++) {
            double mmY = y - (j * mmStep);
            double length = (j == 5) ? 7 : 4;
            canvas.drawLine(Offset(0, mmY), Offset(length, mmY), linePaint);
          }
       }
    }

    // Marks along the bottom edge (x-axis)
    for (int i = 0; i <= maxCm; i++) {
       double x = i * pixelPerCm;
       canvas.drawLine(Offset(x, size.height), Offset(x, size.height - 10), linePaint);
       
       if (i > 0 && i < maxCm) {
          textPainter.text = TextSpan(
             text: i.toString(),
             style: const TextStyle(color: Colors.black, fontSize: 8),
          );
          textPainter.layout();
          textPainter.paint(canvas, Offset(x - textPainter.width / 2, size.height - 22));
       }

       // mm lines
       if (i < maxCm) {
          double mmStep = pixelPerCm / 10;
          for (int j = 1; j < 10; j++) {
            double mmX = x + (j * mmStep);
            double length = (j == 5) ? 7 : 4;
            canvas.drawLine(Offset(mmX, size.height), Offset(mmX, size.height - length), linePaint);
          }
       }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

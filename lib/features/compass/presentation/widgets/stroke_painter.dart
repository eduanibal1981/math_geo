import 'package:flutter/material.dart';
import '../../domain/entities/compass_state.dart';

class StrokePainter extends CustomPainter {
  final CompassState state;

  StrokePainter({required this.state});

  @override
  void paint(Canvas canvas, Size size) {
    // Draw all completed strokes
    for (final stroke in state.completedStrokes) {
      _paintStroke(canvas, stroke);
    }
    // Draw the currently active stroke
    if (state.currentStroke != null) {
      _paintStroke(canvas, state.currentStroke!);
    }
  }

  void _paintStroke(Canvas canvas, DrawnStroke stroke) {
    if (stroke.points.isEmpty) return;

    final paint = Paint()
      ..color = stroke.color
      ..strokeWidth = stroke.strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    if (stroke.points.length == 1) {
      // Draw a dot if there's only one point
      canvas.drawCircle(
        stroke.points.first,
        stroke.strokeWidth / 2,
        paint..style = PaintingStyle.fill,
      );
      return;
    }

    final path = Path();
    path.moveTo(stroke.points.first.dx, stroke.points.first.dy);
    for (int i = 1; i < stroke.points.length; i++) {
      path.lineTo(stroke.points[i].dx, stroke.points[i].dy);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant StrokePainter oldDelegate) {
    return oldDelegate.state != state;
  }
}

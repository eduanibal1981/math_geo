import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../domain/entities/compass_state.dart';

class CompassPainter extends CustomPainter {
  final CompassState state;

  CompassPainter({required this.state});

  @override
  void paint(Canvas canvas, Size size) {
    _drawStrokes(canvas);
    _drawCompass(canvas, size);
  }

  void _drawStrokes(Canvas canvas) {
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

  void _drawCompass(Canvas canvas, Size size) {
    final pinPoint = state.pinPoint;
    final radius = state.radius;
    final angle = state.angle;

    // The pencil point based on radius and angle
    final pencilPoint = pinPoint + Offset.fromDirection(angle, radius);

    // Calculate the top hinge point (forming an isosceles triangle with pin and pencil)
    // The length of the compass legs is fixed relative to screen size, scaled by user preference.
    final double baseLength = math.max(
      math.min(size.width, size.height) * 0.6,
      250.0,
    );
    final double legLength = baseLength * state.toolScale;
    // Safe-guard: leg length must be at least half the radius to form a triangle
    final double safeLegLength = math.max(legLength, radius / 2 + 10);

    // Distance from the midpoint between pin and pencil to the hinge
    final double midToHingeDist = math.sqrt(
      safeLegLength * safeLegLength - (radius / 2) * (radius / 2),
    );

    // The direction of the normal to the line between pin and pencil
    final double normalAngle = angle - math.pi / 2;

    // Midpoint between pin and pencil
    final Offset midpoint = (pinPoint + pencilPoint) / 2;

    // The hinge point
    final Offset hingePoint =
        midpoint + Offset.fromDirection(normalAngle, midToHingeDist);

    _drawRadiusLine(canvas, pinPoint, pencilPoint);
    _drawCompassLegs(canvas, pinPoint, pencilPoint, hingePoint);
    _drawInteractionAreas(canvas, pinPoint, pencilPoint, hingePoint);
  }

  void _drawRadiusLine(Canvas canvas, Offset p1, Offset p2) {
    final paint = Paint()
      ..color = Colors.grey.withAlpha(128)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Draw dashed line for radius
    final distance = (p2 - p1).distance;
    final direction = (p2 - p1).direction;
    const dashWidth = 5.0;
    const dashSpace = 5.0;
    double currentDistance = 0;

    final path = Path();
    while (currentDistance < distance) {
      final start = p1 + Offset.fromDirection(direction, currentDistance);
      path.moveTo(start.dx, start.dy);

      currentDistance += dashWidth;
      if (currentDistance > distance) currentDistance = distance;

      final end = p1 + Offset.fromDirection(direction, currentDistance);
      path.lineTo(end.dx, end.dy);

      currentDistance += dashSpace;
    }
    canvas.drawPath(path, paint);
  }

  void _drawCompassLegs(
    Canvas canvas,
    Offset pinPoint,
    Offset pencilPoint,
    Offset hingePoint,
  ) {
    final legPaint = Paint()
      ..color = Colors.blueGrey.shade800
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    final needlePaint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final pencilLegPaint = Paint()
      ..color = Colors.amber.shade700
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.square;

    final pencilTipPaint = Paint()
      ..color = Colors.black87
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    // Draw Pin Leg
    // Main body of the leg extending from hinge
    final pinBodyEnd = pinPoint + (hingePoint - pinPoint) * 0.2;
    canvas.drawLine(hingePoint, pinBodyEnd, legPaint);
    // Needle part
    canvas.drawLine(pinBodyEnd, pinPoint, needlePaint);

    // Draw Pencil Leg
    final pencilBodyEnd = pencilPoint + (hingePoint - pencilPoint) * 0.15;
    canvas.drawLine(hingePoint, pencilBodyEnd, legPaint);
    // Pencil body
    final pencilTipEnd = pencilPoint + (hingePoint - pencilPoint) * 0.05;
    canvas.drawLine(pencilBodyEnd, pencilTipEnd, pencilLegPaint);
    // Pencil tip
    canvas.drawLine(pencilTipEnd, pencilPoint, pencilTipPaint);

    // Draw Hinge Knob
    final knobPaint = Paint()..color = Colors.blueGrey.shade900;
    canvas.drawCircle(hingePoint, 12, knobPaint);
    // Hinge top handle
    final handleTop =
        hingePoint +
        Offset.fromDirection(
          (hingePoint - (pinPoint + pencilPoint) / 2).direction,
          30,
        );
    canvas.drawLine(hingePoint, handleTop, legPaint..strokeWidth = 8);
  }

  void _drawInteractionAreas(
    Canvas canvas,
    Offset pinPoint,
    Offset pencilPoint,
    Offset hingePoint,
  ) {
    // Optional: Draw invisible / subtle areas showing where to touch
    /* 
    final highlightPaint = Paint()
      ..color = Colors.teal.withOpacity(0.1)
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(pinPoint, 40, highlightPaint);
    canvas.drawCircle(pencilPoint, 40, highlightPaint);
    canvas.drawCircle(hingePoint, 50, highlightPaint);
    */
  }

  @override
  bool shouldRepaint(covariant CompassPainter oldDelegate) {
    return oldDelegate.state != state;
  }
}

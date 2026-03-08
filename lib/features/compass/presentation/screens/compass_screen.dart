import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/compass_controller.dart';
import '../widgets/compass_painter.dart';
import '../../domain/entities/compass_state.dart';

enum DragTarget { none, pin, pencil, hinge }

class CompassScreen extends ConsumerStatefulWidget {
  const CompassScreen({super.key});

  @override
  ConsumerState<CompassScreen> createState() => _CompassScreenState();
}

class _CompassScreenState extends ConsumerState<CompassScreen> {
  DragTarget _currentDragTarget = DragTarget.none;

  @override
  Widget build(BuildContext context) {
    final compassState = ref.watch(compassControllerProvider);
    final Size size = MediaQuery.of(context).size;

    // Define standard scaling logic: 45% of shortest screen dimension is always 20cm
    final double pixelsPer20Cm = math.max(
      math.min(size.width, size.height) * 0.45,
      150.0,
    );
    final double pixelsPerCm = pixelsPer20Cm / 20.0;
    final double radiusInCm = compassState.radius / pixelsPerCm;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pair of Compasses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.undo),
            tooltip: 'Undo',
            onPressed: compassState.completedStrokes.isNotEmpty
                ? () {
                    ref.read(compassControllerProvider.notifier).undo();
                  }
                : null,
          ),
          IconButton(
            icon: const Icon(Icons.redo),
            tooltip: 'Redo',
            onPressed: compassState.undoneStrokes.isNotEmpty
                ? () {
                    ref.read(compassControllerProvider.notifier).redo();
                  }
                : null,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Clear Drawing',
            onPressed: () {
              ref.read(compassControllerProvider.notifier).clearPaper();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // The interactive drawing area
          Positioned.fill(
            child: GestureDetector(
              onPanStart: (details) => _onPanStart(details, compassState),
              onPanUpdate: _onPanUpdate,
              onPanEnd: _onPanEnd,
              child: CustomPaint(
                painter: CompassPainter(state: compassState),
                size: Size.infinite,
              ),
            ),
          ),

          // Side panel showing the radius length and tool size scale
          Positioned(
            bottom: 24,
            left: 24,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Radius Length',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${radiusInCm.toStringAsFixed(1)} cm',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Pen Color',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children:
                          [
                            Colors.black,
                            Colors.red,
                            Colors.blue,
                            Colors.green,
                            Colors.orange,
                            Colors.purple,
                          ].map((color) {
                            return GestureDetector(
                              onTap: () {
                                ref
                                    .read(compassControllerProvider.notifier)
                                    .updatePenColor(color);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: compassState.penColor == color
                                        ? Colors.black
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Tool Size',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.compress,
                          size: 16,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 150,
                          child: Slider(
                            value: compassState.toolScale,
                            min: 0.5,
                            max: 1.0,
                            divisions: 2,
                            label: '${(compassState.toolScale * 100).toInt()}%',
                            onChanged: (value) {
                              final double maxCm = value * 40.0;
                              final double minCm = value == 0.75 ? 1.0 : 0.5;
                              final double pixelsPer20Cm = math.max(
                                math.min(size.width, size.height) * 0.45,
                                150.0,
                              );
                              final double pixelsPerCm = pixelsPer20Cm / 20.0;
                              ref
                                  .read(compassControllerProvider.notifier)
                                  .updateToolScale(
                                    value,
                                    minCm * pixelsPerCm,
                                    maxCm * pixelsPerCm,
                                  );
                            },
                          ),
                        ),
                        const Icon(Icons.expand, size: 16, color: Colors.grey),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onPanStart(DragStartDetails details, CompassState compassState) {
    final touchPoint = details.localPosition;
    final pinPoint = compassState.pinPoint;
    final radius = compassState.radius;
    final angle = compassState.angle;
    final pencilPoint = pinPoint + Offset.fromDirection(angle, radius);

    final Size size = MediaQuery.of(context).size;

    // Calculate hinge point to detect hinge touches
    // The length of the compass legs is fixed relative to screen size, scaled by user preference.
    final double baseLength = math.max(
      math.min(size.width, size.height) * 0.6,
      250.0,
    );
    final double legLength = baseLength * compassState.toolScale;
    final double safeLegLength = math.max(legLength, radius / 2 + 10);
    final double midToHingeDist = math.sqrt(
      safeLegLength * safeLegLength - (radius / 2) * (radius / 2),
    );
    final double normalAngle = angle - math.pi / 2;
    final Offset midpoint = (pinPoint + pencilPoint) / 2;
    final Offset hingePoint =
        midpoint + Offset.fromDirection(normalAngle, midToHingeDist);

    // Hit detection (in reverse order of drawing/z-index usually, but here we prioritize hinge)
    if ((touchPoint - hingePoint).distance < 60) {
      _currentDragTarget = DragTarget.hinge;
      ref.read(compassControllerProvider.notifier).startDrawing(touchPoint);
    } else if ((touchPoint - pencilPoint).distance < 50) {
      _currentDragTarget = DragTarget.pencil;
    } else if ((touchPoint - pinPoint).distance < 50) {
      _currentDragTarget = DragTarget.pin;
    } else {
      _currentDragTarget = DragTarget.none;
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    final compassState = ref.read(compassControllerProvider);
    final notifier = ref.read(compassControllerProvider.notifier);

    switch (_currentDragTarget) {
      case DragTarget.pin:
        notifier.updatePinPoint(details.localPosition);
        break;
      case DragTarget.pencil:
        final Size size = MediaQuery.of(context).size;
        final double pixelsPer20Cm = math.max(
          math.min(size.width, size.height) * 0.45,
          150.0,
        );
        final double pixelsPerCm = pixelsPer20Cm / 20.0;
        final double maxCm = compassState.toolScale * 40.0;
        final double minCm = compassState.toolScale == 0.75 ? 1.0 : 0.5;

        notifier.updateRadiusFromPencil(
          details.localPosition,
          minCm * pixelsPerCm,
          maxCm * pixelsPerCm,
        );
        break;
      case DragTarget.hinge:
        notifier.updateDrawing(details.localPosition);
        break;
      case DragTarget.none:
        break;
    }
  }

  void _onPanEnd(DragEndDetails details) {
    if (_currentDragTarget == DragTarget.hinge) {
      ref.read(compassControllerProvider.notifier).stopDrawing();
    }
    _currentDragTarget = DragTarget.none;
  }
}

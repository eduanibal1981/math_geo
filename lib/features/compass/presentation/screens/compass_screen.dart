import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/compass_controller.dart';
import '../widgets/compass_painter.dart';
import '../widgets/stroke_painter.dart';
import '../../domain/entities/compass_state.dart';

import '../../../tools/widgets/draggable_rotatable_tool.dart';
import '../../../tools/widgets/ruler_widget.dart';
import '../../../tools/widgets/protractor_widget.dart';
import '../../../tools/widgets/set_square_widget.dart';

enum DragTarget { none, pin, pencil, hinge }

class ToolItem {
  final String id;
  final Widget child;

  ToolItem(this.id, this.child);
}

class CompassScreen extends ConsumerStatefulWidget {
  const CompassScreen({super.key});

  @override
  ConsumerState<CompassScreen> createState() => _CompassScreenState();
}

class _CompassScreenState extends ConsumerState<CompassScreen> {
  DragTarget _currentDragTarget = DragTarget.none;
  final List<ToolItem> _activeTools = [];
  bool _isPanelExpanded = true;

  void _addTool(Widget widget) {
    setState(() {
      final id = DateTime.now().millisecondsSinceEpoch.toString();
      _activeTools.add(ToolItem(id, widget));
    });
    ref.read(compassControllerProvider.notifier).disableAllDrawingModes();
  }

  void _removeTool(String id) {
    setState(() {
      _activeTools.removeWhere((t) => t.id == id);
    });
  }

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
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
        title: const Text('Pair of Compasses'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.handyman),
            tooltip: 'Add Math Tools',
            onSelected: (value) {
              if (value == 'ruler') {
                _addTool(const RulerWidget());
              } else if (value == 'protractor') {
                _addTool(const ProtractorWidget());
              } else if (value == 'setsquare') {
                _addTool(const SetSquareWidget());
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'ruler',
                child: Text('Add Ruler'),
              ),
              const PopupMenuItem(
                value: 'protractor',
                child: Text('Add Protractor'),
              ),
              const PopupMenuItem(
                value: 'setsquare',
                child: Text('Add Set Square'),
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              compassState.isPencilMode ? Icons.edit : Icons.edit_off,
              color: compassState.isPencilMode ? Colors.amber : Colors.white,
            ),
            tooltip: compassState.isPencilMode ? 'Disable Pencil' : 'Enable Pencil',
            onPressed: () {
              ref.read(compassControllerProvider.notifier).togglePencilMode();
            },
          ),
          IconButton(
            icon: Icon(
              compassState.isLineMode ? Icons.straighten : Icons.horizontal_rule,
              color: compassState.isLineMode ? Colors.amber : Colors.white,
            ),
            tooltip: compassState.isLineMode ? 'Disable Straight Line' : 'Enable Straight Line',
            onPressed: () {
              ref.read(compassControllerProvider.notifier).toggleLineMode();
            },
          ),
          IconButton(
            icon: Icon(
              compassState.isFreeLineMode ? Icons.timeline : Icons.show_chart,
              color: compassState.isFreeLineMode ? Colors.amber : Colors.white,
            ),
            tooltip: compassState.isFreeLineMode ? 'Disable Free Angle Line' : 'Enable Free Angle Line',
            onPressed: () {
              ref.read(compassControllerProvider.notifier).toggleFreeLineMode();
            },
          ),
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

          // Add active draggable tools overlay on top of compass area
          ..._activeTools.map((t) => DraggableRotatableTool(
            key: ValueKey(t.id),
            child: t.child,
            onClose: () => _removeTool(t.id),
          )),
          
          // Draw the strokes on top of tools
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: StrokePainter(state: compassState),
                size: Size.infinite,
              ),
            ),
          ),
          
          if (compassState.isPencilMode)
            Positioned.fill(
              child: GestureDetector(
                onPanStart: (details) {
                   ref.read(compassControllerProvider.notifier).startFreehandDrawing(details.localPosition);
                },
                onPanUpdate: (details) {
                   ref.read(compassControllerProvider.notifier).updateFreehandDrawing(details.localPosition);
                },
                onPanEnd: (details) {
                   ref.read(compassControllerProvider.notifier).stopFreehandDrawing();
                },
                child: Container(
                  color: Colors.transparent, // Capture all touches
                ),
              ),
            ),

          if (compassState.isLineMode)
            Positioned.fill(
              child: GestureDetector(
                onPanStart: (details) {
                   ref.read(compassControllerProvider.notifier).startLineDrawing(details.localPosition);
                },
                onPanUpdate: (details) {
                   ref.read(compassControllerProvider.notifier).updateLineDrawing(details.localPosition);
                },
                onPanEnd: (details) {
                   ref.read(compassControllerProvider.notifier).stopLineDrawing();
                },
                child: Container(
                  color: Colors.transparent, // Capture all touches
                ),
              ),
            ),

          if (compassState.isFreeLineMode)
            Positioned.fill(
              child: GestureDetector(
                onPanStart: (details) {
                   ref.read(compassControllerProvider.notifier).startFreeLineDrawing(details.localPosition);
                },
                onPanUpdate: (details) {
                   ref.read(compassControllerProvider.notifier).updateFreeLineDrawing(details.localPosition);
                },
                onPanEnd: (details) {
                   ref.read(compassControllerProvider.notifier).stopFreeLineDrawing();
                },
                child: Container(
                  color: Colors.transparent, // Capture all touches
                ),
              ),
            ),

          // Side panel showing the radius length and tool size scale
          Positioned(
            bottom: 24,
            left: 24,
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Tools & Settings',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 32),
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: Icon(
                              _isPanelExpanded
                                  ? Icons.keyboard_arrow_down
                                  : Icons.keyboard_arrow_up,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPanelExpanded = !_isPanelExpanded;
                              });
                            },
                          ),
                        ],
                      ),
                      if (_isPanelExpanded) ...[
                        const SizedBox(height: 12),
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
                      'Pen Thickness',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [2.0, 4.0, 6.0].map((width) {
                        return GestureDetector(
                          onTap: () {
                            ref
                                .read(compassControllerProvider.notifier)
                                .updatePenWidth(width);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 16),
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: compassState.penWidth == width
                                    ? Colors.black
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Container(
                                width: width * 3, // Visual scaling
                                height: width * 3,
                                decoration: BoxDecoration(
                                  color: compassState.penColor,
                                  shape: BoxShape.circle,
                                ),
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
                ],
              ),
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

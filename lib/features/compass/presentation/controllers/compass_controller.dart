import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/compass_state.dart';

part 'compass_controller.g.dart';

@riverpod
class CompassController extends _$CompassController {
  @override
  CompassState build() {
    return const CompassState(
      pinPoint: Offset(150, 400),
      radius: 120,
      angle: 0.0,
    );
  }

  /// Sets the absolute position of the pin (the needle).
  void updatePinPoint(Offset newPinPoint) {
    state = state.copyWith(pinPoint: newPinPoint);
  }

  /// Moves the pencil point while keeping the pin fixed.
  /// This updates both the radius and the angle.
  void updateRadiusFromPencil(
    Offset pencilPoint,
    double minRadius,
    double maxRadius,
  ) {
    final difference = pencilPoint - state.pinPoint;
    // Limit opening based on UI screen size constraints
    final newRadius = difference.distance.clamp(minRadius, maxRadius);
    final newAngle = difference.direction;

    state = state.copyWith(radius: newRadius, angle: newAngle);
  }

  /// Starts a drawing stroke at the given drag position.
  /// The drag position determines the initial angle for the stroke.
  void startDrawing(Offset startAnglePoint) {
    final newAngle = (startAnglePoint - state.pinPoint).direction;
    final startPencilPoint =
        state.pinPoint + Offset.fromDirection(newAngle, state.radius);

    state = state.copyWith(
      isDrawing: true,
      angle: newAngle,
      currentStroke: DrawnStroke(
        points: [startPencilPoint],
        color: state.penColor,
      ),
    );
  }

  /// Updates the user's preferred tool scale and clamps current radius.
  void updateToolScale(double scale, double minRadius, double maxRadius) {
    state = state.copyWith(
      toolScale: scale,
      radius: state.radius.clamp(minRadius, maxRadius),
    );
  }

  /// Updates the currently selected pen color.
  void updatePenColor(Color color) {
    state = state.copyWith(penColor: color);
  }

  /// Updates the current drawing stroke as the user drags.
  void updateDrawing(Offset newAnglePoint) {
    if (!state.isDrawing || state.currentStroke == null) return;

    final newAngle = (newAnglePoint - state.pinPoint).direction;
    final newPencilPoint =
        state.pinPoint + Offset.fromDirection(newAngle, state.radius);

    final points = List<Offset>.from(state.currentStroke!.points)
      ..add(newPencilPoint);

    state = state.copyWith(
      angle: newAngle,
      currentStroke: state.currentStroke!.copyWith(points: points),
    );
  }

  /// Completes the drawing and saves it to the completed strokes.
  void stopDrawing() {
    if (!state.isDrawing || state.currentStroke == null) return;

    final strokes = List<DrawnStroke>.from(state.completedStrokes)
      ..add(state.currentStroke!);

    state = state.copyWith(
      isDrawing: false,
      completedStrokes: strokes,
      undoneStrokes: [], // clear redo history when a new action is performed
      currentStroke: null,
    );
  }

  /// Undoes the last completed stroke.
  void undo() {
    if (state.completedStrokes.isEmpty) return;

    final completed = List<DrawnStroke>.from(state.completedStrokes);
    final lastStroke = completed.removeLast();

    final undone = List<DrawnStroke>.from(state.undoneStrokes)..add(lastStroke);

    state = state.copyWith(completedStrokes: completed, undoneStrokes: undone);
  }

  /// Redoes the last undone stroke.
  void redo() {
    if (state.undoneStrokes.isEmpty) return;

    final undone = List<DrawnStroke>.from(state.undoneStrokes);
    final lastUndone = undone.removeLast();

    final completed = List<DrawnStroke>.from(state.completedStrokes)
      ..add(lastUndone);

    state = state.copyWith(completedStrokes: completed, undoneStrokes: undone);
  }

  /// Clears all the drawings on the paper.
  void clearPaper() {
    state = state.copyWith(
      completedStrokes: [],
      undoneStrokes: [],
      currentStroke: null,
    );
  }
}

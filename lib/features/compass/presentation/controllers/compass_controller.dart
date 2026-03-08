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
        strokeWidth: state.penWidth,
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

  /// Updates the currently selected pen width.
  void updatePenWidth(double width) {
    state = state.copyWith(penWidth: width);
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

  /// Toggles the visibility of the compass tool.
  void toggleCompassVisible() {
    state = state.copyWith(
      isCompassVisible: !state.isCompassVisible,
      isPencilMode: false,
      isLineMode: false,
      isFreeLineMode: false,
    );
  }

  /// Toggles between pencil (freehand) mode and compass mode.
  void togglePencilMode() {
    state = state.copyWith(
      isPencilMode: !state.isPencilMode,
      isLineMode: false,
      isFreeLineMode: false,
    );
  }

  /// Toggles between straight line mode and compass mode.
  void toggleLineMode() {
    state = state.copyWith(
      isLineMode: !state.isLineMode,
      isPencilMode: false,
      isFreeLineMode: false,
    );
  }

  /// Toggles between free angle line mode and compass mode.
  void toggleFreeLineMode() {
    state = state.copyWith(
      isFreeLineMode: !state.isFreeLineMode,
      isLineMode: false,
      isPencilMode: false,
    );
  }

  /// Disables all drawing modes so tools can be manipulated.
  void disableAllDrawingModes() {
    state = state.copyWith(
      isPencilMode: false,
      isLineMode: false,
      isFreeLineMode: false,
    );
  }

  /// Starts a freehand pencil stroke.
  void startFreehandDrawing(Offset point) {
    state = state.copyWith(
      isDrawing: true,
      currentStroke: DrawnStroke(
        points: [point],
        color: state.penColor,
        strokeWidth: state.penWidth,
      ),
    );
  }

  /// Updates the freehand pencil stroke.
  void updateFreehandDrawing(Offset point) {
    if (!state.isDrawing || state.currentStroke == null) return;

    final points = List<Offset>.from(state.currentStroke!.points)..add(point);

    state = state.copyWith(
      currentStroke: state.currentStroke!.copyWith(points: points),
    );
  }

  /// Completes the freehand pencil stroke (uses the same logic as stopDrawing).
  void stopFreehandDrawing() {
    stopDrawing();
  }

  /// Starts a straight line stroke.
  void startLineDrawing(Offset point) {
    state = state.copyWith(
      isDrawing: true,
      currentStroke: DrawnStroke(
        points: [point, point],
        color: state.penColor,
        strokeWidth: state.penWidth,
      ),
    );
  }

  /// Updates the straight line stroke, snapping to horizontal or vertical.
  void updateLineDrawing(Offset point) {
    if (!state.isDrawing || state.currentStroke == null || state.currentStroke!.points.isEmpty) return;

    final startPoint = state.currentStroke!.points.first;
    
    final dx = (point.dx - startPoint.dx).abs();
    final dy = (point.dy - startPoint.dy).abs();

    Offset endPoint;
    if (dx > dy) {
      // Horizontal line
      endPoint = Offset(point.dx, startPoint.dy);
    } else {
      // Vertical line
      endPoint = Offset(startPoint.dx, point.dy);
    }

    state = state.copyWith(
      currentStroke: state.currentStroke!.copyWith(points: [startPoint, endPoint]),
    );
  }

  /// Completes the straight line stroke.
  void stopLineDrawing() {
    stopDrawing();
  }

  /// Starts a free angle straight line stroke.
  void startFreeLineDrawing(Offset point) {
    state = state.copyWith(
      isDrawing: true,
      currentStroke: DrawnStroke(
        points: [point, point],
        color: state.penColor,
        strokeWidth: state.penWidth,
      ),
    );
  }

  /// Updates the free angle straight line stroke.
  void updateFreeLineDrawing(Offset point) {
    if (!state.isDrawing || state.currentStroke == null || state.currentStroke!.points.isEmpty) return;

    final startPoint = state.currentStroke!.points.first;

    state = state.copyWith(
      currentStroke: state.currentStroke!.copyWith(points: [startPoint, point]),
    );
  }

  /// Completes the free angle straight line stroke.
  void stopFreeLineDrawing() {
    stopDrawing();
  }
}

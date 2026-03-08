import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'compass_state.freezed.dart';

/// Represents a continuous path drawn with a specific color and stroke width.
@freezed
class DrawnStroke with _$DrawnStroke {
  const factory DrawnStroke({
    required List<Offset> points,
    @Default(Colors.black) Color color,
    @Default(2.0) double strokeWidth,
  }) = _DrawnStroke;
}

@freezed
class CompassState with _$CompassState {
  const factory CompassState({
    /// The location of the pin (needle).
    required Offset pinPoint,

    /// The distance from the pin to the pencil tip.
    required double radius,

    /// An explicit user-defined multiplier for the drawn compass size.
    @Default(0.5) double toolScale,

    /// The current rotation angle of the compass around the pin (in radians).
    required double angle,

    /// True if the compass is currently drawing on the screen.
    @Default(false) bool isDrawing,

    /// All previously completed strokes.
    @Default([]) List<DrawnStroke> completedStrokes,

    /// Strokes that have been undone and can be redone.
    @Default([]) List<DrawnStroke> undoneStrokes,

    /// The stroke currently being drawn.
    DrawnStroke? currentStroke,

    /// The currently selected color for the drawing pen.
    @Default(Colors.black) Color penColor,

    /// The currently selected thickness for the drawing pen.
    @Default(2.0) double penWidth,

    /// Whether the app is in pencil freehand drawing mode.
    @Default(false) bool isPencilMode,

    /// Whether the app is in straight line drawing mode (horizontal/vertical).
    @Default(false) bool isLineMode,

    /// Whether the app is in free angle straight line drawing mode.
    @Default(false) bool isFreeLineMode,

    /// Whether the compass tool itself is visible on the canvas.
    @Default(false) bool isCompassVisible,
  }) = _CompassState;
}

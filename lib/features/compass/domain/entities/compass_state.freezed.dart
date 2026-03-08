// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'compass_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DrawnStroke {
  List<Offset> get points => throw _privateConstructorUsedError;
  Color get color => throw _privateConstructorUsedError;
  double get strokeWidth => throw _privateConstructorUsedError;

  /// Create a copy of DrawnStroke
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DrawnStrokeCopyWith<DrawnStroke> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DrawnStrokeCopyWith<$Res> {
  factory $DrawnStrokeCopyWith(
    DrawnStroke value,
    $Res Function(DrawnStroke) then,
  ) = _$DrawnStrokeCopyWithImpl<$Res, DrawnStroke>;
  @useResult
  $Res call({List<Offset> points, Color color, double strokeWidth});
}

/// @nodoc
class _$DrawnStrokeCopyWithImpl<$Res, $Val extends DrawnStroke>
    implements $DrawnStrokeCopyWith<$Res> {
  _$DrawnStrokeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DrawnStroke
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? points = null,
    Object? color = null,
    Object? strokeWidth = null,
  }) {
    return _then(
      _value.copyWith(
            points: null == points
                ? _value.points
                : points // ignore: cast_nullable_to_non_nullable
                      as List<Offset>,
            color: null == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as Color,
            strokeWidth: null == strokeWidth
                ? _value.strokeWidth
                : strokeWidth // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DrawnStrokeImplCopyWith<$Res>
    implements $DrawnStrokeCopyWith<$Res> {
  factory _$$DrawnStrokeImplCopyWith(
    _$DrawnStrokeImpl value,
    $Res Function(_$DrawnStrokeImpl) then,
  ) = __$$DrawnStrokeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Offset> points, Color color, double strokeWidth});
}

/// @nodoc
class __$$DrawnStrokeImplCopyWithImpl<$Res>
    extends _$DrawnStrokeCopyWithImpl<$Res, _$DrawnStrokeImpl>
    implements _$$DrawnStrokeImplCopyWith<$Res> {
  __$$DrawnStrokeImplCopyWithImpl(
    _$DrawnStrokeImpl _value,
    $Res Function(_$DrawnStrokeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DrawnStroke
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? points = null,
    Object? color = null,
    Object? strokeWidth = null,
  }) {
    return _then(
      _$DrawnStrokeImpl(
        points: null == points
            ? _value._points
            : points // ignore: cast_nullable_to_non_nullable
                  as List<Offset>,
        color: null == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as Color,
        strokeWidth: null == strokeWidth
            ? _value.strokeWidth
            : strokeWidth // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$DrawnStrokeImpl implements _DrawnStroke {
  const _$DrawnStrokeImpl({
    required final List<Offset> points,
    this.color = Colors.black,
    this.strokeWidth = 2.0,
  }) : _points = points;

  final List<Offset> _points;
  @override
  List<Offset> get points {
    if (_points is EqualUnmodifiableListView) return _points;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_points);
  }

  @override
  @JsonKey()
  final Color color;
  @override
  @JsonKey()
  final double strokeWidth;

  @override
  String toString() {
    return 'DrawnStroke(points: $points, color: $color, strokeWidth: $strokeWidth)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DrawnStrokeImpl &&
            const DeepCollectionEquality().equals(other._points, _points) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.strokeWidth, strokeWidth) ||
                other.strokeWidth == strokeWidth));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_points),
    color,
    strokeWidth,
  );

  /// Create a copy of DrawnStroke
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DrawnStrokeImplCopyWith<_$DrawnStrokeImpl> get copyWith =>
      __$$DrawnStrokeImplCopyWithImpl<_$DrawnStrokeImpl>(this, _$identity);
}

abstract class _DrawnStroke implements DrawnStroke {
  const factory _DrawnStroke({
    required final List<Offset> points,
    final Color color,
    final double strokeWidth,
  }) = _$DrawnStrokeImpl;

  @override
  List<Offset> get points;
  @override
  Color get color;
  @override
  double get strokeWidth;

  /// Create a copy of DrawnStroke
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DrawnStrokeImplCopyWith<_$DrawnStrokeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CompassState {
  /// The location of the pin (needle).
  Offset get pinPoint => throw _privateConstructorUsedError;

  /// The distance from the pin to the pencil tip.
  double get radius => throw _privateConstructorUsedError;

  /// An explicit user-defined multiplier for the drawn compass size.
  double get toolScale => throw _privateConstructorUsedError;

  /// The current rotation angle of the compass around the pin (in radians).
  double get angle => throw _privateConstructorUsedError;

  /// True if the compass is currently drawing on the screen.
  bool get isDrawing => throw _privateConstructorUsedError;

  /// All previously completed strokes.
  List<DrawnStroke> get completedStrokes => throw _privateConstructorUsedError;

  /// Strokes that have been undone and can be redone.
  List<DrawnStroke> get undoneStrokes => throw _privateConstructorUsedError;

  /// The stroke currently being drawn.
  DrawnStroke? get currentStroke => throw _privateConstructorUsedError;

  /// The currently selected color for the drawing pen.
  Color get penColor => throw _privateConstructorUsedError;

  /// The currently selected thickness for the drawing pen.
  double get penWidth => throw _privateConstructorUsedError;

  /// Whether the app is in pencil freehand drawing mode.
  bool get isPencilMode => throw _privateConstructorUsedError;

  /// Whether the app is in straight line drawing mode (horizontal/vertical).
  bool get isLineMode => throw _privateConstructorUsedError;

  /// Whether the app is in free angle straight line drawing mode.
  bool get isFreeLineMode => throw _privateConstructorUsedError;

  /// Whether the compass tool itself is visible on the canvas.
  bool get isCompassVisible => throw _privateConstructorUsedError;

  /// Create a copy of CompassState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompassStateCopyWith<CompassState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompassStateCopyWith<$Res> {
  factory $CompassStateCopyWith(
    CompassState value,
    $Res Function(CompassState) then,
  ) = _$CompassStateCopyWithImpl<$Res, CompassState>;
  @useResult
  $Res call({
    Offset pinPoint,
    double radius,
    double toolScale,
    double angle,
    bool isDrawing,
    List<DrawnStroke> completedStrokes,
    List<DrawnStroke> undoneStrokes,
    DrawnStroke? currentStroke,
    Color penColor,
    double penWidth,
    bool isPencilMode,
    bool isLineMode,
    bool isFreeLineMode,
    bool isCompassVisible,
  });

  $DrawnStrokeCopyWith<$Res>? get currentStroke;
}

/// @nodoc
class _$CompassStateCopyWithImpl<$Res, $Val extends CompassState>
    implements $CompassStateCopyWith<$Res> {
  _$CompassStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CompassState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pinPoint = null,
    Object? radius = null,
    Object? toolScale = null,
    Object? angle = null,
    Object? isDrawing = null,
    Object? completedStrokes = null,
    Object? undoneStrokes = null,
    Object? currentStroke = freezed,
    Object? penColor = null,
    Object? penWidth = null,
    Object? isPencilMode = null,
    Object? isLineMode = null,
    Object? isFreeLineMode = null,
    Object? isCompassVisible = null,
  }) {
    return _then(
      _value.copyWith(
            pinPoint: null == pinPoint
                ? _value.pinPoint
                : pinPoint // ignore: cast_nullable_to_non_nullable
                      as Offset,
            radius: null == radius
                ? _value.radius
                : radius // ignore: cast_nullable_to_non_nullable
                      as double,
            toolScale: null == toolScale
                ? _value.toolScale
                : toolScale // ignore: cast_nullable_to_non_nullable
                      as double,
            angle: null == angle
                ? _value.angle
                : angle // ignore: cast_nullable_to_non_nullable
                      as double,
            isDrawing: null == isDrawing
                ? _value.isDrawing
                : isDrawing // ignore: cast_nullable_to_non_nullable
                      as bool,
            completedStrokes: null == completedStrokes
                ? _value.completedStrokes
                : completedStrokes // ignore: cast_nullable_to_non_nullable
                      as List<DrawnStroke>,
            undoneStrokes: null == undoneStrokes
                ? _value.undoneStrokes
                : undoneStrokes // ignore: cast_nullable_to_non_nullable
                      as List<DrawnStroke>,
            currentStroke: freezed == currentStroke
                ? _value.currentStroke
                : currentStroke // ignore: cast_nullable_to_non_nullable
                      as DrawnStroke?,
            penColor: null == penColor
                ? _value.penColor
                : penColor // ignore: cast_nullable_to_non_nullable
                      as Color,
            penWidth: null == penWidth
                ? _value.penWidth
                : penWidth // ignore: cast_nullable_to_non_nullable
                      as double,
            isPencilMode: null == isPencilMode
                ? _value.isPencilMode
                : isPencilMode // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLineMode: null == isLineMode
                ? _value.isLineMode
                : isLineMode // ignore: cast_nullable_to_non_nullable
                      as bool,
            isFreeLineMode: null == isFreeLineMode
                ? _value.isFreeLineMode
                : isFreeLineMode // ignore: cast_nullable_to_non_nullable
                      as bool,
            isCompassVisible: null == isCompassVisible
                ? _value.isCompassVisible
                : isCompassVisible // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of CompassState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DrawnStrokeCopyWith<$Res>? get currentStroke {
    if (_value.currentStroke == null) {
      return null;
    }

    return $DrawnStrokeCopyWith<$Res>(_value.currentStroke!, (value) {
      return _then(_value.copyWith(currentStroke: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CompassStateImplCopyWith<$Res>
    implements $CompassStateCopyWith<$Res> {
  factory _$$CompassStateImplCopyWith(
    _$CompassStateImpl value,
    $Res Function(_$CompassStateImpl) then,
  ) = __$$CompassStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Offset pinPoint,
    double radius,
    double toolScale,
    double angle,
    bool isDrawing,
    List<DrawnStroke> completedStrokes,
    List<DrawnStroke> undoneStrokes,
    DrawnStroke? currentStroke,
    Color penColor,
    double penWidth,
    bool isPencilMode,
    bool isLineMode,
    bool isFreeLineMode,
    bool isCompassVisible,
  });

  @override
  $DrawnStrokeCopyWith<$Res>? get currentStroke;
}

/// @nodoc
class __$$CompassStateImplCopyWithImpl<$Res>
    extends _$CompassStateCopyWithImpl<$Res, _$CompassStateImpl>
    implements _$$CompassStateImplCopyWith<$Res> {
  __$$CompassStateImplCopyWithImpl(
    _$CompassStateImpl _value,
    $Res Function(_$CompassStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CompassState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pinPoint = null,
    Object? radius = null,
    Object? toolScale = null,
    Object? angle = null,
    Object? isDrawing = null,
    Object? completedStrokes = null,
    Object? undoneStrokes = null,
    Object? currentStroke = freezed,
    Object? penColor = null,
    Object? penWidth = null,
    Object? isPencilMode = null,
    Object? isLineMode = null,
    Object? isFreeLineMode = null,
    Object? isCompassVisible = null,
  }) {
    return _then(
      _$CompassStateImpl(
        pinPoint: null == pinPoint
            ? _value.pinPoint
            : pinPoint // ignore: cast_nullable_to_non_nullable
                  as Offset,
        radius: null == radius
            ? _value.radius
            : radius // ignore: cast_nullable_to_non_nullable
                  as double,
        toolScale: null == toolScale
            ? _value.toolScale
            : toolScale // ignore: cast_nullable_to_non_nullable
                  as double,
        angle: null == angle
            ? _value.angle
            : angle // ignore: cast_nullable_to_non_nullable
                  as double,
        isDrawing: null == isDrawing
            ? _value.isDrawing
            : isDrawing // ignore: cast_nullable_to_non_nullable
                  as bool,
        completedStrokes: null == completedStrokes
            ? _value._completedStrokes
            : completedStrokes // ignore: cast_nullable_to_non_nullable
                  as List<DrawnStroke>,
        undoneStrokes: null == undoneStrokes
            ? _value._undoneStrokes
            : undoneStrokes // ignore: cast_nullable_to_non_nullable
                  as List<DrawnStroke>,
        currentStroke: freezed == currentStroke
            ? _value.currentStroke
            : currentStroke // ignore: cast_nullable_to_non_nullable
                  as DrawnStroke?,
        penColor: null == penColor
            ? _value.penColor
            : penColor // ignore: cast_nullable_to_non_nullable
                  as Color,
        penWidth: null == penWidth
            ? _value.penWidth
            : penWidth // ignore: cast_nullable_to_non_nullable
                  as double,
        isPencilMode: null == isPencilMode
            ? _value.isPencilMode
            : isPencilMode // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLineMode: null == isLineMode
            ? _value.isLineMode
            : isLineMode // ignore: cast_nullable_to_non_nullable
                  as bool,
        isFreeLineMode: null == isFreeLineMode
            ? _value.isFreeLineMode
            : isFreeLineMode // ignore: cast_nullable_to_non_nullable
                  as bool,
        isCompassVisible: null == isCompassVisible
            ? _value.isCompassVisible
            : isCompassVisible // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$CompassStateImpl implements _CompassState {
  const _$CompassStateImpl({
    required this.pinPoint,
    required this.radius,
    this.toolScale = 0.5,
    required this.angle,
    this.isDrawing = false,
    final List<DrawnStroke> completedStrokes = const [],
    final List<DrawnStroke> undoneStrokes = const [],
    this.currentStroke,
    this.penColor = Colors.black,
    this.penWidth = 2.0,
    this.isPencilMode = false,
    this.isLineMode = false,
    this.isFreeLineMode = false,
    this.isCompassVisible = false,
  }) : _completedStrokes = completedStrokes,
       _undoneStrokes = undoneStrokes;

  /// The location of the pin (needle).
  @override
  final Offset pinPoint;

  /// The distance from the pin to the pencil tip.
  @override
  final double radius;

  /// An explicit user-defined multiplier for the drawn compass size.
  @override
  @JsonKey()
  final double toolScale;

  /// The current rotation angle of the compass around the pin (in radians).
  @override
  final double angle;

  /// True if the compass is currently drawing on the screen.
  @override
  @JsonKey()
  final bool isDrawing;

  /// All previously completed strokes.
  final List<DrawnStroke> _completedStrokes;

  /// All previously completed strokes.
  @override
  @JsonKey()
  List<DrawnStroke> get completedStrokes {
    if (_completedStrokes is EqualUnmodifiableListView)
      return _completedStrokes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_completedStrokes);
  }

  /// Strokes that have been undone and can be redone.
  final List<DrawnStroke> _undoneStrokes;

  /// Strokes that have been undone and can be redone.
  @override
  @JsonKey()
  List<DrawnStroke> get undoneStrokes {
    if (_undoneStrokes is EqualUnmodifiableListView) return _undoneStrokes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_undoneStrokes);
  }

  /// The stroke currently being drawn.
  @override
  final DrawnStroke? currentStroke;

  /// The currently selected color for the drawing pen.
  @override
  @JsonKey()
  final Color penColor;

  /// The currently selected thickness for the drawing pen.
  @override
  @JsonKey()
  final double penWidth;

  /// Whether the app is in pencil freehand drawing mode.
  @override
  @JsonKey()
  final bool isPencilMode;

  /// Whether the app is in straight line drawing mode (horizontal/vertical).
  @override
  @JsonKey()
  final bool isLineMode;

  /// Whether the app is in free angle straight line drawing mode.
  @override
  @JsonKey()
  final bool isFreeLineMode;

  /// Whether the compass tool itself is visible on the canvas.
  @override
  @JsonKey()
  final bool isCompassVisible;

  @override
  String toString() {
    return 'CompassState(pinPoint: $pinPoint, radius: $radius, toolScale: $toolScale, angle: $angle, isDrawing: $isDrawing, completedStrokes: $completedStrokes, undoneStrokes: $undoneStrokes, currentStroke: $currentStroke, penColor: $penColor, penWidth: $penWidth, isPencilMode: $isPencilMode, isLineMode: $isLineMode, isFreeLineMode: $isFreeLineMode, isCompassVisible: $isCompassVisible)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompassStateImpl &&
            (identical(other.pinPoint, pinPoint) ||
                other.pinPoint == pinPoint) &&
            (identical(other.radius, radius) || other.radius == radius) &&
            (identical(other.toolScale, toolScale) ||
                other.toolScale == toolScale) &&
            (identical(other.angle, angle) || other.angle == angle) &&
            (identical(other.isDrawing, isDrawing) ||
                other.isDrawing == isDrawing) &&
            const DeepCollectionEquality().equals(
              other._completedStrokes,
              _completedStrokes,
            ) &&
            const DeepCollectionEquality().equals(
              other._undoneStrokes,
              _undoneStrokes,
            ) &&
            (identical(other.currentStroke, currentStroke) ||
                other.currentStroke == currentStroke) &&
            (identical(other.penColor, penColor) ||
                other.penColor == penColor) &&
            (identical(other.penWidth, penWidth) ||
                other.penWidth == penWidth) &&
            (identical(other.isPencilMode, isPencilMode) ||
                other.isPencilMode == isPencilMode) &&
            (identical(other.isLineMode, isLineMode) ||
                other.isLineMode == isLineMode) &&
            (identical(other.isFreeLineMode, isFreeLineMode) ||
                other.isFreeLineMode == isFreeLineMode) &&
            (identical(other.isCompassVisible, isCompassVisible) ||
                other.isCompassVisible == isCompassVisible));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    pinPoint,
    radius,
    toolScale,
    angle,
    isDrawing,
    const DeepCollectionEquality().hash(_completedStrokes),
    const DeepCollectionEquality().hash(_undoneStrokes),
    currentStroke,
    penColor,
    penWidth,
    isPencilMode,
    isLineMode,
    isFreeLineMode,
    isCompassVisible,
  );

  /// Create a copy of CompassState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompassStateImplCopyWith<_$CompassStateImpl> get copyWith =>
      __$$CompassStateImplCopyWithImpl<_$CompassStateImpl>(this, _$identity);
}

abstract class _CompassState implements CompassState {
  const factory _CompassState({
    required final Offset pinPoint,
    required final double radius,
    final double toolScale,
    required final double angle,
    final bool isDrawing,
    final List<DrawnStroke> completedStrokes,
    final List<DrawnStroke> undoneStrokes,
    final DrawnStroke? currentStroke,
    final Color penColor,
    final double penWidth,
    final bool isPencilMode,
    final bool isLineMode,
    final bool isFreeLineMode,
    final bool isCompassVisible,
  }) = _$CompassStateImpl;

  /// The location of the pin (needle).
  @override
  Offset get pinPoint;

  /// The distance from the pin to the pencil tip.
  @override
  double get radius;

  /// An explicit user-defined multiplier for the drawn compass size.
  @override
  double get toolScale;

  /// The current rotation angle of the compass around the pin (in radians).
  @override
  double get angle;

  /// True if the compass is currently drawing on the screen.
  @override
  bool get isDrawing;

  /// All previously completed strokes.
  @override
  List<DrawnStroke> get completedStrokes;

  /// Strokes that have been undone and can be redone.
  @override
  List<DrawnStroke> get undoneStrokes;

  /// The stroke currently being drawn.
  @override
  DrawnStroke? get currentStroke;

  /// The currently selected color for the drawing pen.
  @override
  Color get penColor;

  /// The currently selected thickness for the drawing pen.
  @override
  double get penWidth;

  /// Whether the app is in pencil freehand drawing mode.
  @override
  bool get isPencilMode;

  /// Whether the app is in straight line drawing mode (horizontal/vertical).
  @override
  bool get isLineMode;

  /// Whether the app is in free angle straight line drawing mode.
  @override
  bool get isFreeLineMode;

  /// Whether the compass tool itself is visible on the canvas.
  @override
  bool get isCompassVisible;

  /// Create a copy of CompassState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompassStateImplCopyWith<_$CompassStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

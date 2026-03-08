import 'package:flutter/material.dart';

class DraggableRotatableTool extends StatefulWidget {
  final Widget child;
  final VoidCallback? onClose;

  const DraggableRotatableTool({
    Key? key,
    required this.child,
    this.onClose,
  }) : super(key: key);

  @override
  _DraggableRotatableToolState createState() => _DraggableRotatableToolState();
}

class _DraggableRotatableToolState extends State<DraggableRotatableTool> {
  Offset _position = const Offset(100, 100);
  double _rotation = 0.0;
  double _scale = 1.0;

  Offset _startPosition = Offset.zero;
  double _startRotation = 0.0;
  double _startScale = 1.0;
  Offset _startFocalPoint = Offset.zero;
  bool _isFlipped = false;

  double _startHandleAngle = 0.0;
  double _initialHandleRotation = 0.0;
  final GlobalKey _toolKey = GlobalKey();

  Offset _getCenterGlobalPosition() {
    final RenderBox? box = _toolKey.currentContext?.findRenderObject() as RenderBox?;
    if (box != null) {
      return box.localToGlobal(box.size.center(Offset.zero));
    }
    return _position;
  }

  Widget _buildControlButton(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Transform.scale(
        scale: 1.0 / _scale,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(icon, size: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildRotateButton() {
    return GestureDetector(
      onPanStart: (details) {
        final center = _getCenterGlobalPosition();
        final offset = details.globalPosition - center;
        _startHandleAngle = offset.direction;
        _initialHandleRotation = _rotation;
      },
      onPanUpdate: (details) {
        final center = _getCenterGlobalPosition();
        final offset = details.globalPosition - center;
        setState(() {
          _rotation = _initialHandleRotation + (offset.direction - _startHandleAngle);
        });
      },
      child: Transform.scale(
        scale: 1.0 / _scale,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
          ),
          padding: const EdgeInsets.all(8),
          child: const Icon(Icons.autorenew, size: 20, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _position.dx,
      top: _position.dy,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..scale(_scale, _scale)
          ..rotateZ(_rotation),
        child: GestureDetector(
          onScaleStart: (details) {
            _startPosition = _position;
            _startRotation = _rotation;
            _startScale = _scale;
            _startFocalPoint = details.focalPoint;
          },
          onScaleUpdate: (details) {
            setState(() {
              _position = _startPosition + (details.focalPoint - _startFocalPoint);
              _scale = (_startScale * details.scale).clamp(0.5, 3.0);
              _rotation = _startRotation + details.rotation;
            });
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                key: _toolKey,
                padding: const EdgeInsets.all(32.0),
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..scale(_isFlipped ? -1.0 : 1.0, 1.0, 1.0),
                  child: widget.child,
                ),
              ),
              if (widget.onClose != null)
                Positioned(
                  right: 0,
                  top: 0,
                  child: _buildControlButton(Icons.close, Colors.red, widget.onClose!),
                ),
              Positioned(
                left: 0,
                top: 0,
                child: _buildControlButton(Icons.flip, Colors.blue, () {
                  setState(() {
                    _isFlipped = !_isFlipped;
                  });
                }),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: _buildRotateButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

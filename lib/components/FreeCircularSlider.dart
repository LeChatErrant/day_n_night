import 'package:flutter/material.dart';

class FreeCircularSlider extends StatefulWidget {
  const FreeCircularSlider({
    Key? key,
    required this.child,
    required this.centralChild,
    this.centralChildSize = 35,
    this.centralChildOpacity = 0.7,
    required this.draggedChild,
    this.draggedChildSize = 25,
    this.draggedChildOpacity = 0.6,
  }) : super(key: key);

  @override
  _FreeCircularSliderState createState() => _FreeCircularSliderState();

  final Widget child;
  final Widget centralChild;
  final double centralChildSize;
  final double centralChildOpacity;
  final Widget draggedChild;
  final double draggedChildSize;
  final double draggedChildOpacity;
}

class _FreeCircularSliderState extends State<FreeCircularSlider> {
  Offset? initialTouchPosition;
  Offset? touchPosition;

  @override
  Widget build(BuildContext context) {
    Widget? centralChild; // Will be null if shouldn't be drawn
    final initialTouchPositionSaved = this.initialTouchPosition; // This copy is needed to avoid being transformed to null while still processing the position
    if (initialTouchPositionSaved != null) {
      centralChild = Positioned(
        left: initialTouchPositionSaved.dx - widget.centralChildSize / 2,
        top: initialTouchPositionSaved.dy - widget.centralChildSize / 2,
        child: Opacity(
          opacity: widget.centralChildOpacity,
          child: SizedBox(
            child: widget.centralChild,
            width: widget.centralChildSize,
            height: widget.centralChildSize,
          ),
        ),
      );
    }

    Widget? draggedChild;
    final touchPositionSaved = this.touchPosition;
    if (touchPositionSaved != null) {
      draggedChild = Positioned(
        left: touchPositionSaved.dx - widget.draggedChildSize / 2,
        top: touchPositionSaved.dy - widget.draggedChildSize / 2,
        child: Opacity(
          opacity: widget.draggedChildOpacity,
          child: SizedBox(
            child: widget.draggedChild,
            width: widget.draggedChildSize,
            height: widget.draggedChildSize,
          ),
        ),
      );
    }
    
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanStart: (details) {
        setState(() {
          initialTouchPosition = details.localPosition;
        });
      },
      onPanUpdate: (details) {
        setState(() {
          touchPosition = details.localPosition;
        });
      },
      onPanEnd: (details) {
        setState(() {
          initialTouchPosition = null;
          touchPosition = null;
        });
      },
      child: Stack(
        children: [
          widget.child,
          centralChild,
          draggedChild,
        ].whereType<Widget>().toList(),
      ),
    );
  }
}

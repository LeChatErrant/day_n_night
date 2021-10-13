import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart';

class FreeCircularSlider extends StatefulWidget {
  const FreeCircularSlider({
    Key? key,
    required this.child,
    required this.centralChild,
    this.centralChildSize = 35,
    this.centralChildOpacity = 0.4,
    required this.draggedChild,
    this.draggedChildSize = 25,
    this.draggedChildOpacity = 0.3,
    required this.minValue,
    required this.maxValue,
    required this.onUpdate,
    this.onDragStart,
    this.onDragEnd,
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
  final double minValue;
  final double maxValue;
  final void Function(double value) onUpdate;
  final void Function()? onDragStart;
  final void Function()? onDragEnd;
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
        if (widget.onDragStart != null) {
          widget.onDragStart!();
        }
      },
      onPanUpdate: (details) {
        setState(() {
          touchPosition = details.localPosition;
        });
        final a = this.initialTouchPosition;
        final b = this.touchPosition;
        if (a != null && b != null) {
          double cosAngle = (a.dy - b.dy) / sqrt(pow(a.dx - b.dx, 2) + pow(a.dy - b.dy, 2));
          double radAngle = acos(cosAngle);
          double angle = degrees(radAngle);
          if (b.dx - a.dx < 0) {
            angle = 360 - angle;
          }
          double value = widget.minValue + (angle / 360.0) * widget.maxValue;
          widget.onUpdate(value);
        }
      },
      onPanEnd: (details) {
        setState(() {
          initialTouchPosition = null;
          touchPosition = null;
        });
        if (widget.onDragEnd != null) {
          widget.onDragEnd!();
        }
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

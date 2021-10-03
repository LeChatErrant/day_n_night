import 'package:flutter/material.dart';

class FreeCircularSlider extends StatefulWidget {
  const FreeCircularSlider({
    Key? key,
    required this.child,
    required this.initialChild,
    this.initialChildSize = 30,
    this.initialChildOpacity = 0.7,
  }) : super(key: key);

  @override
  _FreeCircularSliderState createState() => _FreeCircularSliderState();

  final Widget child;
  final Widget initialChild;
  final double initialChildSize;
  final double initialChildOpacity;
}

class _FreeCircularSliderState extends State<FreeCircularSlider> {
  Offset? initialTouchPosition;

  @override
  Widget build(BuildContext context) {
    Widget? initialChild; // Will be null if shouldn't be drawn
    final initialTouchPositionSaved = initialTouchPosition; // This copy is needed to avoid being transformed to null while still processing the position
    if (initialTouchPositionSaved != null) {
      initialChild = Positioned(
        child: Opacity(
          opacity: widget.initialChildOpacity,
          child: SizedBox(
            child: widget.initialChild,
            width: widget.initialChildSize,
            height: widget.initialChildSize,
          ),
        ),
        left: initialTouchPositionSaved.dx - widget.initialChildSize / 2,
        top: initialTouchPositionSaved.dy - widget.initialChildSize / 2,
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
      },
      onPanEnd: (details) {
        setState(() {
          initialTouchPosition = null;
        });
      },
      child: Stack(
        children: [
          widget.child,
          initialChild,
        ].whereType<Widget>().toList(),
      ),
    );
  }
}

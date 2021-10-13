import 'dart:async';

import 'package:flutter/material.dart';

class Sun extends StatefulWidget {
  const Sun({
    Key? key,
    required this.seconds,
    this.delta = 0,
    required this.size,
    required this.verticalPosition,
  }) : super(key: key);

  @override
  _SunState createState() => _SunState(height: this.verticalPosition);

  final double seconds;
  final double delta;
  final double size;
  final double verticalPosition;
}

class _SunState extends State<Sun> {
  double height;
  bool up = false;
  late Timer timer;

  _SunState({required this.height});

  void changePosition() {
    setState(() {
      if (up) {
        height = widget.verticalPosition - widget.delta / 2;
      } else {
        height = widget.verticalPosition + widget.delta / 2;
      }
      up = !up;
    });
  }

  @override
  void initState() {
    final ms = (widget.seconds * 1000).floor();
    this.timer = Timer.periodic(Duration(milliseconds: ms), (timer) => changePosition());
    super.initState();
  }

  @override
  void dispose() {
    this.timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ms = (widget.seconds * 1000).floor();
    return AnimatedPositioned(
      bottom: this.height,
      duration: Duration(milliseconds: ms),
      curve: Curves.easeInOut,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.yellow,
          boxShadow: [
            BoxShadow(
              color: Colors.yellow,
              blurRadius: 100,  // Soften the shadow
              spreadRadius: 50, // Extend the shadow
            )
          ],
        ),
      ),
    );
  }
}

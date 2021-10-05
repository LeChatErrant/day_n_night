import 'dart:math';

import 'package:flutter/material.dart';

class DynamicGradientContainer extends StatefulWidget {
  const DynamicGradientContainer({
    Key? key,
    required this.child,
    required this.time
  }) : super(key: key);

  @override
  _DynamicGradientContainerState createState() => _DynamicGradientContainerState();

  final Widget child;
  final DateTime time;
}

class _DynamicGradientContainerState extends State<DynamicGradientContainer> {
  final List<List<Color>> gradients = [
    // 00:00
    [
      Color.fromRGBO(0, 0, 30, 1),
      Color.fromRGBO(10, 20, 60, 1),
      Color.fromRGBO(20, 40, 90, 1),
      Color.fromRGBO(30, 60, 120, 1),
    ],
    // 01:00
    [
      Color.fromRGBO(0, 0, 30, 1),
      Color.fromRGBO(10, 20, 60, 1),
      Color.fromRGBO(20, 40, 90, 1),
      Color.fromRGBO(30, 60, 120, 1),
      Color.fromRGBO(40, 80, 150, 1),
    ],
    // 02:00
    [
      Color.fromRGBO(0, 0, 30, 1),
      Color.fromRGBO(10, 20, 60, 1),
      Color.fromRGBO(20, 40, 90, 1),
      Color.fromRGBO(30, 60, 120, 1),
      Color.fromRGBO(40, 80, 150, 1),
      Color.fromRGBO(50, 100, 180, 1),
    ],
    // 03:00
    [
      Color.fromRGBO(10, 20, 60, 1),
      Color.fromRGBO(20, 40, 90, 1),
      Color.fromRGBO(30, 60, 120, 1),
      Color.fromRGBO(40, 80, 150, 1),
      Color.fromRGBO(50, 100, 180, 1),
      Color.fromRGBO(60, 120, 220, 1),
    ],
    // 04:00
    [
      Color.fromRGBO(40, 40, 90, 1),
      Color.fromRGBO(60, 60, 120, 1),
      Color.fromRGBO(80, 80, 150, 1),
      Color.fromRGBO(100, 100, 180, 1),
      Color.fromRGBO(120, 120, 220, 1),
      Color.fromRGBO(150, 140, 250, 1),
    ],
    // 05:00
    [
      Color.fromRGBO(40, 40, 90, 1),
      Color.fromRGBO(60, 40, 90, 1),
      Color.fromRGBO(90, 60, 120, 1),
      Color.fromRGBO(120, 80, 150, 1),
      Color.fromRGBO(150, 100, 180, 1),
      Color.fromRGBO(180, 130, 170, 1),
      Color.fromRGBO(225, 150, 150, 1),
    ],
    // 06:00
    [
      Color.fromRGBO(90, 40, 110, 1),
      Color.fromRGBO(135, 60, 120, 1),
      Color.fromRGBO(200, 80, 150, 1),
      Color.fromRGBO(220, 130, 130, 1),
      Color.fromRGBO(240, 140, 130, 1),
    ],
    // 07:00
    [
      Color.fromRGBO(140, 35, 130, 1),
      Color.fromRGBO(200, 80, 125, 1),
      Color.fromRGBO(255, 150, 130, 1),
      Color.fromRGBO(255, 160, 130, 1),
    ],
    // 08:00
    [
      Color.fromRGBO(60, 90, 250, 1),
      Color.fromRGBO(255, 160, 130, 1),
      Color.fromRGBO(255, 180, 110, 1),
    ],
    // 09:00
    [
      Color.fromRGBO(50, 90, 200, 1),
      Color.fromRGBO(40, 130, 240, 1),
      Color.fromRGBO(255, 200, 170, 1),
    ],
    // 10:00
    [
      Color.fromRGBO(70, 120, 220, 1),
      Color.fromRGBO(100, 200, 255, 1),
      Color.fromRGBO(130, 200, 255, 1),
      Color.fromRGBO(150, 210, 255, 1),
    ],
    // 11:00
    [
      Color.fromRGBO(100, 200, 255, 1),
      Color.fromRGBO(80, 200, 240, 1),
      Color.fromRGBO(40, 130, 240, 1),
    ],
    // 12:00
    [
      Color.fromRGBO(150, 210, 255, 1),
      Color.fromRGBO(80, 170, 250, 1),
      Color.fromRGBO(40, 130, 240, 1),
    ],
  ];

  @override
  Widget build(BuildContext context) {
    final hour = widget.time.hour;
    final gradient = min(hour, 12) - max(hour - 12, 0);
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: this.gradients[gradient.floor()],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
      ),
      child: widget.child,
    );
  }
}

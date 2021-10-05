import 'package:flutter/material.dart';

class DynamicGradient extends LinearGradient {
  DynamicGradient({
    required this.time,
  }) : super(
    colors: DynamicGradient.gradients[time.hour % 2],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  final DateTime time;

  static List<List<Color>> gradients = [
    [
      Color(0xFF8C2480),
      Color(0xFFCE587D),
      Color(0xFFFF9485),
      Color(0xFFFF9D80),
    ],
    [
      Color(0xFF0D1441),
      Color(0xFF283584),
      Color(0xFF376AB2),
    ]
  ];
}

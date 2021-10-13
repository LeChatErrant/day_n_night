import 'dart:math';

import 'package:flutter/material.dart';

import 'DynamicGradientContainer.dart';
import 'Land.dart';
import 'Sun.dart';

class DynamicBackground extends StatelessWidget {
  const DynamicBackground({
    Key? key,
    required this.time,
    this.sunAnimationDelta = 10,
    this.sunAnimationTime = 3,
  }) : super(key: key);

  final DateTime time;
  final double sunAnimationDelta;
  final double sunAnimationTime;

  final double minSunPosition = -200;
  final double maxSunPosition = 250;

  // Used to get a % of how advanced is the time in the day
  // 0.0 is midnight, 1.0 is midday
  double getTimeRatio() {
    // 0 is 00:00, 2 is 24:00
    double fullDayRatio = (this.time.hour * 60 + this.time.minute) / (60 * 12);
    // 00:00 is 0, 06:00 is 0.5, 12:00 is 1, 18:00 is 0.5, 24:00 is 00
    double timeRatio = min(fullDayRatio, 1) - max(fullDayRatio - 1, 0);
    return timeRatio;
  }

  // Sun position is calculated between two points depending on timeRatio
  double getSunPosition() {
    double sunPosition = minSunPosition + (maxSunPosition - minSunPosition) * getTimeRatio();
    return sunPosition;
  }

  static List<Color> getGradient(DateTime time) {
    return DynamicGradientContainer.getGradient(time);
  }

  static double getMeanLuminance(DateTime time) {
    return DynamicGradientContainer.getMeanLuminance(time);
  }

  @override
  Widget build(BuildContext context) {
    return DynamicGradientContainer(
      time: this.time,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Sun(
            delta: this.sunAnimationDelta,
            seconds: this.sunAnimationTime,
            verticalPosition: getSunPosition(),
            size: 125,
          ),
          Land(),
        ],
      ),
    );
  }
}

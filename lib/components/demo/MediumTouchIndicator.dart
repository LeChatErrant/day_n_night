import 'package:flutter/material.dart';

class MediumTouchIndicator extends StatelessWidget {
  const MediumTouchIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [Colors.black, Colors.grey],
        ),
      ),
    );
  }
}

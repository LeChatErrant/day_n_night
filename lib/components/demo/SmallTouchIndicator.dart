import 'package:flutter/material.dart';

class SmallTouchIndicator extends StatelessWidget {
  const SmallTouchIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey,
      ),
    );
  }
}

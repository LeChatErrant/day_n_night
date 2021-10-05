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

class _DynamicGradientContainerState extends State<DynamicGradientContainer> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: DynamicGradientContainer.gradients[widget.time.hour % 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
      ),
      child: widget.child,
    );
  }
}

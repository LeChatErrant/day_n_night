import 'package:flutter/material.dart';

class FreeCircularSlider extends StatefulWidget {
  const FreeCircularSlider({Key? key, required this.child}) : super(key: key);

  @override
  _FreeCircularSliderState createState() => _FreeCircularSliderState();

  final Widget child;
}

class _FreeCircularSliderState extends State<FreeCircularSlider> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: widget.child,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Sun extends StatefulWidget {
  const Sun({
    Key? key,
    required this.seconds,
    required this.delta,
    required this.size,
    required this.bottomPosition,
  }) : super(key: key);

  @override
  _SunState createState() => _SunState();

  final double seconds;
  final double delta;
  final double size;
  final double bottomPosition;
}

class _SunState extends State<Sun> {
  late double height;
  bool up = false;

  void changePosition() {
    setState(() {
      if (up) {
        height -= widget.delta;
      } else {
        height += widget.delta;
      }
      up = !up;
    });
    Future.delayed(
      Duration(milliseconds: (widget.seconds * 1000).floor()),
      changePosition,
    );
  }

  @override
  void initState() {
    super.initState();
    height = widget.bottomPosition;
    changePosition();
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      bottom: this.height,
      duration: Duration(milliseconds: (widget.seconds * 1000).floor()),
      curve: Curves.easeInOut,
      child: SvgPicture.asset(
        'assets/images/sun.svg',
        fit: BoxFit.scaleDown,
        height: widget.size,
        width: widget.size,
      ),
    );
  }
}

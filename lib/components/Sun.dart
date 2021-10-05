import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Sun extends StatefulWidget {
  const Sun({
    Key? key,
    required this.seconds,
    required this.delta,
    required this.size,
  }) : super(key: key);

  @override
  _SunState createState() => _SunState();

  final double seconds;
  final double delta;
  final double size;
}

class _SunState extends State<Sun> {
  double height = -150;
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
    changePosition();
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return AnimatedPositioned(
      bottom: this.height,
      left: screenWidth / 2 - widget.size / 2,
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

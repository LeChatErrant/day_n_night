import 'package:flutter/material.dart';

class Land extends StatelessWidget {
  const Land({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -70,
      child: Image.asset(
        'assets/images/land.png',
        fit: BoxFit.fitWidth,
        width: MediaQuery.of(context).size.width * 1.2,
      ),
    );
  }
}

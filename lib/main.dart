import 'package:day_n_night/components/DynamicBackground.dart';
import 'package:day_n_night/components/demo/FreeCircularSlider.dart';
import 'package:day_n_night/components/demo/FullPageTimeDisplay.dart';
import 'package:day_n_night/components/demo/MediumTouchIndicator.dart';
import 'package:day_n_night/components/demo/SmallTouchIndicator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Day\'n\'night',
      theme: ThemeData(),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime time = DateTime.now();
  bool isDragging = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FreeCircularSlider(
        minValue: 0,
        maxValue: 1440,
        centralChild: MediumTouchIndicator(),
        draggedChild: SmallTouchIndicator(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            DynamicBackground(
              time: this.time,
              sunAnimationDelta: this.isDragging ? 0 : 10,
              sunAnimationTime: this.isDragging ? 1 : 3,
            ),
            FullPageTimeDisplay(time: this.time),
          ],
        ),
        onDragStart: () {
          setState(() {
            this.isDragging = true;
          });
        },
        onDragEnd: () {
          setState(() {
            this.isDragging = false;
          });
        },
        onUpdate: (value) {
          setState(() {
            final now = DateTime.now();
            this.time = DateTime(
              now.year,
              now.month,
              now.day,
              (value / 60).floor(),
              (value % 60).floor(),
            );
          });
        },
      ),
    );
  }
}

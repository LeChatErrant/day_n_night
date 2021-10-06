import 'dart:math';

import 'package:day_n_night/components/DynamicGradientContainer.dart';
import 'package:day_n_night/components/FreeCircularSlider.dart';
import 'package:day_n_night/components/Sun.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'components/Land.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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

  final double minSunPosition = -200;
  final double maxSunPosition = 250;

  // Used to get a % of how advanced the time is in the day
  // 0% is midnight, 100% is midday
  double getTimeRatio() {
    // 0 is 00:00, 2 is 24:00
    double fullDayRatio = (this.time.hour * 60 + this.time.minute) / (60 * 12);
    // 00:00 is 0, 06:00 is 0.5, 12:00 is 1, 18:00 is 0.5, 24:00 is 00
    double timeRatio = min(fullDayRatio, 1) - max(fullDayRatio - 1, 0);
    return timeRatio;
  }

  // Sun position is calculated between two points depending on timeRation
  double getSunPosition() {
    double sunPosition = minSunPosition + (maxSunPosition - minSunPosition) * getTimeRatio();
    return sunPosition;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FreeCircularSlider(
        minValue: 0,
        maxValue: 1440,
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
        centralChild: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [Colors.black, Colors.grey]
            ),
            shape: BoxShape.circle,
          ),
        ),
        draggedChild: Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
        child: DynamicGradientContainer(
          time: this.time,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: Center(
                      child: Text(
                        DateFormat('HH : mm').format(this.time),
                        style: GoogleFonts.rubik(
                          color: Colors.white,
                          fontSize: 30
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),
                ],
              ),
              Sun(
                delta: isDragging ? 0 : 10,
                seconds: isDragging ? 1 : 3,
                bottomPosition: getSunPosition(),
                size: 125,
              ),
              Land(),
            ],
          ),
        ),
      ),
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      Color(0xFF8C2480),
      Color(0xFFCE587D),
      Color(0xFFFF9485),
//      Color(0xFFFF9D80),
    ];


    return Scaffold(
      backgroundColor: Colors.black,
      body: FreeCircularSlider(
        minValue: 0,
        maxValue: 1440,
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
            color: Colors.grey.shade600,
            shape: BoxShape.circle,
          ),
        ),
        draggedChild: Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
        child: AnimatedContainer(
          duration: Duration(seconds: 2),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: colors,
            )
          ),
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
                delta: 25,
                seconds: 3,
                bottomPosition: -100,
                size: MediaQuery.of(context).size.width,
              ),
              Land(),
            ],
          ),
        ),
      ),
    );
  }
}

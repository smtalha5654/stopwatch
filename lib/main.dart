import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: StopWatchScreen(),
  ));
}

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({Key? key}) : super(key: key);

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  String HoursString = "00";
  String MinsString = "00";
  String SecondsString = "00";
  int hours = 0, mins = 0, seconds = 0;
  late Timer _timer;
  bool isTimerRuning = false, isResetButtonVisible = false;

  void startTimer() {
    setState(() {
      isTimerRuning = true;
    });
    _timer = Timer.periodic(Duration(seconds: 1), ((timer) {
      startSecond();
    }));
  }

  void pauseTimer() {
    _timer.cancel();
    setState(() {
      isTimerRuning = false;
    });
    isResetButtonVisible = checkValues();
  }

  void startSecond() {
    setState(() {
      if (seconds < 59) {
        seconds++;
        SecondsString = seconds.toString();
        if (SecondsString.length == 1) {
          SecondsString = "0" + SecondsString;
        }
      } else {
        startMin();
      }
    });
  }

  void startMin() {
    setState(() {
      if (mins < 59) {
        seconds = 0;
        SecondsString = "00";
        mins++;
        MinsString = mins.toString();
        if (MinsString.length == 1) {
          MinsString = "0" + MinsString;
        }
      } else {
        starthour();
      }
    });
  }

  void starthour() {
    seconds = 0;
    SecondsString = "00";
    mins = 0;
    MinsString = "00";
    hours++;
    HoursString = hours.toString();
    if (HoursString.length == 1) {
      HoursString = "0" + HoursString;
    }
  }

  void resetTimer() {
    _timer.cancel();
    setState(() {
      seconds = 0;
      mins = 0;
      hours = 0;
      SecondsString = "00";
      MinsString = "00";
      HoursString = "00";
    });
    isResetButtonVisible = false;
  }

  bool checkValues() {
    if (seconds != 0 || mins != 0 || hours != 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Stopwatch App"),
        ),
        drawer: Drawer(),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$HoursString:$MinsString:$SecondsString",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.w700),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (isTimerRuning) {
                      pauseTimer();
                    } else {
                      startTimer();
                    }
                  },
                  child: Text(isTimerRuning ? "Pause" : "Play")),
              isResetButtonVisible
                  ? ElevatedButton(
                      onPressed: () {
                        resetTimer();
                      },
                      child: Text("Reset"))
                  : SizedBox()
            ],
          ),
        ));
  }
}

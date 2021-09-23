import 'dart:async';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
    title: "Watch",
    theme: ThemeData(
      backgroundColor: Colors.red,
    ),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  late int hours = 0;
  late int min = 0;
  late int seco = 0;
  late bool started = true;
  late bool stoped = true;
  late int timert;
  late String display = "";
  late bool canclet = false;

  late TabController tc;

  @override
  void initState() {
    super.initState();
    tc = TabController(length: 2, vsync: this);
  }

  void start() {
    setState(() {
      started = false;
      stoped = false;
    });
    timert = ((hours * 3600) + (min * 60) + seco);
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (timert < 1 || canclet == true) {
          t.cancel();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyApp()));
        } else if (timert < 60) {
          display = timert.toString();
          timert = timert - 1;
        } else if (timert < 3600) {
          int m = timert ~/ 60;
          int s = timert - (60 * m);
          display = m.toString() + ":" + s.toString();
          timert = timert - 1;
        } else {
          int h = timert ~/ 3600;
          int t = timert - (3600 * h);
          int m = t ~/ 60;
          int s = t - (60 * m);
          display = h.toString() + ":" + m.toString() + ":" + s.toString();
          timert = timert - 1;
        }
      });
    });
  }

  void stop() {
    setState(() {
      stoped = true;
      stoped = true;
      canclet = true;
      display;
    });
  }

  Widget timer() {
    return Container(
      child: Column(
        children: [
          Expanded(
              flex: 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: [
                      Padding(padding: EdgeInsets.all(30)),
                      Text(
                        "HH",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      NumberPicker(
                          minValue: 0,
                          maxValue: 23,
                          value: hours,
                          onChanged: (value) {
                            setState(() {
                              hours = value;
                            });
                          })
                    ],
                  ),
                  Column(
                    children: [
                      Padding(padding: EdgeInsets.all(30)),
                      Text(
                        "MM",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      NumberPicker(
                          minValue: 0,
                          maxValue: 59,
                          value: min,
                          onChanged: (value) {
                            setState(() {
                              min = value;
                            });
                          })
                    ],
                  ),
                  Column(
                    children: [
                      Padding(padding: EdgeInsets.all(30)),
                      Text(
                        "SS",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      NumberPicker(
                          minValue: 0,
                          maxValue: 59,
                          value: seco,
                          onChanged: (value) {
                            setState(() {
                              seco = value;
                            });
                          })
                    ],
                  ),
                ],
              )),
          Expanded(
              flex: 0,
              child: Text(
                display,
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w600,
                ),
              )),
          Expanded(
              flex: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // ignore: deprecated_member_use
                  RaisedButton(
                    onPressed: started ? start : null,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0)),
                    padding: EdgeInsets.symmetric(
                      horizontal: 35.0,
                      vertical: 12.0,
                    ),
                    color: Colors.blue,
                    child: Text(
                      "Start",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  // ignore: deprecated_member_use
                  RaisedButton(
                    onPressed: stoped ? null : stop,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0)),
                    padding:
                        EdgeInsets.symmetric(horizontal: 35.0, vertical: 12.0),
                    color: Colors.blue,
                    child: Text(
                      "Stop",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  bool startispressed = true;
  bool stopispressed = true;
  bool resetispressed = true;
  String stoptimetodisplay = "00:00:00";
  var swatch = Stopwatch();
  final dur = const Duration(seconds: 1);

  void starttimer() {
    Timer(dur, keeprunning);
  }

  void keeprunning() {
    if (swatch.isRunning) {
      starttimer();
    }
    setState(() {
      stoptimetodisplay = swatch.elapsed.inHours.toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
    });
  }

  void startstopwatch() {
    setState(() {
      stopispressed = false;
      startispressed = false;
    });
    swatch.start();
    starttimer();
  }

  void stopstopwatch() {
    setState(() {
      stopispressed = true;
      resetispressed = false;
      startispressed = true;
    });
    swatch.stop();
  }

  void resetstopwatch() {
    setState(() {
      startispressed = true;
      resetispressed = true;
    });
    swatch.reset();
    stoptimetodisplay = "00:00:00";
  }

  Widget stopwatch() {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                stoptimetodisplay,
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Expanded(
              flex: 4,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // ignore: deprecated_member_use
                        RaisedButton(
                          onPressed: stopispressed ? null : stopstopwatch,
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0)),
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 15.0,
                          ),
                          child: Text(
                            "Stop",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        // ignore: deprecated_member_use
                        RaisedButton(
                          onPressed: resetispressed ? null : resetstopwatch,
                          color: Colors.teal,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0)),
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 15.0,
                          ),
                          child: Text(
                            "Reset",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),

                    // ignore: deprecated_member_use
                    RaisedButton(
                      onPressed: startispressed ? startstopwatch : null,
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0)),
                      padding: EdgeInsets.symmetric(
                        horizontal: 80.0,
                        vertical: 20.0,
                      ),
                      child: Text(
                        "Start",
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Watch",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          tabs: <Widget>[
            Text("Timer"),
            Text("stopwatch"),
          ],
          labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          labelPadding: EdgeInsets.only(bottom: 12),
          controller: tc,
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          timer(),
          stopwatch(),
        ],
        controller: tc,
      ),
    );
  }
}

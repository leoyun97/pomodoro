import 'dart:async';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveM = 1500;
  int totalSeconds = twentyFiveM; //1500초
  int totalPomodoro = 0;
  late Timer timer; //당장 초기화 하지 않을 경우는 late를 써준다.
  bool isRunning = false;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomodoro = totalPomodoro + 1;
        isRunning = false;
        totalSeconds = twentyFiveM;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void reSetBtn(){
    setState(() {
      totalSeconds = twentyFiveM;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    //1.split은 ""안의 문자를 기준으로 잘라서 list 형태로 반환
    //2.first는 list의 첫번째 value
    //3,substring은 문자열 몇번째부터 몇번째까지 잘라내서 반환
    return duration.toString().split(".").first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Flexible(
              flex: 1,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  //'$totalSeconds',
                  format(totalSeconds),
                  style: TextStyle(
                    color: Theme.of(context).cardColor,
                    fontSize: 90,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: IconButton(
                      icon: Icon(
                        isRunning
                            ? Icons.pause_circle_outline_outlined
                            : Icons.play_circle_outline_outlined,
                      ),
                      onPressed: isRunning ? onPausePressed : onStartPressed,
                      iconSize: 90,
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                  Visibility(
                    visible: isRunning ? false : true,
                    child: IconButton(
                      icon: const Icon(
                        Icons.lock_reset_outlined,
                      ),
                      onPressed: reSetBtn,
                      iconSize: 90,
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Theme.of(context).cardColor,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Pomodoros',
                            style: TextStyle(
                              fontSize: 30,
                              color: Color(0xFF232B55),
                            ),
                          ),
                          Text(
                            '$totalPomodoro',
                            style: const TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF232B55)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

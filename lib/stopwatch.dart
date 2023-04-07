import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'dart:async';

class StopWatch extends StatefulWidget {
  StopWatch({
    super.key,
  });

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  int timeRemains = 100;
  double progressBar = 0.5;
  bool isTimerActive = true;

  late Timer _everySecond;
  late String _now;

  @override
  void initState() {
    super.initState();

    // sets first value
    _now = DateTime.now().second.toString();

    // defines a timer
    _everySecond = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if (isTimerActive) {
          timeRemains = timeRemains - 1;
        }
        if (timeRemains < 1) {
          isTimerActive = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          children: [
            const Text(
              'Linear progress indicator',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 30),
            LinearProgressIndicator(
              value: progressBar,
              semanticsLabel: 'Linear progress indicator',
            ),
            const SizedBox(height: 10),
            Text(timeRemains.toString()),
            ElevatedButton(
              onPressed: () {
                isTimerActive = !isTimerActive;
              },
              child: const Text('timer'),
            )
          ],
        ),
      ),
    );
  }
}

void updateBitch() {}

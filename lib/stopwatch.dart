import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'dart:async';

class StopWatch extends StatefulWidget {
  const StopWatch({
    super.key,
  });

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  int timeRemains = globals.selectedTime;
  int timeTotal = globals.selectedTime;
  double progressBar = 1.0;
  bool isTimerActive = true;

  late Timer _everySecond;

  @override
  void initState() {
    super.initState();

    // defines a timer
    _everySecond = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if (isTimerActive) {
          timeRemains = timeRemains - 1;
          progressBar = ((timeRemains * 100.0) / timeTotal) / 100.0;
        }
        if (timeRemains < 1) {
          isTimerActive = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.width;
    final explanation = globals.lang == 'en' ? 'Time Remaining' : 'Kalan Süre';
    final secSan = globals.lang == 'en' ? 'Seconds Remainins' : 'Saniye Kaldı';
    return Material(
      child: Center(
        child: Column(
          children: [
            Text(
              explanation,
              style: const TextStyle(fontSize: 40),
            ),
            const SizedBox(height: 10),
            Center(
              child: SizedBox(
                width: screenSize * 0.9,
                child: LinearProgressIndicator(
                  minHeight: 20,
                  color: Colors.green,
                  value: progressBar,
                  semanticsLabel: explanation,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text('$timeRemains  $secSan'),
            InkWell(
              onTap: () {
                isTimerActive = !isTimerActive;
              },
              child: SizedBox(
                height: 100,
                width: screenSize * 0.5,
                child: Image(
                    image: AssetImage(isTimerActive == false
                        ? 'images/ok.png'
                        : 'images/cancel.png')),
              ),
            )
          ],
        ),
      ),
    );
  }
}

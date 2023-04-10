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
  bool isFirstLoop = true;
  var explanation = globals.lang == 'en' ? 'Time Remaining' : 'Kalan Süre';
  var secSan = globals.lang == 'en' ? 'Seconds Remainins' : 'Saniye Kaldı';
  // ignore: unused_field
  Timer _everySecond = Timer(const Duration(seconds: 1), () {});

  @override
  void initState() {
    super.initState();

    // defines a timer
    _everySecond = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if (timeRemains > 0) {
          if (isTimerActive) {
            timeRemains = timeRemains - 1;
            progressBar = ((timeRemains * 100.0) / timeTotal) / 100.0;
          }
        } else {
          _everySecond.cancel();
          explanation = globals.lang == 'en'
              ? 'Process is Completed'
              : 'Uygulama Tamamlandı';
          secSan = globals.lang == 'en' ? 'Ended' : 'Tamamlandı';
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.width;

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
            Text(timeRemains >= 1 ? '$timeRemains  $secSan' : secSan),
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

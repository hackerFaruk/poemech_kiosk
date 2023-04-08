import 'package:flutter/material.dart';
import 'globals.dart' as globals;

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

  @override
  void initState() {
    super.initState();

    // defines a timer
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

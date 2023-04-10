import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
// ignore: unused_import
import 'dart:io';

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
              onTap: () async {
                isTimerActive = !isTimerActive;
                if (!isTimerActive) {
                  // malruk kodu

                  bool connection = true;

                  var url = Uri.parse(
                      "https://poemech.com.tr:3001/api/mail/emergencyButton");
                  final body = json
                      .encode({"id": "ABY00005", "mail": "info@onarfa.com"});

                  // ignore: prefer_typing_uninitialized_variables
                  var res;
                  try {
                    res = await http.post(url,
                        headers: {"Content-Type": "application/json"},
                        body: body);
                    // ignore: unused_catch_clause
                  } on Exception catch (e) {
                    //print(e.toString());
                    connection = false;
                  }
                  if (connection) {
                    final Map<String, dynamic> data = json.decode(res.body);

                    if (data['done'] == 'false') {
                    } else if (data['done'] == 'true') {
                    } else {}
                  }

                  // malruk kodu
                }
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

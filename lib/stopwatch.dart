import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'cardscreen.dart';
import 'globals.dart' as globals;
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'emergencyStop.dart' as emergencyStop;
import 'processcontrol.dart' as process;

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
  double butHeight = 100;
  // timers start still so it is false on defaulşt
  bool isTimerActive = globals.isTimerActive;
  bool isFirstLoop = true;
  var explanation = globals.lang == 'en' ? 'Time Remaining' : 'Kalan Süre';
  var secSan = globals.lang == 'en' ? 'Seconds Remainins' : 'Saniye Kaldı';
  // ignore: unused_field
  Timer _everySecond = Timer(const Duration(seconds: 1), () {});

  @override
  void initState() {
    super.initState();

    // defines a timer
    // timerda durdurulmayı kaldırcaz

    _everySecond = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        isTimerActive = globals.isTimerActive;
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

    Timer(Duration(seconds: 45), () {
      if (!globals.isTimerActive) {
        if (globals.lang == 'en')
          process.ProcessControlPage.player.play(AssetSource("keiu2.mp3"));
        else
          process.ProcessControlPage.player.play(AssetSource("ketu2.mp3"));
      }
    });

    if (kDebugMode) {
      print(globals.isEmergencyButton);
    }
    if (isStartStopActive()) {
      butHeight = 100;
    } else {
      butHeight = 1;
    }
    return Material(
      child: Center(
        child: Column(
          children: [
            Text(
              explanation,
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 10),
            Center(
              child: SizedBox(
                width: screenSize * 0.9,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          // shadow gölge drop shadow ayarları
                          color: Colors.black.withOpacity(0.4),
                          spreadRadius: 6,
                          blurRadius: 12,
                          offset: const Offset(0, 2))
                    ],
                    // border çerçeve ayarları
                    border: Border.all(
                      color: Colors.cyan,
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: LinearProgressIndicator(
                    minHeight: 20,
                    color: Colors.green,
                    value: progressBar,
                    semanticsLabel: explanation,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(timeRemains >= 1 ? '$timeRemains  $secSan' : secSan),
            InkWell(
              // active passivetimer start stop tick cancel red gren buton
              onTap: () async {
                // eğer timer false ise tureya alcaz
                if (!isTimerActive) {
                  globals.isTimerActive = true;
                  isTimerActive = true;

                  writePort(CardScreen.dus, "0", CardScreen.sure,
                      CardScreen.sicaksoguk, CardScreen.basinc);

                  // malruk kodu
                } else {
                  //BURASI SİSTEMİ DURDURMAK İÇİN YAZILACAK KOD
                }
              },
              child: SizedBox(
                height: butHeight,
                width: screenSize * 0.5,
                child: Image(
                    image: AssetImage(isTimerActive == false
                        ? 'images/start.jpeg'
                        : 'images/hidden.jpeg')),
              ),
            ),
            SizedBox(
                child: globals.isEmergencyButton == true
                    ? const emergencyStop.emergencyStop()
                    : const SizedBox())
          ],
        ),
      ),
    );
  }
}

Uint8List _stringToUint8List(String data) {
  List<int> codeUnits = data.codeUnits;
  Uint8List uint8list = Uint8List.fromList(codeUnits);
  return uint8list;
}

Future<void> writePort(dus, krem, number1, number2, number3) async {
  try {
    if (CardScreen.port1 != null) {
      if (!CardScreen.port1!.isOpen) {
        try {
          await OpenMk();
        } catch (e) {
          print("PORT AÇARKEN GİRİYOR HATAYA");
        }
      }
    }
    print(_stringToUint8List("<" +
        dus +
        "," +
        krem +
        "," +
        number2 +
        "," +
        number3 +
        ",0" +
        number1 +
        ">"));
    print("<" +
        dus +
        "," +
        krem +
        "," +
        number2 +
        "," +
        number3 +
        ",0" +
        number1 +
        ">");
    if (int.parse(number3) >= 10) {
      CardScreen.port1?.write(_stringToUint8List("<" +
          dus +
          "," +
          krem +
          "," +
          number2 +
          "," +
          number3 +
          "," +
          number1 +
          ">"));
    } else {
      CardScreen.port1?.write(_stringToUint8List("<" +
          dus +
          "," +
          krem +
          "," +
          number2 +
          "," +
          number3 +
          ",0" +
          number1 +
          ">"));
    }
    CloseMk();
  } catch (e) {
    print(e);
    /*
      if (ButtonGrid.count < 3000) {
        await writePort(number);
      } else {
        CardScreen.number = 7;
        ButtonGrid.count = 0;
      }*/
  }
  //SerialPort serialPort = new SerialPort();
  //await serialPort.open(mode: mode);
}

Future<void> CloseMk() async {
  print("close denedim");
  if (CardScreen.port1 != null) {
    if (CardScreen.port1!.isOpen) CardScreen.port1!.close();
  }
}

Future<void> OpenMk() async {
  CardScreen.port1?.openReadWrite();
}

// startstop tiki ise sadece sakat ve köpekte olacak
// bunlar anı zamanda emergency stop içinde var
// birileri sürekli fikir değiştirince yeni fonksiyion
bool isStartStopActive() {
  if (globals.isEmergencyButton) {
    return true;
  } else {
    return false;
  }
}

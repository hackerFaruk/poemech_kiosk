import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:poemech_kiosk/main.dart';
import 'package:poemech_kiosk/mutantAppIcon.dart';
import 'cardscreen.dart';
import 'globals.dart' as globals;
import 'stopwatch.dart' as stop;
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:audioplayers/audioplayers.dart';
import 'mutantAppIcon.dart' as mutant;
import 'main.dart' as main;

import 'appIcon.dart' as appIcon;

class ProcessControlPage extends StatelessWidget {
  final String application;
  static String exit = "";
  static bool flag = false;
  static AudioPlayer player = AudioPlayer();
  static AudioPlayer music = AudioPlayer();
  static AudioCache audioCache = AudioCache();
  static bool impostor = false;
  static bool ended = false;
  const ProcessControlPage({super.key, required this.application});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    print(globals.selected);
    //WaitPort(context);

    double gapsize = 20.0;
    if (isStopwatch()) {
      gapsize = 0.0;
    }

    void _handleButtonPress() {
      // Add your print statement here
      print("Button pressed!");

      globals.revertAll();
      globals.unGrayAll();
      globals.renderTrigger = !globals.renderTrigger;

      Navigator.pop(context);
      Navigator.pop(context);
      globals.revertAll();
      globals.unGrayAll();

// render trigger enforces render on grayable selction
      globals.renderTrigger = !globals.renderTrigger;
    }

    print("this is proces control page");

    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              globals.lang == 'en' ? ' Ongoing Process ' : 'İşlem Sürüyor'),
          leading: BackButton(
            color: Colors.white,
            //
            // ignore: avoid_print
            onPressed: _handleButtonPress,
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: gapsize,
            ),
            Center(
              child: SizedBox(
                  //width: screenSize.width * 0.4,
                  //height: screenSize.height * 0.4,

                  child: isStopwatch()
                      ? SizedBox(
                          width: screenSize.width * 0.3,
                          height: screenSize.height * 0.3,
                          child: Image(
                            image: AssetImage(application),
                          ),
                        )
                      : const mutant.mutantAppIcon()

                  //Image(image: AssetImage(application),),

                  ),
            ),
            SizedBox(height: gapsize),
            const EmergencyControls(),
          ],
        ),
      ),
    );
  }

  Future<void> WaitPort(BuildContext context) async {
    music.setVolume(0.2);
    music.setReleaseMode(ReleaseMode.loop);
    music.play(AssetSource("wait1.wav"));
    ProcessControlPage.ended = false;
    Timer(Duration(seconds: 10), () {
      if (!impostor) {
        player.stop();
        player.play(AssetSource("1-1K.mp3"));
      }
    });
    readPort(context);
    //player.play(AssetSource("service.mp3"));
  }

  Future<void> readPort(BuildContext context) async {
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
    } catch (e) {
      print(e);
    }
    try {
      SerialPortReader reader = SerialPortReader(CardScreen.port1!);
      Stream<String> upcomingData = reader.stream.map((data) {
        return String.fromCharCodes(data);
      });
      upcomingData.listen((data) {
        print("okumaktayım");
        print("GELEN DATA: ");
        print(data);
        if (data.length > 0) {
          if (data.contains("<5,6>")) {
            player.stop();
            player.play(AssetSource("17-1K.mp3"));
          } else if (data.contains("<5,0>")) {
            player.stop();
            player.play(AssetSource("12-1K.mp3"));
          } else if (data.contains("<5,8>")) {
            player.stop();
            player.play(AssetSource("20-1K.mp3"));
          } else if (data.contains("<5,1>")) {
            player.stop();
            player.play(AssetSource("5-1K.mp3"));
          } else if (data.contains("<5,3>")) {
            globals.isTimerActive = true;
          } else if (data.contains("<5,9>")) {
            //Timeout
            player.stop();
            player.play(AssetSource("2-1K.mp3"));
          } else if (data.contains("<5,10>")) {
            impostor = true;
            player.stop();
            player.play(AssetSource("3-1K.mp3"));
          } else if (data.contains("<5,11>")) {
            player.stop();
            player.play(AssetSource("4-1K.mp3"));
          } else if (data.contains("<5,12>")) {
            player.stop();
            player.play(AssetSource("9-1K.mp3"));
          } else if (data.contains("<5,13>")) {
            player.stop();
            player.play(AssetSource("10-1K.mp3"));
          } else if (data.contains("<5,14>")) {
            player.stop();
            player.play(AssetSource("15-1K.mp3"));
          } else if (data.contains("<5,5>")) {
            player.stop();
            player.play(AssetSource("11-1K.mp3"));
            try {
              CardScreen.port1!.close();
            } catch (e) {
              print("kapattım");
            }
            music.stop();
            ProcessControlPage.ended = true;
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CardScreen()));
          }
          if (!reader.stream.isBroadcast) {
            print("broadcast biddi");
          }
        }
      }).onError((error) {
        print("HATA ALDIM CANIM");
        print(error);
        CardScreen.port1!.close();
        if (ProcessControlPage.ended == false) readPort(context);
      });
    } catch (e) {
      readPort(context);
      // print("yazamadım");
    }
  }

  Uint8List _stringToUint8List(String data) {
    List<int> codeUnits = data.codeUnits;
    Uint8List uint8list = Uint8List.fromList(codeUnits);
    return uint8list;
  }

  Future<void> OpenMk() async {
    CardScreen.port1?.openReadWrite();
  }

  Future<void> CloseMk() async {
    print("close denedim");
    if (CardScreen.port1!.isOpen) CardScreen.port1!.close();
  }
}

class EmergencyControls extends StatefulWidget {
  const EmergencyControls({super.key});

  @override
  State<EmergencyControls> createState() => _EmergencyControlsState();
}

class _EmergencyControlsState extends State<EmergencyControls> {
  bool isProcessOngoing = false;
  // ignore: non_constant_identifier_names
  var StartQuery = globals.lang == 'en'
      ? 'Click To Start '
      : 'İşlemi Başlatmak İçin Tıklaynız';

  // ignore: non_constant_identifier_names
  var StopQuery = globals.lang == 'en'
      ? 'Click for Emergency Stop'
      : 'Acil Durdurma İçin Tıklayınız';

  var WaitQuery = globals.lang == 'en'
      ? 'Services are currently being provided in the cabin. Please wait. '
      : 'Kabinde işlem devam etmektedir. Lütfen bekleyiniz.';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: isStopwatch()
            ? const stop.StopWatch()
            : Text(
                WaitQuery,
                style: const TextStyle(fontSize: 36),
                textAlign: TextAlign.center,
              ),
      ),
    );
  }
}

bool isStopWatchEverywhere = true;

//stop watch sadece köpek ve engelli mod için o yüzden şöle bişi yapcaz
// engelli vwe köppekte stopwatch var ve emergenc button var
// emergenc varsa stopta olsun dedik
// şimdi yeni bişi yapcaz habire karar değiştiği için sik sik
// buraya stopwatch olsun mu diyeceğim, olsun derse aççak hep yok derse koşula bağlı yapcak
// isStopWatchEverywhere diyerek seccen
bool isStopwatch() {
  if (isStopWatchEverywhere) {
    return true;
  } else if (globals.isEmergencyButton) {
    return true;
  } else {
    return false;
  }
}

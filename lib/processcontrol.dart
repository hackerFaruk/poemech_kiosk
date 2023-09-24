import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:poemech_kiosk/main.dart';
import 'cardscreen.dart';
import 'globals.dart' as globals;
import 'stopwatch.dart' as stop;
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:audioplayers/audioplayers.dart';

class ProcessControlPage extends StatelessWidget {
  final String application;
  static String exit = "";
  static bool flag = false;
  static AudioPlayer player = AudioPlayer();
  static AudioPlayer music = AudioPlayer();
  static AudioCache audioCache = AudioCache();
  static bool impostor = false;
  const ProcessControlPage({super.key, required this.application});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    WaitPort(context);
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              globals.lang == 'en' ? ' Ongoing Process ' : 'İşlem Sürüyor'),
          leading: const BackButton(
            color: Colors.white,
          ),
        ),
        body: Column(
          children: [
            Center(
              child: SizedBox(
                width: screenSize.width * 0.4,
                height: screenSize.height * 0.4,
                child: Image(
                  image: AssetImage(application),
                ),
              ),
            ),
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

    Timer(Duration(seconds: 12), () {
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
          } else if (data.contains("<5,5>")) {
            player.stop();
            player.play(AssetSource("11-1K.mp3"));
            try {
              CardScreen.port1!.close();
            } catch (e) {
              print("kapattım");
            }
            music.stop();
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
        readPort(context);
      });
    } catch (e) {
      readPort(context);
      print("yazamadım");
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

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: const [
          stop.StopWatch(),
        ],
      ),
    );
  }
}


//stop watch sadece köpek ve aşlı mod için o yüzden şöle bişi yapcaz 

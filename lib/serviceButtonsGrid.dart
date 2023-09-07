import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:poemech_kiosk/cardscreen.dart';
import 'buttonList.dart' as buttonList;

class ButtonGrid extends StatefulWidget {
  const ButtonGrid({super.key});

  @override
  State<ButtonGrid> createState() => _ButtonGridState();
}

class _ButtonGridState extends State<ButtonGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Change this value according to your layout
      ),
      itemCount: buttonList.buttonNames.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(5.0),
          child: ElevatedButton(
            onPressed: () => writePort(buttonList.serialStrings[index]),
            style: ElevatedButton.styleFrom(
                side: const BorderSide(width: 3.0, color: Colors.indigoAccent)),
            child: Text(buttonList.buttonNames[index],
                style: const TextStyle(fontSize: 20.0)),
          ),
        );
      },
    );
  }

  Uint8List _stringToUint8List(String data) {
    List<int> codeUnits = data.codeUnits;
    Uint8List uint8list = Uint8List.fromList(codeUnits);
    return uint8list;
  }

  Future<void> writePort(String number) async {
    try {
      if (CardScreen.port1 != null) {
        if (!CardScreen.port1!.isOpen) {
          CardScreen.port1?.openReadWrite();
        }
      }
      print(_stringToUint8List("<3,0,0,0,$number>"));
      CardScreen.port1?.write(_stringToUint8List("<3,0,0,0,$number>"));
    } catch (e) {
      print("HATA ALDIM BREMIN");
    }
    readPort();
    //SerialPort serialPort = new SerialPort();
    //await serialPort.open(mode: mode);
  }

  Future<void> readPort() async {
    try {
      SerialPortReader reader = SerialPortReader(CardScreen.port1!);
      Stream<String> upcomingData = reader.stream.map((data) {
        return String.fromCharCodes(data);
      });

      upcomingData.listen((data) {
        print("GELEN DATA: $data");
      });
    } catch (e) {
      print("yazamadım");
    }
  }
}

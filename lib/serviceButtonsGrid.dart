import 'dart:typed_data';
import 'dart:ffi' as ffi;

import 'package:flutter/material.dart';
import 'package:poemech_kiosk/buttonList.dart' as buttonList;
import 'main.dart';

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
        return ElevatedButton(
          onPressed: () => writePort(buttonList.serialStrings[index]),
          child: Text(buttonList.buttonNames[index]),
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
      MainPage.port1?.openReadWrite();
      MainPage.port1?.write(_stringToUint8List("<3,0,0,0," + number + ">"));
    } catch (e) {
      print(e);
    }
    //SerialPort serialPort = new SerialPort();
    //await serialPort.open(mode: mode);
  }
}

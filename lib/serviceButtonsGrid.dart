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

  Future<void> writePort(number) async {
    try {
      if (CardScreen.port1 != null) {
        if (!CardScreen.port1!.isOpen) {
          try {
            CardScreen.port1?.openReadWrite();
            print(SerialPort.lastError);
          } catch (e) {
            print(e);
          }
        }
      }
      print(_stringToUint8List("<3,0,0,0," + number + ">"));
      if (int.parse(number) >= 10) {
        CardScreen.port1?.write(_stringToUint8List("<3,0,0,0," + number + ">"));
      } else {
        CardScreen.port1
            ?.write(_stringToUint8List("<3,0,0,0,0" + number + ">"));
      }
      CardScreen.port1?.write(_stringToUint8List("<3,0,0,0," + number + ">"));
    } catch (e) {
      print(e);
    }
    //SerialPort serialPort = new SerialPort();
    //await serialPort.open(mode: mode);
  }

  Future<void> readPort(number) async {
    await writePort(number);
    try {
      CardScreen.port1!.flush(0);
      CardScreen.port1!.flush(1);
      SerialPortReader reader = SerialPortReader(CardScreen.port1!);
      Stream<String> upcomingData = reader.stream.map((data) {
        return String.fromCharCodes(data);
      });
      reader.port.flush(0);
      reader.port.flush(1);
      upcomingData.listen((data) {
        print("GELEN DATA: $data");
      });
    } catch (e) {
      print("yazamadım");
    }
    CardScreen.port1!.close();
  }
}

import 'dart:typed_data';
import 'dart:ffi' as ffi;

import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:poemech_kiosk/cardscreen.dart';
import 'package:poemech_kiosk/buttonList.dart' as buttonList;
import 'package:audioplayers/audioplayers.dart';

class ButtonGrid extends StatefulWidget {
  const ButtonGrid({super.key});
  static int count = 0;
  @override
  State<ButtonGrid> createState() => _ButtonGridState();
}

class _ButtonGridState extends State<ButtonGrid> {
  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      thumbColor: Colors.green,
      radius: const Radius.circular(15.0),
      thumbVisibility: true,
      thickness: 20.0,
      controller: controller,
      child: GridView.builder(
        controller: controller,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Change this value according to your layout
        ),
        itemCount: buttonList.buttonNames.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () =>
                  readPort("3", "0", "0", "0", buttonList.serialStrings[index]),
              style: ElevatedButton.styleFrom(
                  side:
                      const BorderSide(width: 3.0, color: Colors.indigoAccent)),
              child: Text(buttonList.buttonNames[index],
                  style: const TextStyle(fontSize: 20.0)),
            ),
          );
        },
      ),
    );
  }

  Uint8List _stringToUint8List(String data) {
    List<int> codeUnits = data.codeUnits;
    Uint8List uint8list = Uint8List.fromList(codeUnits);
    return uint8list;
  }

  Future<void> writePort(dus, krem, number1, number2, number3) async {
    CardScreen.number += 1;
    /*
    if (CardScreen.number >= 7) {
      CardScreen.number = 0;
      await CloseMk();
    }*/
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
          number1 +
          "," +
          number2 +
          "," +
          number3 +
          ">"));
      if (int.parse(number3) >= 10) {
        CardScreen.port1?.write(_stringToUint8List("<" +
            dus +
            "," +
            krem +
            "," +
            number1 +
            "," +
            number2 +
            "," +
            number3 +
            ">"));
      } else {
        CardScreen.port1?.write(_stringToUint8List("<" +
            dus +
            "," +
            krem +
            "," +
            number1 +
            "," +
            number2 +
            ",0" +
            number3 +
            ">"));
      }
    } catch (e) {
      print("burada hata");
    }
  }

  Future<void> readPort(dus, krem, number1, number2, number3) async {
    ButtonGrid.count = 0;
    await writePort(dus, krem, number1, number2, number3);
    if (int.parse(number3) != 42 &&
        int.parse(number3) != 43 &&
        int.parse(number3) != 40) CloseMk();
    if (int.parse(number3) == 42 ||
        int.parse(number3) == 43 ||
        int.parse(number3) == 40) {
      try {
        SerialPortReader reader = SerialPortReader(CardScreen.port1!);
        Stream<String> upcomingData = reader.stream.map((data) {
          return String.fromCharCodes(data);
        });
        upcomingData.listen((data) {
          ButtonGrid.count++;
          print(ButtonGrid.count);
          print("GELEN DATA: ");
          if (number3 != 40)
            print(data.codeUnits);
          else
            print(data);
          if (ButtonGrid.count >= 7) {
            ButtonGrid.count = 0;
            CloseMk();
          }
        });
      } catch (e) {
        print("yazamadım");
      }
    }
  }

  Future<void> CloseMk() async {
    print("close denedim");
    if (CardScreen.port1!.isOpen) CardScreen.port1!.close();
  }

  Future<void> OpenMk() async {
    CardScreen.port1?.openReadWrite();
  }
}

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'globals.dart' as global;

/// GrayOutable buttons -_______________________________________________________
class GreyoutButtons extends StatelessWidget {
  final int grayout;
  final String icon;
  const GreyoutButtons({super.key, required this.icon, required this.grayout});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size.width;

    if (grayout == 1) {
      return SizedBox(
          width: screenSize * 0.25,
          height: screenSize * 0.25,
          child: ColorFiltered(
            // dont know why it works but works
            colorFilter: const ColorFilter.matrix(<double>[
              0.2126,
              0.7152,
              0.0722,
              0,
              0,
              0.2126,
              0.7152,
              0.0722,
              0,
              0,
              0.2126,
              0.7152,
              0.0722,
              0,
              0,
              0,
              0,
              0,
              1,
              0,
            ]),
            child: Center(
                child: SizedBox(
                    width: screenSize * 0.25,
                    height: screenSize * 0.25,
                    child: Image(image: AssetImage(icon)))),
          ));
    } else {
      return SizedBox(
          width: screenSize * 0.25,
          height: screenSize * 0.25,
          child: Image(
            image: AssetImage(icon),
          ));
    }
  }
}

//stateful buttons will grey out or not  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

// ok cancel row _______________________________
class OKCancelRow extends StatelessWidget {
  const OKCancelRow({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
        width: screenSize.width,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                print('clear selection in here');
              },
              child: SizedBox(
                  width: screenSize.width * 0.4,
                  child: const Image(image: AssetImage('images/cancel.png'))),
            ),
            InkWell(
              onTap: () {
                print('at move to selected page');
              },
              child: SizedBox(
                  width: screenSize.width * 0.4,
                  child: const Image(image: AssetImage('images/ok.png'))),
            )
          ],
        ));
  }
}
// ok cancel row ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

/// supa cool button mechanism _____________________________________

class RadioButtons extends StatefulWidget {
  int iconNumber;
  String iconImage;

  RadioButtons({super.key, required this.iconNumber, required this.iconImage});

  @override
  State<RadioButtons> createState() => _RadioButtonsState();
}

class _RadioButtonsState extends State<RadioButtons> {
  @override
  Widget build(BuildContext context) {
    final screnSize = MediaQuery.of(context).size.width;
    return // thast the first button
        SizedBox(
      width: screnSize * 0.25,
      height: screnSize * 0.25,
      child: Material(
        shape: const CircleBorder(),
        child: InkWell(
          onTap: () {
            setState(() {
              global.butArr = global.butArr[widget.iconNumber] == 1
                  ? global.allOpen
                  : global.allGray;
            });
          },
          child: GreyoutButtons(
            grayout: global.butArr[widget.iconNumber],
            icon: widget.iconImage,
          ),
        ),
      ),
    );
    // end of first button
  }
}

/// supa cool button mechanism ____^_____^____^____^____^_____^____^_____
///
///
///

/*


    print(global.butArr);
          print(widget.iconNumber);
          print(global.butArr[widget.iconNumber]);
          // eğer buton açıksa
          if (global.butArr[widget.iconNumber] == 0) {
            // let here be states
            if (global.isButtonSelected[widget.iconNumber] == 0) {
              // eğer button seçili değilse
              global.isButtonSelected[widget.iconNumber] = 1;
              global.selected = 'spf15';
              setState(() {
                global.butArr = global.allGray; // makes all gray
                global.butArr[widget.iconNumber] =
                    0; // makes current button open
              });
            } else if (global.isButtonSelected[widget.iconNumber] == 1) {
              // eğer seçili buton tekrar tıklanırsa seçim sıfırmlanır
              global.butArr = global.allOpen;
              global.selected = '';
            }
          } else {
            setState(() {
              global.butArr = global.allGray; // makes all gray
              global.butArr[widget.iconNumber] = 0;
            });
          }


*/

class GrayableRow extends StatefulWidget {
  const GrayableRow({super.key});

  @override
  State<GrayableRow> createState() => _GrayableRowState();
}

class _GrayableRowState extends State<GrayableRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Material(
          shape: const CircleBorder(),
          child: InkWell(
            onTap: () {
              print(global.butArr);
              setState(() {
                global.butArr = global.allGray;
              });
              print(global.butArr);
            },
            child: GreyoutButtons(
                icon: 'images/spf15.png', grayout: global.butArr[0]),
          ),
        ),
        Material(
          shape: const CircleBorder(),
          child: InkWell(
            onTap: () {
              global.butArr = global.allGray;
              setState(() {});
            },
            child: GreyoutButtons(
                icon: 'images/spf30.png', grayout: global.butArr[2]),
          ),
        )
      ],
    );
  }
}

void selectionMaker(int iconNumber, String iconName) {
  if (global.isButtonSelected[iconNumber] == 0) {
    // eğer buttpn önceden seçili değilse
    // seçili işsaretler
    global.isButtonSelected[iconNumber] = 1;
    // selected a işlemi ekler
    global.selected = "${global.selected + clearString(iconName)}:";
    // diğerleri graylenir kendinin rengini düzeltir
    global.butArr = global.allGray;
    global.butArr[iconNumber] = 0;
  } else {
    // eğer buton önceden seçiliyse
    // tüm seçimleri sfırlar
    global.isButtonSelected = global.allOpen;
    // slected işlemi temizler
    global.selected = "";
    // her iconun rengini düzeltir
    global.butArr = global.allOpen;
  }
}

clearString(input) {
  // input will be the button icon 'images/img.png' we need img part
  // first get part after slash
  String mem1 = input.replaceAll("images/", "");
  return mem1.substring(0, mem1.indexOf('.'));
}

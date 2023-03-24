import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'globals.dart' as global;

class GrayableNine extends StatefulWidget {
  const GrayableNine({super.key});

  @override
  State<GrayableNine> createState() => _GrayableNineState();
}

class _GrayableNineState extends State<GrayableNine> {
  List<int> butArr = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> isButtonSelected = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> allOpen = List.unmodifiable([0, 0, 0, 0, 0, 0, 0, 0, 0]);
  List<int> allGray = List.unmodifiable([1, 1, 1, 1, 1, 1, 1, 1, 1]);

  // list.unmodifiable makes list immutable so you wont change those by accident

  /// 1 means grayout

  @override
  Widget build(BuildContext context) {
    final screnSize = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // thast the first button
            SizedBox(
              width: screnSize * 0.25,
              height: screnSize * 0.25,
              child: InkWell(
                onTap: () {
                  // eğer buton açıksa
                  if (butArr[0] == 0) {
                    // let here be states
                    if (isButtonSelected[0] == 0) {
                      // eğer button seçili değilse
                      isButtonSelected[0] = 1;
                      global.selected = 'spf15';
                      setState(() {
                        butArr = allGray; // makes all gray
                        butArr[0] = 0; // makes current button open
                      });
                    } else if (isButtonSelected[0] == 1) {
                      // eğer seçili buton tekrar tıklanırsa seçim sıfırmlanır
                      butArr = allOpen;
                      global.selected = '';
                    }
                  }
                },
                child: GreyoutButtons(
                  grayout: butArr[0],
                  icon: 'images/spf15.png',
                ),
              ),
            ),
            // end of first button

            // thast the second button
            SizedBox(
              width: screnSize * 0.25,
              height: screnSize * 0.25,
              child: InkWell(
                onTap: () {
                  // let here be states
                  setState(() {
                    butArr = allGray; // makes all gray
                    butArr[1] = 0; // makes current button open
                  });
                },
                child: GreyoutButtons(
                  grayout: butArr[1],
                  icon: 'images/spf30.png',
                ),
              ),
            ),
            // end of second button
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [],
        ),
        const OKCancelRow()
      ],
    );
  }
}

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

  RadioButtons({super.key, required this.iconNumber});

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
      child: InkWell(
        onTap: () {
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
          }
        },
        child: GreyoutButtons(
          grayout: global.butArr[widget.iconNumber],
          icon: 'images/spf15.png',
        ),
      ),
    );
    // end of first button
  }
}

/// supa cool button mechanism ____^_____^____^____^____^_____^____^_____
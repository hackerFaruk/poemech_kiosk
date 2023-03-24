import 'package:flutter/material.dart';

class GrayableNine extends StatefulWidget {
  const GrayableNine({super.key});

  @override
  State<GrayableNine> createState() => _GrayableNineState();
}

class _GrayableNineState extends State<GrayableNine> {
  List<int> butArr = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> allOpen = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> allGray = [1, 1, 1, 1, 1, 1, 1, 1, 1];

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
            SizedBox(
              width: screnSize * 0.2,
              height: screnSize * 0.2,
              child: InkWell(
                onTap: () {
                  // let here be states
                },
              ),
            )
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
                    width: screenSize * 0.23,
                    height: screenSize * 0.23,
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

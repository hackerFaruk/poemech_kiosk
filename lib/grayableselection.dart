import 'dart:math';

import 'package:flutter/material.dart';
import 'globals.dart' as global;
import 'main.dart' as main;

/// GrayOutable buttons -_______________________________________________________
class GreyoutButtons extends StatelessWidget {
  final int grayout;
  final String icon;
  final int butNo;

  const GreyoutButtons(
      {super.key,
      required this.icon,
      required this.grayout,
      required this.butNo});

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
    } else if (global.isButSelected(butNo) == 1) {
      return Container(
          width: screenSize * 0.25,
          height: screenSize * 0.25,
          decoration: BoxDecoration(
              border: Border.all(width: 7.0, color: Colors.green),
              borderRadius: BorderRadius.circular(200)),
          child: Image(
            image: AssetImage(icon),
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

class GrayableRow extends StatefulWidget {
  // render trigger allows parent re render this
  final bool renderTrigger;
  const GrayableRow({super.key, required this.renderTrigger});

  @override
  State<GrayableRow> createState() => _GrayableRowState();
}

class _GrayableRowState extends State<GrayableRow> {
  @override
  Widget build(BuildContext context) {
    double padding = 30;
    global.checkDisabled();
    void setMe() {
      // boşa tıklayınca sıfırlama
      global.selected = "";
      global.revertAll();
      setState(() {});
    }

    return InkWell(
      hoverColor: Colors.transparent,
      onTap: () {
        // boşa tıklayınca sıfırlama
        global.selected = "";
        global.revertAll();
        setState(() {});
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: padding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Material(
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () {
                    selectionMaker(
                        1, global.isBut1Selected, 'images/spf30.png');
                    setState(() {});
                  },
                  child: GreyoutButtons(
                      butNo: 1, icon: 'images/spf30.png', grayout: global.but1),
                ),
              ),
              Material(
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () {
                    selectionMaker(
                        2, global.isBut2Selected, 'images/spf50.png');
                    setState(() {});
                  },
                  child: GreyoutButtons(
                      butNo: 2, icon: 'images/spf50.png', grayout: global.but2),
                ),
              ),
              Material(
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () {
                    selectionMaker(
                        3, global.isBut3Selected, 'images/spf50kid.png');
                    setState(() {});
                  },
                  child: GreyoutButtons(
                      butNo: 3,
                      icon: 'images/spf50kid.png',
                      grayout: global.but3),
                ),
              )
            ],
          ),
          SizedBox(
            height: padding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Material(
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () {
                    selectionMaker(
                        4, global.isBut4Selected, 'images/shower.png');
                    setState(() {});
                  },
                  child: GreyoutButtons(
                      butNo: 4,
                      icon: 'images/shower.png',
                      grayout: global.but4),
                ),
              ),
              Material(
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () {
                    selectionMaker(
                        5, global.isBut5Selected, 'images/moist.png');
                    setState(() {});
                  },
                  child: GreyoutButtons(
                      butNo: 5, icon: 'images/moist.png', grayout: global.but5),
                ),
              ),
              Material(
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () {
                    selectionMaker(
                        6, global.isBut6Selected, 'images/bronz.png');
                    setState(() {});
                  },
                  child: GreyoutButtons(
                      butNo: 6, icon: 'images/bronz.png', grayout: global.but6),
                ),
              )
            ],
          ),
          SizedBox(
            height: padding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Material(
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () {
                    selectionMaker(
                        7, global.isBut7Selected, 'images/change.png');
                    setState(() {});
                  },
                  child: GreyoutButtons(
                      butNo: 7,
                      icon: 'images/change.png',
                      grayout: global.but7),
                ),
              ),
              Material(
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () {
                    //selectionMaker( 8, global.isBut8Selected, 'images/wheel.png');
                    // setState(() {});
                    global.selected = "wheel:";
                    global.firstButton = 'images/wheel.png';
                    global.isBut8Selected = 1;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => main.StartProcessPage(
                                  application: global.firstButton,
                                )));
                  },
                  child: GreyoutButtons(
                      butNo: 8, icon: 'images/wheel.png', grayout: global.but8),
                ),
              ),
              Material(
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () {
                    //selectionMaker(9, global.isBut9Selected, 'images/dogbutton.png');
                    //setState(() {});
                    global.selected = "dogbutton:";
                    global.firstButton = 'images/dogbutton.png';
                    global.isBut9Selected = 1;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const main.DogBreeds()));
                  },
                  child: GreyoutButtons(
                      butNo: 9,
                      icon: 'images/dogbutton.png',
                      grayout: global.but9),
                ),
              )
            ],
          ),
          SizedBox(
            height: padding,
          ),
        ],
      ),
    );
  }
}

/// If the button is not gray, if there is no previous selection, select the button, if there is a
/// previous selection, select the button, if the button is gray, do nothing
///
/// Args:
///   butNo (int): The number of the button that is clicked.
///   isButNoSelected (int): 0 if the button is not selected, 1 if it is.
///   iconName (String): The name of the icon.
void selectionMaker(int butNo, int isButNoSelected, String iconName) {
  print(butNo);

  // globals.isbutselected basılan tuşun nceden basılıp basılmadığını gösteriyor
  // eğer birisis deli maymun gibi tuşa abanaırsa tuşu resetlicek
  //böylece seçim  oynamalarında resetlencek 10 kere aynı tuşu atama olmaacak
  if (global.isButSelected(butNo) == 1) {
    print("this but was selected before");
    global.revertAll();
  }
  if (global.isButActive(butNo) == 0) {
    if (global.isSecondSelection()) {
      // eğer önceden seçili buton varsa bu ikinci seçim seçimi ayarla
      global.secondButton = iconName;

      // duş ikinci seçimse durdur sistemi
      if (butNo == 4) {
        global.setSingleActive(butNo);
        global.setSelected(butNo);

        if (global.selected.contains(iconName)) {
          print("it is already selected");
        } else {
          global.selected = "${global.selected + clearString(iconName)}:";
        }
      } else if (isButNoSelected == 0) {
        // seçileni işaratler

        global.grayRest(butNo);

        global.setSingleActive(butNo);
        global.setSelected(butNo);

        global.selected = "${global.selected + clearString(iconName)}:";
      } else {
        // eğer buton önceden seçiliyse
        // tüm seçimleri sfırlar ve renk sıfırlar

        global.revertAll();
      }

      if (global.selected.contains("shower")) {
        print("it is already selected");
      } else {
        global.selected = "${global.selected + clearString(iconName)}:";
      }
      print(global.selected);
    }

    // eğer button gri değilse
    else if (isButNoSelected == 0) {
      // eğer hiçbir button önceden seçili değilse
      // seçili işsaretler
      global.setSelected(butNo);
      // selected a işlemi ekler

      global.selected = "${global.selected + clearString(iconName)}:";

      // diğerleri graylenir kendinin rengini düzeltir
      global.grayAll();
      global.setSingleActive(butNo);
      global.firstButton = iconName;
      // özel durumlar için seçiçi açılışlar
      // aktif kalan butonlar için
      // şaun sadece kermeler + duş mevcut
      if (butNo == 1) {
        global.setSingleActive(4);
      } else if (butNo == 2) {
        global.setSingleActive(4);
      } else if (butNo == 5) {
        global.setSingleActive(4);
      } else if (butNo == 6) {
        global.setSingleActive(4);
      } else if (butNo == 4) {
        global.setSingleActive(1);
        global.setSingleActive(2);
        global.setSingleActive(5);
        global.setSingleActive(6);
      }
    } else {
      // tüm seçimleri sfırlar ve renk sıfırlar
      global.revertAll();
    }
  } else {
    // eğer button gri ise
    //den
    null;
  }
}

/// It takes a string input, replaces all instances of 'images/' with nothing, then returns the
/// substring of the result from the beginning to the first period
///
/// Args:
///   input: the string to be cleared
///
/// Returns:
///   The name of the image without the extension.
clearString(input) {
  // input will be the button icon 'images/img.png' we need img part
  // first get part after slash
  String mem1 = input.replaceAll("images/", "");
  return mem1.substring(0, mem1.indexOf('.'));
}

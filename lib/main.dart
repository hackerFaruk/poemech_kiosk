import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'grayableselection.dart' as grayable;

void main() {
  runApp(const MainPage());
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

// A page that includes language selection__________________lang select______________________
class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 58, 98, 114),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 58, 98, 114),
          title: const Text('Language Selection'),
        ),
        body: const Center(child: SelectionButtons()),
      ),
    );
  }
}

class SelectionButtons extends StatefulWidget {
  const SelectionButtons({super.key});

  @override
  State<SelectionButtons> createState() => _SelectionButtonsState();
}

class _SelectionButtonsState extends State<SelectionButtons> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(height: 20),
        const PageBanner(bannerImg: "images/langselect.png"),
        Container(height: 20),
        SizedBox(
          width: screenSize.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                  width: screenSize.width * 0.3,
                  height: screenSize.width * 0.3,
                  child: InkWell(
                      onTap: () {
                        globals.lang = 'en';
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProcessPage(
                                    lang: 'en',
                                  )),
                        );
                      },
                      child: const Image(
                          image: AssetImage('images/flag_en.png')))),
              SizedBox(
                  width: screenSize.width * 0.3,
                  height: screenSize.width * 0.3,
                  child: InkWell(
                      onTap: () {
                        globals.lang = 'tr';
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ProcessPage(lang: 'tr')),
                        );
                      },
                      child: const Image(
                          image: AssetImage('images/flag_tr.png')))),
            ],
          ),
        ),
      ],
    );
  }

  Future<bool> loginbutton() async {
    bool connection = true;
    bool success = false;

    var url = Uri.parse("https://poemech.com.tr:3001/api/mail/emergencyButton");
    final body = json.encode({"id": "5", "mail": "info@onarfa.com"});

    var res;
    try {
      res = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: body);
    } on Exception catch (e) {
      //print(e.toString());
      connection = false;

      return success;
    }
    if (connection) {
      final Map<String, dynamic> data = json.decode(res.body);

      if (data['done'] == 'false') {
        return success;
      } else if (data['done'] == 'true') {
        success = true;

        return success;
      } else {
        return success;
      }
    } else {
      print(res.body.done);
    }
  }
}

// Langugage selection page ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^lang select^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

class PageBanner extends StatelessWidget {
  final String bannerImg;

  const PageBanner({super.key, required this.bannerImg});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SizedBox(
        width: screenSize.width,
        height: 100,
        child: Image(
          image: AssetImage(bannerImg),
        ));
  }
}

// İşlem seçim sayfası ___________ProcessPage_______________selection__________________________

class ProcessPage extends StatelessWidget {
  final String lang;
  const ProcessPage({super.key, required this.lang});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    String selection =
        lang == 'en' ? 'Please Select Application' : 'Lütfen İşlem Seçiniz';
    return SizedBox(
        width: screenSize.width,
        child: Scaffold(
            appBar: AppBar(
              leading: const BackButton(
                color: Colors.white,
              ),
              title: Text(selection),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const grayable.GrayableRow(),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        print(globals.selected);
                      },
                      child: const Text('pirnts selected global val'))
                ],
              ),
            )));
  }
}

// İşlem Seçim Sayfası ^^^^^^^^^^^^^^^^ process page^^^^^^^^^^^^^^^^ selection^^^^^^^^^^^^^^^^^^^^^^

// string clearing function _______________________________________

clearString(input) {
  // input will be the button icon 'images/img.png' we need img part
  // first get part after slash
  String mem1 = input.replaceAll("images/", "");
  return mem1.substring(0, mem1.indexOf('.'));
}

// string clearing functiom ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

// StartProcessPage ____________________

class StartProcessPage extends StatelessWidget {
  final String application;
  const StartProcessPage({super.key, required this.application});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            globals.lang == 'en' ? 'Selected Application Is ' : 'Seçili İşlem'),
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Center(
            child: SizedBox(
              width: screenSize.width * 0.5,
              height: screenSize.height * 0.5,
              child: Hero(
                  tag: application,
                  child: Image(
                    image: AssetImage(application),
                  )),
            ),
          ),
          ConditionalControlRow(
            application: application,
          ),
        ],
      ),
    );
  }
}

//StartProcessPage^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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
                Navigator.pop(context);
              },
              child: SizedBox(
                  width: screenSize.width * 0.4,
                  child: const Image(image: AssetImage('images/cancel.png'))),
            ),
            InkWell(
              onTap: () {
                print('at 441');
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

// fur control _--______________--------_-_--____-_________-___-

class FurSlection extends StatelessWidget {
  const FurSlection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              SizedBox(
                height: screenSize.width * 0.3,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                          width: screenSize.width * 0.3,
                          child: const Image(
                              image: AssetImage('images/denseFur.png'))),
                      SizedBox(
                          width: screenSize.width * 0.3,
                          child: const Image(
                              image: AssetImage('images/standartFur.png'))),
                      SizedBox(
                          width: screenSize.width * 0.3,
                          child: const Image(
                              image: AssetImage('images/thinFur.png'))),
                    ]),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SizedBox(
                    height: 50,
                    width: screenSize.width * 0.4,
                    child: const Image(image: AssetImage('images/cancel.png'))),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// fur cıntrıl ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

// Conditional Row ____________________________________________________

/// If the application is the dog button, return the FurSlection widget. If the application is the
/// wheelchair button, return the WheelChairRow widget. Otherwise, return the OKCancelRow widget
class ConditionalControlRow extends StatelessWidget {
  final String application;
  const ConditionalControlRow({super.key, required this.application});

  @override
  Widget build(BuildContext context) {
    if (application == 'images/dogbutton.png') {
      return const FurSlection();
    } else if (application == "images/wheel.png") {
      return const WheelChairRow();
    } else {
      return Column(children: const [
        SizedBox(
          height: 30,
        ),
        OKCancelRow()
      ]);
    }
  }
}

// Conditional control row ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

// Tekerlekli sandalye mode _____________________________________________

class WheelChairRow extends StatefulWidget {
  const WheelChairRow({super.key});

  @override
  State<WheelChairRow> createState() => _WheelChairRowState();
}

class _WheelChairRowState extends State<WheelChairRow> {
  int but1 = 0;
  int but2 = 0;
  int but3 = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
            onTap: () {
              setState(() {
                but1 = 0;
                but2 = 1;
                but3 = 1;
              });
            },
            child: GreyoutButtons(icon: "images/spf50.png", grayout: but1)),
        InkWell(
            onTap: () {
              setState(() {
                but1 = 1;
                but2 = 0;
                but3 = 1;
              });
            },
            child: GreyoutButtons(icon: "images/spf30.png", grayout: but2)),
        InkWell(
            onTap: () {
              setState(() {
                but1 = 1;
                but2 = 1;
                but3 = 0;
              });
            },
            child: GreyoutButtons(icon: "images/spf15.png", grayout: but3)),
      ],
    );
  }
}

// tekerlekli sandalye modu  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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

// Greyable selection______________________________________________________________

class GrayableNine extends StatefulWidget {
  const GrayableNine({super.key});
  @override
  State<GrayableNine> createState() => _GrayableNineState();

  void initState() {}
}

class _GrayableNineState extends State<GrayableNine> {
  List<int> butArr = [0, 0, 0, 0, 0, 0, 0, 0, 0];

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
            RadioButtons(iconNumber: 3, iconImage: 'images/spf15.png'),
            // end of first button

            // thast the second button
            RadioButtons(iconNumber: 1, iconImage: 'images/spf30.png'),

            // end of second button

            RadioButtons(iconNumber: 2, iconImage: 'images/spf50.png')
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

// Greyable selection ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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
        //to make button a circle
        shape: const CircleBorder(),
        child: InkWell(
          onTap: () {
            setState(() {
              globals.butArr = globals.butArr[widget.iconNumber] == 1
                  ? globals.allOpen
                  : globals.allGray;
            });
          },
          child: GreyoutButtons(
            grayout: globals.butArr[widget.iconNumber],
            icon: widget.iconImage,
          ),
        ),
      ),
    );
    // end of first button
  }
}

/// supa cool button mechanism ____^_____^____^____^____^_____^____^_____
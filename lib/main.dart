import 'dart:convert';
// ignore: unused_import
import 'dart:io';

import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'grayableselection.dart' as grayable;
import 'processcontrol.dart' as process;
import 'popupalert.dart' as pop;

void main() {
  runApp(
      const MaterialApp(home: CardScreen(), debugShowCheckedModeBanner: false));
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
      debugShowCheckedModeBanner: false,
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
                        globals.lang = 'tr';
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProcessPage(
                                    lang: 'tr',
                                  )),
                        );
                      },
                      child: const Image(
                          image: AssetImage('images/flag_tr.png')))),
              SizedBox(
                  width: screenSize.width * 0.3,
                  height: screenSize.width * 0.3,
                  child: InkWell(
                      onTap: () {
                        globals.lang = 'en';
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ProcessPage(lang: 'en')),
                        );
                      },
                      child: const Image(
                          image: AssetImage('images/flag_en.png')))),
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

    // ignore: prefer_typing_uninitialized_variables
    var res;
    try {
      res = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: body);
      // ignore: unused_catch_clause
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
    }
    /*
    else {
      null;
      //print(res.body.done);
    }
    */
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
// process page _______________________________________________________________________________
/// A stateless widget that is used to display the process page.
class ProcessPage extends StatefulWidget {
  final String lang;
  const ProcessPage({super.key, required this.lang});

  @override
  State<ProcessPage> createState() => _ProcessPageState();
}

class _ProcessPageState extends State<ProcessPage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    String selection = widget.lang == 'en'
        ? 'Please Select Application'
        : 'Lütfen İşlem Seçiniz';

// change trigger to trigger re render of child
    bool trigger = true;

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
                  grayable.GrayableRow(renderTrigger: trigger),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                          onTap: () {
                            globals.revertAll();
                            // changin trigger re renders controls
                            trigger = trigger == true ? false : true;
                            setState(() {});
                          },
                          child: SizedBox(
                            height: 60,
                            width: screenSize.width * 0.4,
                            child: const Image(
                                image: AssetImage('images/cancel.png')),
                          )),
                      InkWell(
                          onTap: () {
                            if (globals.selected.length < 2) {
                              null;
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StartProcessPage(
                                            application: globals.firstButton,
                                          )));
                            }
                          },
                          child: SizedBox(
                            height: 60,
                            width: screenSize.width * 0.4,
                            child: const Image(
                              image: AssetImage('images/ok.png'),
                            ),
                          )),
                    ],
                  )
                ],
              ),
            )));
  }
}

// İşlem Seçim Sayfası ^^^^^^^^^^^^^^^^ process page^^^^^^^^^^^^^^^^ selection^^^^^^^^^^^^^^^^^^^^^^
// Nine Process page --- process page ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Center(
              child: SizedBox(
                height: screenSize.height * 0.4,
                child: Image(
                  image: AssetImage(application),
                ),
              ),
            ),
            ConditionalControlRow(
              application: application,
            ),
          ],
        ),
      ),
    );
  }
}

//StartProcessPage^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

// ok cancel row _______________________________
class OKCancelRow extends StatelessWidget {
  final Widget? destination;
  final List<dynamic> selections;

  const OKCancelRow({super.key, this.destination, required this.selections});

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
                globals.selected = "";
                Navigator.pop(context);
              },
              child: SizedBox(
                  width: screenSize.width * 0.4,
                  child: const Image(image: AssetImage('images/cancel.png'))),
            ),
            InkWell(
              onTap: () {
                globals.selected = '';

                if (destination == null) {
                  null;
                } else if (globals.isSelectionEmpty(selections)) {
                  pop.Alert(context, 'selection');
                  // seçim uyarı dialogu çıkart burda
                } else {
                  for (var i = 0; i < selections.length; i++) {
                    globals.selected = globals.selected + selections[i];
                    globals.selected = '${globals.selected}  ';
                  }
                  globals.timeSet();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => destination!));
                }
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

// Conditional Row ____________________________________________________

/// If the application is the dog button, return the FurSlection widget. If the application is the
/// wheelchair button, return the WheelChairRow widget. Otherwise, return the OKCancelRow widget
class ConditionalControlRow extends StatelessWidget {
  final String application;
  const ConditionalControlRow({super.key, required this.application});

  @override
  Widget build(BuildContext context) {
    if (application == "images/wheel.png") {
      return const WheelChairRow();
    } else if (application == "images/shower.png") {
      return const WheelChairRow();
    } else if (application == 'images/custom.png') {
      return const CustomDogWash();
    } else if (application.contains('dog')) {
      return const DirtSelection();
    } else {
      return Column(children: [
        const SizedBox(
          height: 30,
        ),
        OKCancelRow(
          selections: [application],
          destination: process.ProcessControlPage(
            application: application,
          ),
        )
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
  int but4 = 0;
  int but5 = 0;
  int but6 = 0;
  int but7 = 0;
  int but8 = 0;
  int but9 = 0;
  String lengthselected = '';
  String warmthselected = '';
  String pressselected = '';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      onTap: () {
        globals.selected = '';
        print(globals.selected);
        setState(() {
          but1 = 0;
          but2 = 0;
          but3 = 0;
          but4 = 0;
          but5 = 0;
          but6 = 0;
          but7 = 0;
          but8 = 0;
          but9 = 0;
        });
      },
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                  onTap: () {
                    lengthselected = 'showerQuick';
                    setState(() {
                      but7 = 0;
                      but8 = 1;
                      but9 = 1;
                    });
                  },
                  child: GreyoutButtons(
                      icon: "images/showerQuick.png", grayout: but7)),
              InkWell(
                  onTap: () {
                    lengthselected = 'showerNormal';
                    setState(() {
                      but7 = 1;
                      but8 = 0;
                      but9 = 1;
                    });
                  },
                  child: GreyoutButtons(
                      icon: "images/showerNormal.png", grayout: but8)),
              InkWell(
                  onTap: () {
                    setState(() {
                      lengthselected = 'showerLong';
                      but7 = 1;
                      but8 = 1;
                      but9 = 0;
                    });
                  },
                  child: GreyoutButtons(
                      icon: "images/showerLong.png", grayout: but9)),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                  onTap: () {
                    warmthselected = 'coldwater';
                    setState(() {
                      but1 = 0;
                      but2 = 1;
                      but3 = 1;
                    });
                  },
                  child: GreyoutButtons(
                      icon: "images/coldwater.png", grayout: but1)),
              InkWell(
                  onTap: () {
                    warmthselected = 'warmwater';
                    setState(() {
                      but1 = 1;
                      but2 = 0;
                      but3 = 1;
                    });
                  },
                  child: GreyoutButtons(
                      icon: "images/warmwater.png", grayout: but2)),
              InkWell(
                  onTap: () {
                    warmthselected = 'hotwater';
                    setState(() {
                      but1 = 1;
                      but2 = 1;
                      but3 = 0;
                    });
                  },
                  child: GreyoutButtons(
                      icon: "images/hotwater.png", grayout: but3)),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                  onTap: () {
                    pressselected = 'pressLo';
                    setState(() {
                      but4 = 0;
                      but5 = 1;
                      but6 = 1;
                    });
                  },
                  child: GreyoutButtons(
                      icon: "images/pressLo.png", grayout: but4)),
              InkWell(
                  onTap: () {
                    pressselected = 'pressReg';
                    setState(() {
                      but4 = 1;
                      but5 = 0;
                      but6 = 1;
                    });
                  },
                  child: GreyoutButtons(
                      icon: "images/pressReg.png", grayout: but5)),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          OKCancelRow(
            selections: [warmthselected, pressselected, lengthselected],
            destination: const process.ProcessControlPage(
              application: 'images/wheel.png',
            ),
          )
        ],
      ),
    );
  }
}

// tekerlekli sandalye modu  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

//Dirt Selection----------------------------------

class DirtSelection extends StatefulWidget {
  const DirtSelection({super.key});

  @override
  State<DirtSelection> createState() => _DirtSelectionState();
}

class _DirtSelectionState extends State<DirtSelection> {
  int but1 = 0;
  int but2 = 0;
  int but3 = 0;
  String dirtselected = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(height: 75),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
                onTap: () {
                  dirtselected = 'dusty';
                  setState(() {
                    but1 = 0;
                    but2 = 1;
                    but3 = 1;
                  });
                },
                child: GreyoutButtons(icon: "images/dusty.png", grayout: but1)),
            InkWell(
                onTap: () {
                  dirtselected = 'dirty';
                  setState(() {
                    but1 = 1;
                    but2 = 0;
                    but3 = 1;
                  });
                },
                child: GreyoutButtons(icon: "images/dirty.png", grayout: but2)),
            InkWell(
                onTap: () {
                  dirtselected = 'grimy';
                  setState(() {
                    but1 = 1;
                    but2 = 1;
                    but3 = 0;
                  });
                },
                child: GreyoutButtons(icon: "images/grimy.png", grayout: but3)),
          ],
        ),
        Container(
          height: 75,
        ),
        OKCancelRow(
          selections: [dirtselected],
          destination: process.ProcessControlPage(
            application: globals.selected,
          ),
        )
      ],
    );
  }
}

// Dirt Selection  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

// custom dog wash page --------------------------------------

class CustomDogWash extends StatefulWidget {
  const CustomDogWash({super.key});

  @override
  State<CustomDogWash> createState() => _CustomDogWashState();
}

class _CustomDogWashState extends State<CustomDogWash> {
  int but1 = 0;
  int but2 = 0;
  int but3 = 0;
  int but4 = 0;
  int but5 = 0;
  int but6 = 0;
  int but7 = 0;
  String dirtselected = '';
  String furselected = '';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      onTap: () {
        setState(() {
          but1 = 0;
          but2 = 0;
          but3 = 0;
          but4 = 0;
          but5 = 0;
          but6 = 0;
          but7 = 0;
        });
      },
      child: Column(
        children: [
          Container(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                  onTap: () {
                    dirtselected = 'dusty';
                    setState(() {
                      but1 = 0;
                      but2 = 1;
                      but3 = 1;
                    });
                  },
                  child:
                      GreyoutButtons(icon: "images/dusty.png", grayout: but1)),
              InkWell(
                  onTap: () {
                    dirtselected = 'dirty';
                    setState(() {
                      but1 = 1;
                      but2 = 0;
                      but3 = 1;
                    });
                  },
                  child:
                      GreyoutButtons(icon: "images/dirty.png", grayout: but2)),
              InkWell(
                  onTap: () {
                    dirtselected = 'grimy';
                    setState(() {
                      but1 = 1;
                      but2 = 1;
                      but3 = 0;
                    });
                  },
                  child:
                      GreyoutButtons(icon: "images/grimy.png", grayout: but3)),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                  onTap: () {
                    furselected = 'furShort';
                    setState(() {
                      but4 = 0;
                      but5 = 1;
                      but6 = 1;
                      but7 = 1;
                    });
                  },
                  child: GreyoutButtons(
                      icon: "images/furShort.png", grayout: but4)),
              InkWell(
                  onTap: () {
                    furselected = 'furMid';
                    setState(() {
                      but4 = 1;
                      but5 = 0;
                      but6 = 1;
                      but7 = 1;
                    });
                  },
                  child:
                      GreyoutButtons(icon: "images/furMid.png", grayout: but5)),
              InkWell(
                  onTap: () {
                    furselected = 'furLong';
                    setState(() {
                      but4 = 1;
                      but5 = 1;
                      but6 = 0;
                      but7 = 1;
                    });
                  },
                  child: GreyoutButtons(
                      icon: "images/furLong.png", grayout: but6)),
              InkWell(
                  onTap: () {
                    furselected = 'furLayered';
                    setState(() {
                      but4 = 1;
                      but5 = 1;
                      but6 = 1;
                      but7 = 0;
                    });
                  },
                  child: GreyoutButtons(
                      icon: "images/furLayered.png", grayout: but7)),
            ],
          ),
          Container(
            height: 50,
          ),
          OKCancelRow(
            selections: [furselected, dirtselected],
            destination: process.ProcessControlPage(
              application: globals.selected,
            ),
          )
        ],
      ),
    );
  }
}

// custom dog wash page ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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

// Dog Breed selection Page ---------------------------------------------------------------

class DogBreeds extends StatelessWidget {
  const DogBreeds({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
      appBar: AppBar(
        title: Text(globals.lang == 'en'
            ? 'Please Select The  Breed '
            : 'Lütfen Cins Seçimi Yapınız'),
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                DogBreedButton(icon: 'images/dogAkita.png'),
                DogBreedButton(icon: 'images/dogArgentino.png'),
                DogBreedButton(icon: 'images/dogBoxer.png')
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                DogBreedButton(icon: 'images/dogCane.png'),
                DogBreedButton(icon: 'images/dogchihua.png'),
                DogBreedButton(icon: 'images/dogCocker.png')
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                DogBreedButton(icon: 'images/dogDobermann.png'),
                DogBreedButton(icon: 'images/dogGerman.png'),
                DogBreedButton(icon: 'images/dogGolden.png')
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                DogBreedButton(icon: 'images/dogMaltese.png'),
                DogBreedButton(icon: 'images/dogPomer.png'),
                DogBreedButton(icon: 'images/dogPug.png')
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                DogBreedButton(icon: 'images/dogRottweiler.png'),
                DogBreedButton(icon: 'images/dogSpaniel.png'),
                DogBreedButton(icon: 'images/custom.png')
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    ));
  }
}

class DogBreedButton extends StatelessWidget {
  final String icon;

  const DogBreedButton({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size.width;
    return Material(
      shape: const CircleBorder(),
      child: SizedBox(
        width: screenSize * 0.25,
        height: screenSize * 0.25,
        child: InkWell(
            onTap: () {
              globals.selected = icon;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          StartProcessPage(application: globals.selected)));
            },
            child: Image(image: AssetImage(icon))),
      ),
    );
  }
}

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreen();
}

class _CardScreen extends State<CardScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: screenSize.height * 0.05,
          ),
          const Image(image: AssetImage('images/Abyssos.jpg')),
          Container(
            height: screenSize.height * 0.1,
          ),
          Text(
            "LÜTFEN KARTI OKUTUNUZ!",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.blue[800],
                fontSize: screenSize.width * 0.05),
          ),
          Text(
            "PLEASE READ KEYCARD!",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.blue[800],
                fontSize: screenSize.width * 0.04),
          ),
          Container(
            height: screenSize.height * 0.2,
          ),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainPage()),
                );
              },
              icon: const Icon(Icons.skip_next))
        ],
      ),
    );
  }
}
// Dog Breed Page ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

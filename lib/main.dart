import 'package:flutter/material.dart';
import 'globals.dart' as globals;

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

// Gender Page----------------------------------------------------------
class GenderSelectionPage extends StatelessWidget {
  final String language;
  const GenderSelectionPage({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        title: const Text('Gender Selection'),
      ),
      body: Column(children: [
        Hero(
          tag: 'flagPic_$language',
          child: Container(
            color: language == 'en'
                ? const Color.fromARGB(255, 5, 40, 122)
                : const Color.fromRGBO(227, 10, 23, 1),
            child: PageBanner(
                bannerImg: language == "en"
                    ? 'images/flag_en.png'
                    : 'images/flag_tr.png'),
          ),
        ),
        Container(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
                width: screenSize.width * 0.3,
                height: screenSize.width * 0.3,
                child: ElevatedButton(
                    onPressed: () {
                      print('object');
                    },
                    child:
                        const Image(image: AssetImage('images/female.png')))),
            SizedBox(
                width: screenSize.width * 0.3,
                height: screenSize.width * 0.3,
                child: ElevatedButton(
                    onPressed: () {
                      print('object');
                    },
                    child: const Image(image: AssetImage('images/male.png'))))
          ],
        )
      ]),
    );
  }
}
// Gender Page ^^^^^^^^^^^

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                SizedBox(
                  height: 30,
                ),
                ThreeButtonRow(
                  icon1: 'images/spf15.png',
                  icon2: 'images/spf30.png',
                  icon3: 'images/spf50.png',
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 30,
                ),
                ThreeButtonRow(
                  icon1: 'images/shower.png',
                  icon2: 'images/moist.png',
                  icon3: 'images/bronz.png',
                ),
                SizedBox(
                  height: 30,
                ),
                ThreeButtonRow(
                  icon1: 'images/change.png',
                  icon2: 'images/human.png',
                  icon3: 'images/dogbutton.png',
                )
              ]),
        ),
      ),
    );
  }
}

// İşlem Seçim Sayfası ^^^^^^^^^^^^^^^^ process page^^^^^^^^^^^^^^^^ selection^^^^^^^^^^^^^^^^^^^^^^

// Buttons Row _______________________________row of 2 buttons______________________

class ButtonsRow extends StatelessWidget {
  final String icon1;
  final String icon2;

  const ButtonsRow({super.key, required this.icon1, required this.icon2});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: screenSize.width * 0.3,
            height: screenSize.width * 0.3,
            child: InkWell(
              onTap: () {
                // instead of printing use it ass command
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            StartProcessPage(application: icon1)));
              },
              child: Hero(
                tag: icon1,
                child: Image(
                  image: AssetImage(icon1),
                ),
              ),
            ),
          ),
          SizedBox(
            width: screenSize.width * 0.3,
            height: screenSize.width * 0.3,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            StartProcessPage(application: icon2)));
              },
              child: Hero(
                tag: icon2,
                child: Image(
                  image: AssetImage(icon2),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

//Buttons Row  ^^^^^^^^^^^^^^^^^^^^^^^^row of 2 buttons^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

// 3button row _________________________________________________-

class ThreeButtonRow extends StatelessWidget {
  final String icon1;
  final String icon2;
  final String icon3;

  const ThreeButtonRow(
      {super.key,
      required this.icon1,
      required this.icon2,
      required this.icon3});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: screenSize.width * 0.25,
            height: screenSize.width * 0.25,
            child: InkWell(
              onTap: () {
                // instead of printing use it ass command
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            StartProcessPage(application: icon1)));
              },
              child: Hero(
                tag: icon1,
                child: Image(
                  image: AssetImage(icon1),
                ),
              ),
            ),
          ),
          SizedBox(
            width: screenSize.width * 0.25,
            height: screenSize.width * 0.25,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            StartProcessPage(application: icon2)));
              },
              child: Hero(
                tag: icon2,
                child: Image(
                  image: AssetImage(icon2),
                ),
              ),
            ),
          ),
          SizedBox(
            width: screenSize.width * 0.25,
            height: screenSize.width * 0.25,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            StartProcessPage(application: icon3)));
              },
              child: Hero(
                tag: icon3,
                child: Image(
                  image: AssetImage(icon3),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// 3button row ^^^^^^^^-^^^^^^^^-^^^^^^^^-^^^^^^^^-^^^^^^^^-^^^^^^^^-

clearString(input) {
  // input will be the button icon 'images/img.png' we need img part
  // first get part after slash
  String mem1 = input.replaceAll("images/", "");
  return mem1.substring(0, mem1.indexOf('.'));
}

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

    return Column(
      children: [
        SizedBox(
          height: screenSize.width * 0.3,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            SizedBox(
                width: screenSize.width * 0.3,
                child: const Image(image: AssetImage('images/denseFur.png'))),
            SizedBox(
                width: screenSize.width * 0.3,
                child:
                    const Image(image: AssetImage('images/standartFur.png'))),
            SizedBox(
                width: screenSize.width * 0.3,
                child: const Image(image: AssetImage('images/thinFur.png'))),
          ]),
        )
      ],
    );
  }
}

// fur cıntrıl ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

// Conditional COntrol row

class ConditionalControlRow extends StatelessWidget {
  final String application;
  const ConditionalControlRow({super.key, required this.application});

  @override
  Widget build(BuildContext context) {
    if (application == 'images/dogbutton.png') {
      return const FurSlection();
    } else {
      return const OKCancelRow();
    }
  }
}

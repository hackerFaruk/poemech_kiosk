import 'package:flutter/material.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

// A page that includes language selection________________________________________
class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
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

// Langugage selection page ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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

// İşlem seçim sayfası ___________ProcessPage_________________________________________

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
                ButtonsRow(
                    icon1: 'images/spf15.png', icon2: 'images/spf30.png'),
                SizedBox(
                  height: 30,
                ),
                ButtonsRow(
                    icon1: 'images/spf50.png', icon2: 'images/spf50kid.png'),
                SizedBox(
                  height: 30,
                ),
                ButtonsRow(
                    icon1: 'images/shower.png', icon2: 'images/moist.png'),
                SizedBox(
                  height: 30,
                ),
                ButtonsRow(
                    icon1: 'images/bronz.png', icon2: 'images/change.png')
              ]),
        ),
      ),
    );
  }
}

// İşlem Seçim Sayfası ^^^^^^^^^^^^^^^^ process page^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

// Buttons Row _____________________________________________________

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
                print(clearString(icon1));
              },
              child: Image(
                image: AssetImage(icon1),
              ),
            ),
          ),
          SizedBox(
            width: screenSize.width * 0.3,
            height: screenSize.width * 0.3,
            child: InkWell(
              onTap: () {
                print(clearString(icon2));
              },
              child: Image(
                image: AssetImage(icon2),
              ),
            ),
          )
        ],
      ),
    );
  }
}

//Buttons Row  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

clearString(input) {
  // input will be the button icon 'images/img.png' we need img part
  // first get part after slash
  String mem1 = input.replaceAll("images/", "");
  return mem1.substring(0, mem1.indexOf('.'));
}

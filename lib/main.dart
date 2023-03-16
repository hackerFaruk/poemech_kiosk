import 'package:flutter/material.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

// A page that includes language selection
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
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GenderSelectionPage(
                                    language: 'en',
                                  )),
                        );
                      },
                      child: const Hero(
                        tag: 'flagPic_en',
                        child: Image(image: AssetImage('images/flag_en.png')),
                      ))),
              SizedBox(
                  width: screenSize.width * 0.3,
                  height: screenSize.width * 0.3,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GenderSelectionPage(
                                    language: 'tr',
                                  )),
                        );
                      },
                      child: const Hero(
                          tag: 'flagPic_tr',
                          child:
                              Image(image: AssetImage('images/flag_tr.png'))))),
            ],
          ),
        ),
      ],
    );
  }
}

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

// İşlem seçim sayfası ____________________________________________________

class ProcessPage extends StatelessWidget {
  const ProcessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}



// İşlem Seçim Sayfası ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
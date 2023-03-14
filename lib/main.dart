import 'package:flutter/material.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Selection Maker'),
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

    return Row(
      children: [
        SizedBox(
            width: screenSize.width * 0.4,
            height: screenSize.width * 0.4,
            child: ElevatedButton(
                onPressed: () {
                  print('object');
                },
                child: const Image(image: AssetImage('images/human.png')))),
        SizedBox(
            width: screenSize.width * 0.4,
            height: screenSize.width * 0.4,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DogPage()),
                  );
                },
                child: const Hero(
                    tag: 'dogpic',
                    child: Image(image: AssetImage('images/dog.png'))))),
      ],
    );
  }
}

class DogPage extends StatefulWidget {
  const DogPage({super.key});

  @override
  State<DogPage> createState() => _DogPageState();
}

class _DogPageState extends State<DogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        title: const Text('Dog Washy washy'),
      ),
      body: Column(
        children: [
          const Hero(
              tag: 'dogpic', child: Image(image: AssetImage('images/dog.png'))),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('go back'))
        ],
      ),
    );
  }
}

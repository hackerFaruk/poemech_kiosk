// ignore: file_names
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'main.dart' as mainpage;

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
          //unfocusbale column

          InkWell(
            onTap: () {
              FocusScope.of(context).previousFocus();
            },
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            child: Column(children: [
              Container(
                height: screenSize.height * 0.05,
              ),
              const Image(image: AssetImage('images/abyssos.jpg')),
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
                height: screenSize.height * 0.02,
              ),
            ]),
          ),
          // unfocusable cloumn end
          TextField(
            autofocus: true,
            onSubmitted: (value) {
              //value is entered text after Enter
              if (value == "") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const mainpage.MainPage()),
                );
              } else {
                // works only at debug
                if (kDebugMode) {
                  print(value);
                }
              }
              //you can also call any function here or make setState() to assign value to other variable
            },
          ),
          /*
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainPage()),
                );
              },
              icon: const Icon(Icons.skip_next))
              */
        ],
      ),
    );
  }
}

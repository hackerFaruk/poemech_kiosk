// ignore: file_names
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'main.dart' as mainpage;
import 'emergencyStop.dart' as emergencyStop;
import 'servicePage.dart' as servicePage;
import 'dart:typed_data';
import 'package:flutter_libserialport/flutter_libserialport.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});
  static SerialPort? port1;
  @override
  State<CardScreen> createState() => _CardScreen();
}

class _CardScreen extends State<CardScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    findPort();
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
              //const emergencyStop.emergencyStop(),
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
                // service page code  servis sayfası girişi
              } else if (value == "123456") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const servicePage.servicePage()),
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

  Future<void> findPort() async {
    List<String> available = SerialPort.availablePorts;
    print(available);
    try {
      if (CardScreen.port1 == null) {
        for (var i = 0; i < available.length; i++) {
          try {
            if (SerialPort(available[i]).productId == 22336) {
              print("vid eşitti ve port NULLSUZ" + available[i]);
              CardScreen.port1 = SerialPort(available[i]);
            }
          } catch (e) {
            print(e);
          }
        }
      }
    } catch (e) {
      print(available.length);
      if (CardScreen.port1 == null) {
        for (var i = 0; i < available.length; i++) {
          print("BURALARA YAZ GÜNÜ KAR YAĞMADI" +
              SerialPort(available[i]).productId.toString());
          try {
            if (SerialPort(available[i]).productId == 22336) {
              print("vid eşitti ve port " + available[i]);
              CardScreen.port1 = SerialPort(available[i]);
            }
          } catch (e) {
            print("HATA 1");
          }
        }
      }
    }

    // bi şekilde boş yaratmak lazım sanırım
  }
}

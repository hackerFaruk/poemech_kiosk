// ignore: file_names
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'main.dart' as mainpage;
import 'servicePage.dart' as servicePage;
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:audioplayers/audioplayers.dart';
import 'globals.dart' as globals;
import 'package:http/http.dart' as http;

import 'dart:async';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});
  static SerialPort? port1;
  static int number = 0;
  static String dus = "0";
  static String sure = "0";
  static String sicaksoguk = "0";
  static String basinc = "0";
  static String krem = "0";
  static Timer? timer;
  static TextEditingController maincontroller = TextEditingController();
  @override
  State<CardScreen> createState() => _CardScreen();
}

class _CardScreen extends State<CardScreen> {
  @override
  Widget build(BuildContext context) {
    AudioPlayer player = AudioPlayer();
    //const alarmAudioPath = "assets/service.mp3";

    final screenSize = MediaQuery.of(context).size;
    findPort();
    globals.revertAll();
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
            controller: CardScreen.maincontroller,
            onSubmitted: (value) async {
              //value is entered text after Enter

              if (value == "SPF30" ||
                  value == "SPF50" ||
                  value == "SPF50C" ||
                  value == "Kopuk" ||
                  value == "Kopek" ||
                  value == "Dezenfektan") {
                _showMyDialog(value, 0);
                Timer(Duration(seconds: 2), () {
                  readPort(value);
                });

                Timer(Duration(seconds: 4), () {
                  writePort("3", "0", "0", "0", "18");
                });

                Timer(Duration(seconds: 6), () {
                  writePort("3", "0", "0", "0", "9");
                });

                if (value == "Dezenfektan")
                  Timer(Duration(seconds: 8), () {
                    writePort("3", "0", "0", "0", "80");
                  });
                else
                  Timer(Duration(seconds: 8), () {
                    writePort("3", "0", "0", "0", "78");
                  });
                Timer(Duration(seconds: 12), () {
                  writePort("3", "0", "0", "0", "42");
                });
                Timer(Duration(seconds: 14), () {
                  CardScreen.timer = Timer.periodic(Duration(seconds: 5),
                      (Timer t) => writePort("3", "0", "0", "0", "43"));
                });
              } else if (value != "123456") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const mainpage.MainPage()),
                );
                // service page code  servis sayfası girişi
              } else if (value == "123456") {
                player.play(AssetSource("service.mp3"));

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
              print("vid eşitti ve port NULLSUZ${available[i]}");
              CardScreen.port1 = SerialPort(available[i]);
              if (CardScreen.port1 != null) {
                if (!CardScreen.port1!.isOpen) {
                  try {
                    await CardScreen.port1?.openReadWrite();
                  } catch (e) {
                    print(e);
                  }
                }
              }
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
          print(
              "BURALARA YAZ GÜNÜ KAR YAĞMADI${SerialPort(available[i]).productId}");
          try {
            if (SerialPort(available[i]).productId == 22336) {
              print("vid eşitti ve port ${available[i]}");
              CardScreen.port1 = SerialPort(available[i]);
              if (CardScreen.port1 != null) {
                if (!CardScreen.port1!.isOpen) {
                  try {
                    await CardScreen.port1?.openReadWrite();
                  } catch (e) {
                    print(e);
                  }
                }
              }
            }
          } catch (e) {
            print("HATA 1");
          }
        }
      }
    }

    // bi şekilde boş yaratmak lazım sanırım
  }

  Uint8List _stringToUint8List(String data) {
    List<int> codeUnits = data.codeUnits;
    Uint8List uint8list = Uint8List.fromList(codeUnits);
    return uint8list;
  }

  Future<void> writePort(dus, krem, number1, number2, number3) async {
    /*
    if (CardScreen.number >= 7) {
      CardScreen.number = 0;
      await CloseMk();
    }*/
    try {
      if (CardScreen.port1 != null) {
        if (!CardScreen.port1!.isOpen) {
          try {
            await OpenMk();
          } catch (e) {
            print("PORT AÇARKEN GİRİYOR HATAYA");
          }
        }
      }
      print(_stringToUint8List("<" +
          dus +
          "," +
          krem +
          "," +
          number1 +
          "," +
          number2 +
          "," +
          number3 +
          ">"));
      if (int.parse(number3) >= 10) {
        CardScreen.port1?.write(_stringToUint8List("<" +
            dus +
            "," +
            krem +
            "," +
            number1 +
            "," +
            number2 +
            "," +
            number3 +
            ">"));
      } else {
        CardScreen.port1?.write(_stringToUint8List("<" +
            dus +
            "," +
            krem +
            "," +
            number1 +
            "," +
            number2 +
            ",0" +
            number3 +
            ">"));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> readPort(value) async {
    try {
      SerialPortReader reader = SerialPortReader(CardScreen.port1!);
      Stream<String> upcomingData = reader.stream.map((data) {
        return String.fromCharCodes(data);
      });
      upcomingData.listen((data) {
        print("GELEN DATA: ");
        print(data.codeUnits);
        if (data.length < 18 && data.length > 4) {
          if (value == "SPF30" && globals.SPF30 == 0)
            globals.SPF30 = int.parse(data.codeUnitAt(1).toString());
          else if (value == "SPF50" && globals.SPF50 == 0)
            globals.SPF50 = int.parse(data.codeUnitAt(3).toString());
          else if (value == "SPF50C" && globals.SPF50C == 0)
            globals.SPF50C = int.parse(data.codeUnitAt(5).toString());
          else if (value == "Kopuk" && globals.Kopuk == 0)
            globals.Kopuk = int.parse(data.codeUnitAt(7).toString());
          else if (value == "Kopek" && globals.Kopek == 0)
            globals.Kopek = int.parse(data.codeUnitAt(9).toString());
          else if (value == "Dezenfektan" && globals.Dezenfektan == 0)
            globals.Dezenfektan = int.parse(data.codeUnitAt(11).toString());
          //BÜTÜN DEĞERLERİ SIFIRLAMAK LAZIM
          else if (value == "SPF30" && globals.SPF30 != 0) {
            if (globals.SPF30 >= int.parse(data.codeUnitAt(1).toString())) {
              globals.wrongone = 1;
              Navigator.pop(context);
              _showMyDialog(value, 2);
            } else {
              Navigator.pop(context);
              _showMyDialog(value, 1);
            }
          } else if (value == "SPF50" && globals.SPF50 != 0) {
            if (globals.SPF50 >= int.parse(data.codeUnitAt(3).toString())) {
              globals.wrongone = 2;
              Navigator.pop(context);
              _showMyDialog(value, 2);
            } else {
              Navigator.pop(context);
              _showMyDialog(value, 1);
            }
          } else if (value == "SPF50C" && globals.SPF50C != 0) {
            if (globals.SPF50C >= int.parse(data.codeUnitAt(5).toString())) {
              globals.wrongone = 3;
              Navigator.pop(context);
              _showMyDialog(value, 2);
            } else {
              Navigator.pop(context);
              _showMyDialog(value, 1);
            }
          } else if (value == "Kopuk" && globals.Kopuk != 0) {
            if (globals.Kopuk >= int.parse(data.codeUnitAt(7).toString())) {
              globals.wrongone = 4;
              Navigator.pop(context);
              _showMyDialog(value, 2);
            } else {
              Navigator.pop(context);
              _showMyDialog(value, 1);
            }
          } else if (value == "Kopek" && globals.Kopek != 0) {
            if (globals.Kopek >= int.parse(data.codeUnitAt(9).toString())) {
              globals.wrongone = 9;
              Navigator.pop(context);
              _showMyDialog(value, 2);
            } else {
              Navigator.pop(context);
              _showMyDialog(value, 1);
            }
          } else if (value == "Dezenfektan" && globals.Dezenfektan != 0) {
            if (globals.Dezenfektan >=
                int.parse(data.codeUnitAt(11).toString())) {
              globals.wrongone = 11;
              Navigator.pop(context);
              _showMyDialog(value, 2);
            } else {
              Navigator.pop(context);
              _showMyDialog(value, 1);
            }
          }
        } else if (data.length > 18) {
          //KESİN DÜZELT SAYIYI 15 16
          if (int.parse(data.codeUnitAt(15).toString()) == 0) {
            if (value != "Dezenfektan") {
              CardScreen.timer!.cancel();
              Timer(Duration(seconds: 4), () {
                writePort("3", "0", "0", "0", "42");
              });
            }
          } else if (int.parse(data.codeUnitAt(16).toString()) == 0) {
            if (value == "Dezenfektan") {
              CardScreen.timer!.cancel();
              Timer(Duration(seconds: 4), () {
                writePort("3", "0", "0", "0", "42");
              });
            }
          }
        }
      }).onError((error) {
        print("HATA ALDIM CANIM");
        print(error);
        CardScreen.port1!.close();
        readPort(value);
      });
    } catch (e) {
      print("yazamadım");
    }
  }

  Future<void> CloseMk() async {
    print("close denedim");
    if (CardScreen.port1!.isOpen) CardScreen.port1!.close();
  }

  Future<void> OpenMk() async {
    CardScreen.port1?.openReadWrite();
  }

  Future<void> _showMyDialog(String cream, int ok) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bakım Modu'),
          content: SingleChildScrollView(
            child: ok == 0
                ? Text("$cream Dolumu bekleniyor")
                : ok == 1
                    ? const Text("İşlem Başarılı")
                    : Text("$cream Dolumu için yanlış tank kullanıldı."),
          ),
          actions: <Widget>[
            TextButton(
              child: ok == 1 || ok == 2
                  ? const Text('Onayla')
                  : const Text('Bekleniyor'),
              onPressed: () {
                if (ok == 1 || ok == 2) {
                  Navigator.of(context).pop();
                  CardScreen.maincontroller.clear();
                  CloseMk();
                  if (ok == 2) {
                    wrongTankMail();
                  }
                } else {}
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> wrongTankMail() async {
    bool connection = true;

    var url = Uri.parse("https://poemech.com.tr:3001/api/mail/emergencyButton");
    final body =
        json.encode({"id": "AB010723/01", "mail": "kacaryucel@gmail.com"});

    // ignore: prefer_typing_uninitialized_variables
    var res;
    try {
      res = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: body);
      // ignore: unused_catch_clause
    } on Exception catch (e) {
      //print(e.toString());
      connection = false;
    }
    if (connection) {
      final Map<String, dynamic> data = json.decode(res.body);

      if (data['done'] == 'false') {
      } else if (data['done'] == 'true') {
      } else {}
    }
  }
}

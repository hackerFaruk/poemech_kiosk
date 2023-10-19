// ignore: file_names
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'emergencyPage.dart' as emergency;
import 'package:http/http.dart' as http;
import 'processcontrol.dart' as process;
import 'pinControls.dart' as pins;

// write  staefulW for stateful widget and rename

class emergencyStop extends StatefulWidget {
  const emergencyStop({super.key});

  @override
  State<emergencyStop> createState() => _emergencyStopState();
}

class _emergencyStopState extends State<emergencyStop> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260.0,
      child: Center(
        child: InkWell(
            onTap: () {
              pins.activate();
              process.ProcessControlPage.music.stop();
              process.ProcessControlPage.music.play(AssetSource("alarm.mp3"));
              emergencyMail();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const emergency.emergencyPage()),
              );
            },
            child: const SizedBox(
                height: 200.0,
                child: Image(image: AssetImage('images/emg2.png')))),
      ),
    );
  }

  void emergencyMail() async {
    bool connection = true;

    var url = Uri.parse("https://poemech.com.tr:3001/api/mail/emergencyButton");
    final body = json.encode({"id": "AB010723/01", "mail": "info@onarfa.com"});

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

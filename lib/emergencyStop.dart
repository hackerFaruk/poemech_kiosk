// ignore: file_names
import 'package:flutter/material.dart';
import 'emergencyPage.dart' as emergency;

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
      height: 130.0,
      child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const emergency.emergencyPage()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(0, 0, 0, 0), // Background color
          ),
          child: const Image(image: AssetImage('images/emg.png'))),
    );
  }
}

// ignore: file_names
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'emergencyPage.dart';
import 'main.dart' as mainpage;
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
    return ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const emergency.emergencyPage()),
          );
        },
        child: const Text('EmergencyStop'));
  }
}

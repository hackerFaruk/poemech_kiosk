// ignore: file_names
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'main.dart' as mainpage;

// write  staefulW for stateful widget and rename

class emergencyStop extends StatefulWidget {
  const emergencyStop({super.key});

  @override
  State<emergencyStop> createState() => _emergencyStopState();
}

class _emergencyStopState extends State<emergencyStop> {
  @override
  Widget build(BuildContext context) {
    return const ElevatedButton(onPressed: null, child: Text('EmergencyStop'));
  }
}

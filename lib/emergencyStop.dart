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
      height: 260.0,
      child: Center(
        child: InkWell(
            onTap: () {
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
}

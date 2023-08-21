// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class emergencyPage extends StatefulWidget {
  const emergencyPage({super.key});

  @override
  State<emergencyPage> createState() => _emergencyPageState();
}

class _emergencyPageState extends State<emergencyPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Image(image: AssetImage('images/emg.png')),
      ),
    );
  }
}

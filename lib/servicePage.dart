import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class servicePage extends StatefulWidget {
  const servicePage({super.key});

  @override
  State<servicePage> createState() => _servicePageState();
}

class _servicePageState extends State<servicePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Sample Code'),
      ),
      body: const Center(child: Text('You have pressed the button times.')),
    ));
  }
}

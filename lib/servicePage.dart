import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'serviceButtonsGrid.dart' as serviceButtonsGrid;

class servicePage extends StatefulWidget {
  const servicePage({super.key});

  @override
  State<servicePage> createState() => _servicePageState();
}

// ignore: camel_case_types
class _servicePageState extends State<servicePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Servis Moduna Girildi'),
      ),
      body: const serviceButtonsGrid.ButtonGrid(),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'serviceButtonsGrid.dart' as serviceButtonsGrid;

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
        title: const Text('Servis Moduna Girildi'),
      ),
      body: serviceButtonsGrid.ButtonGrid(),
    ));
  }
}

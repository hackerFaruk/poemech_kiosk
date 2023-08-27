import 'package:flutter/material.dart';
import 'buttonList.dart' as buttonList;

class ButtonGrid extends StatefulWidget {
  const ButtonGrid({super.key});

  @override
  State<ButtonGrid> createState() => _ButtonGridState();
}

class _ButtonGridState extends State<ButtonGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Change this value according to your layout
      ),
      itemCount: buttonList.buttonNames.length,
      itemBuilder: (context, index) {
        return ElevatedButton(
          onPressed: () => print(buttonList.buttonNames[index]),
          child: Text(buttonList.buttonNames[index]),
        );
      },
    );
  }
}

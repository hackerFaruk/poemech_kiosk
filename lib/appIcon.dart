import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class appIcon extends StatefulWidget {
  const appIcon({super.key});

  @override
  State<appIcon> createState() => _appIconState();
}

class _appIconState extends State<appIcon> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// eğer iki ikon seçili ise iki tane : işareti olacak
// bu eskiden hataydı şimdi ise feature
bool isDualIcon() {
  String text = globals.selected;

  int count = 0;

  for (int i = 0; i < text.length; i++) {
    if (text[i] == ":") {
      count++;
    }
  }

  if (count >= 2) {
    return true;
  } else {
    return false;
  }
}

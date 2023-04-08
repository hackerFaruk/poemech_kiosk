import 'package:flutter/material.dart';
import 'globals.dart' as globals;

String title = '';
String description = '';
String button = '';

// ignore: non_constant_identifier_names
Alert(BuildContext context, inputtext) {
  selector(inputtext);
  // set up the button
  Widget okButton = TextButton(
    child: Text(button),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop(); // dismiss dialog
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(description),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void selector(String alert) {
  if (alert == 'selection') {
    if (globals.lang == 'en') {
      title = 'Missing Selections';
      description = 'Please Make A Selection At Each Row';
      button = 'Ok';
    } else {
      title = 'Eksik Seçim';
      description = 'Lütfen Her Satırdan Bir Seçim Yapınız';
      button = 'Tamam';
    }
  }
}

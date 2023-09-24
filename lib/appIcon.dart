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
    final screenSize = MediaQuery.of(context).size;

    if (isDualIcon()) {
      return Container();
    } else {
      String singleIcon = globals.selected;
      return Center(
          child: SizedBox(
        height: screenSize.height * 0.3,
        width: screenSize.height * 0.3,
        child: Image(
          image: AssetImage(iconToPath(singleIcon)),
        ),
      ));
    }
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

String detectSecondIcon() {
  String input = globals.selected;

  // shower girdisini siler çünkü ikikli seçimde shower hep olacak
  input = input.replaceAll("shower", "");
  // iki noktalarıda sileriz
  input = input.replaceAll(":", "");
  //artık sonu döndürmek mümkün
  return input;
}

// grayable selecctiionda clear string var
// bu stringtedki images/ şeyinisiler ve icn smi kalır
// biz bunu geri eklicez ve icon pathı bulunacak sihirr
String iconToPath(String icon) {
  return "images/$icon.png";
}




// selected height is 

//              height: screenSize.height * 0.3,
//                width: screenSize.height * 0.3,
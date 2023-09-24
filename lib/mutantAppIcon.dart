import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class mutantAppIcon extends StatefulWidget {
  const mutantAppIcon({super.key});

  @override
  State<mutantAppIcon> createState() => _mutantAppIconState();
}

class _mutantAppIconState extends State<mutantAppIcon> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    if (globals.isDualIconMemo == "true") {
      return SizedBox(
        height: screenSize.height * 0.22,
        width: screenSize.height * 0.5,
        child: Row(
          children: [
            const Image(
              image: AssetImage('images/shower.png'),
            ),
            SizedBox(
              width: screenSize.height * 0.06,
            ),
            Image(
              image: AssetImage(globals.secondIcon),
            ),
          ],
        ),
      );
    } else {
      return Center(
          child: SizedBox(
        height: screenSize.height * 0.3,
        width: screenSize.height * 0.3,
        child: Image(
          image: AssetImage(globals.firstIconMemo),
        ),
      ));
    }
  }
}

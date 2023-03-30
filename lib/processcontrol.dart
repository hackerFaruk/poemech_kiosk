import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class ProcessControlPage extends StatelessWidget {
  final String application;

  const ProcessControlPage({super.key, required this.application});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              globals.lang == 'en' ? ' Ongoing Process ' : 'İşlem Sürüyor'),
          leading: const BackButton(
            color: Colors.white,
          ),
        ),
        body: Column(
          children: [
            Center(
              child: SizedBox(
                width: screenSize.width * 0.5,
                height: screenSize.height * 0.5,
                child: Hero(
                    tag: application,
                    child: Image(
                      image: AssetImage(application),
                    )),
              ),
            ),
            EmergencyControls(),
          ],
        ),
      ),
    );
  }
}

class EmergencyControls extends StatefulWidget {
  const EmergencyControls({super.key});

  @override
  State<EmergencyControls> createState() => _EmergencyControlsState();
}

class _EmergencyControlsState extends State<EmergencyControls> {
  bool isProcessOngoing = false;
  var StartQuery = globals.lang == 'en'
      ? 'Click To Start '
      : 'İşlemi Başlatmak İçin Tıklaynız';

  var StopQuery = globals.lang == 'en'
      ? 'Click for Emergency Stop'
      : 'Acil Durdurma İçin Tıklayınız';

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size.width;
    return Material(
      child: Column(
        children: [
          SizedBox(
            height: 60,
            width: screenSize,
            child: Center(
                child:
                    Text(isProcessOngoing == false ? StartQuery : StopQuery)),
          ),
          InkWell(
            onTap: () {
              setState(() {
                isProcessOngoing = isProcessOngoing == false ? true : false;
              });
            },
            child: SizedBox(
              height: 70,
              width: screenSize * 0.5,
              child: Image(
                  image: AssetImage(isProcessOngoing == false
                      ? 'images/ok.png'
                      : 'images/cancel.png')),
            ),
          )
        ],
      ),
    );
  }
}

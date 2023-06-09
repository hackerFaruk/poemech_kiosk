import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'stopwatch.dart' as stop;

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
                child: Image(
                  image: AssetImage(application),
                ),
              ),
            ),
            const EmergencyControls(),
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
  // ignore: non_constant_identifier_names
  var StartQuery = globals.lang == 'en'
      ? 'Click To Start '
      : 'İşlemi Başlatmak İçin Tıklaynız';

  // ignore: non_constant_identifier_names
  var StopQuery = globals.lang == 'en'
      ? 'Click for Emergency Stop'
      : 'Acil Durdurma İçin Tıklayınız';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: const [
          stop.StopWatch(),
        ],
      ),
    );
  }
}

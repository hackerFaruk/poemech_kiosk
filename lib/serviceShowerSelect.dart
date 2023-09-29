import 'package:flutter/material.dart';
import 'servicePage.dart' as servicePage;
import 'main.dart' as mainPage;

class serviceShowerelect extends StatefulWidget {
  const serviceShowerelect({super.key});

  @override
  State<serviceShowerelect> createState() => _serviceShowerelectState();
}

class _serviceShowerelectState extends State<serviceShowerelect> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Service Mode'),
        ),
        body: Center(
            child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const servicePage.servicePage()),
                  ),
                  child: const Image(
                      image: AssetImage("images/serviceSelect.png")),
                ),
                const SizedBox(width: 10),
                InkWell(
                    onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const mainPage.MainPage()),
                        ),
                    child: const Image(
                        image: AssetImage("images/serviceShower.png")))
              ],
            )
          ],
        )),
      ),
    );
  }
}

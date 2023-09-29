import 'package:flutter/material.dart';
import 'servicePage.dart' as servicePage;
import 'main.dart' as mainPage;

class serviceShowerSelect extends StatefulWidget {
  const serviceShowerSelect({super.key});

  @override
  State<serviceShowerSelect> createState() => _serviceShowerSelectState();
}

class _serviceShowerSelectState extends State<serviceShowerSelect> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

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
            SizedBox(
              height: screenSize.width * 0.1,
              width: screenSize.width,
            ),
            Center(
              child: Row(
                children: [
                  SizedBox(width: screenSize.width * 0.1),
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const servicePage.servicePage()),
                    ),
                    child: SizedBox(
                      width: screenSize.width * 0.3,
                      child: Column(
                        children: const [
                          Image(image: AssetImage("images/serviceSelect.png")),
                          Text("Service Mode", style: TextStyle(fontSize: 26))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: screenSize.width * 0.2),
                  InkWell(
                      onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const mainPage.MainPage()),
                          ),
                      child: SizedBox(
                        width: screenSize.width * 0.3,
                        child: Column(
                          children: const [
                            Image(image: AssetImage("images/showerSelect.png")),
                            Text("Shower Menu", style: TextStyle(fontSize: 26)),
                          ],
                        ),
                      ))
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}

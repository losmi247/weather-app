import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen2.dart';
import 'package:flutter_application_1/study_outside_screen.dart';

class Screen1 extends StatelessWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text("Weather App")),
          body: Column(
            children: [
              ElevatedButton(
                child: const Text("Settings"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Screen2()),
                  );
                },
              ),
              ElevatedButton(
                child: const Text("study outside screen test"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StudyOutsideScreen()),
                  );
                },
              ),
            ],
          )),
    );
  }
}

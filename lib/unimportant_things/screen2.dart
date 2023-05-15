import 'package:flutter/material.dart';
import 'package:flutter_application_1/unimportant_things/screen3.dart';

class Screen2 extends StatelessWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Settings")
        ),
        body: Column(
          children: [
            ElevatedButton(
              child: const Text("Back"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: const Text("Location Settings"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Screen3()),
                );
              },
            ),
          ],
        )
      ),
    );
  }
}
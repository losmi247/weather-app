import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom_components/pallete.dart';
import 'package:flutter_application_1/study_outside_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData.dark().copyWith(
        disabledColor: Pallete.settingsSwitchListTileInactiveThumbColor,
        //scaffoldBackgroundColor: Pallete.upperBackgroundColor,
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold, fontFamily: 'Roboto', color: Colors.black),
          titleLarge: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, fontFamily: 'Roboto', color: Colors.black),
          bodyMedium: TextStyle(fontSize: 18.0, fontFamily: 'Roboto', color: Colors.black),  
        )
      ),
      home: const StudyOutsideScreen(),
    );
  }
}

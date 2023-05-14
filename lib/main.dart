import 'package:flutter/material.dart';
import 'package:flutter_application_1/pallete.dart';
import 'package:flutter_application_1/screen1.dart';
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
        scaffoldBackgroundColor: Pallete.backgroundColor,
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
          titleLarge: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
          bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Roboto'),  
        )
      ),
      home: const StudyOutsideScreen(),
    );
  }
}

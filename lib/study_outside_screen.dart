import 'package:flutter/material.dart';
import 'package:flutter_application_1/settings_screen.dart';

class StudyOutsideScreen extends StatefulWidget {
  const StudyOutsideScreen({Key? key}) : super(key: key);
  @override
  _StudyOutsideScreenState createState() => _StudyOutsideScreenState();
}

class _StudyOutsideScreenState extends State<StudyOutsideScreen> {
  double _sliderValue = 0.0;
  bool _isCelsius = true;
  double _minTemp = 18.0;
  double _maxTemp = 25.0;
  bool _isLocationEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Outside'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Graphic goes here',
                  style: TextStyle(fontSize: 32.0),
                ),
              ),
            ),
            Slider(
              value: _sliderValue,
              min: 0.0,
              max: 100.0,
              divisions: 20,
              label: '${_sliderValue.toInt()}',
              onChanged: (value) {
                setState(() {
                  _sliderValue = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Current weather conditions go here',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingsScreen(
                            isCelsius: _isCelsius,
                            minTemp: _minTemp,
                            maxTemp: _maxTemp,
                          )),
                );
              },
              child: Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

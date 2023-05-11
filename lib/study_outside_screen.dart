import 'package:flutter/material.dart';
import 'package:flutter_application_1/preferences.dart';
import 'package:flutter_application_1/settings_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StudyOutsideScreen extends StatefulWidget {
  const StudyOutsideScreen({Key? key}) : super(key: key);
  @override
  _StudyOutsideScreenState createState() => _StudyOutsideScreenState();
}

class _StudyOutsideScreenState extends State<StudyOutsideScreen> {
  double _sliderValue = 0.0;
  bool _isLocationEnabled = true;
  Preferences preferences = Preferences(isCelsius: true, minTemp: 18.0, maxTemp: 25.0, 
                                        workInRain: false, workInSnow: false, 
                                        workInWind: false, workAtNight: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Study Outside'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        //move top of container to top of screen
        alignment: AlignmentDirectional.topCenter,
        padding: EdgeInsets.all(16.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.3, // 30% of screen height
              //child: Expanded(
                child: Container(
                    alignment: AlignmentDirectional.center,
                    child: SvgPicture.asset("images/sun.svg", fit: BoxFit.contain,)
                    // child: Text(
                    //   'Graphic goes here',
                    //   style: TextStyle(fontSize: 32.0),
                    // ),
                    ),
              //),
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
            Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      // 'assets/icons/feels_like.svg',
                      "images/red.svg",
                      width: 24.0,
                      height: 24.0,
                    ),
                    // SvgPicture.asset("images/sun.svg"),
                    SizedBox(width: 16.0),
                    Text('Feels like ${preferences.isCelsius ? '40°C' : '104°F'}'),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    SvgPicture.asset(
                      'images/red.svg',
                      width: 24.0,
                      height: 24.0,
                    ),
                    // Container(
                    //   width: 24,
                    //   height: 24,
                    //   color: Colors.red,
                    // ),
                    SizedBox(width: 16.0),
                    Text('Strong winds'),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    SvgPicture.asset(
                      'images/red.svg',
                      width: 24.0,
                      height: 24.0,
                    ),
                    SizedBox(width: 16.0),
                    Text('Not too sunny'),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    SvgPicture.asset(
                      'images/red.svg',
                      width: 24.0,
                      height: 24.0,
                    ),
                    SizedBox(width: 16.0),
                    Text('Sunrise is in 35 minutes'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                /// push the second screen and wait for updated preferences
                awaitReturnPreferencesFromSettingsScreen(context);
              },
              child: Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }

  /// awaits for the returned preferences from the settings screen
  /// and updates the preferences on stored on this screen so that 
  /// we can access them later
  void awaitReturnPreferencesFromSettingsScreen(BuildContext context) async {
    final Preferences returnedPreferences = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsScreen(preferences: preferences)
                                  ),
                        );
    setState(() {
      //preferences = Preferences.copy(returnedPreferences);
      preferences.isCelsius = returnedPreferences.isCelsius;
      preferences.minTemp = returnedPreferences.minTemp;
      preferences.maxTemp = returnedPreferences.maxTemp;
      preferences.workAtNight = returnedPreferences.workAtNight;
      preferences.workInRain = returnedPreferences.workInRain;
      preferences.workInSnow = returnedPreferences.workInSnow;
      preferences.workInWind = returnedPreferences.workInWind;
    });
  }
}

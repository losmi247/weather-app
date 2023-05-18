import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom_components/slider.dart';
import 'package:flutter_application_1/custom_components/pallete.dart';
import 'package:flutter_application_1/custom_components/preferences.dart';
import 'package:flutter_application_1/settings_screen.dart';
import 'package:flutter_application_1/weather_api_client.dart';
import 'package:flutter_application_1/weather_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'util.dart';

class StudyOutsideScreen extends StatefulWidget {
  const StudyOutsideScreen({Key? key}) : super(key: key);
  @override
  _StudyOutsideScreenState createState() => _StudyOutsideScreenState();
}

class _StudyOutsideScreenState extends State<StudyOutsideScreen> {
  //double _sliderValue = 0.0;
  /// TO GET SLIDER VALUE - slider.value
  SliderWithTimeLabels slider =
      SliderWithTimeLabels(minValue: 0, maxValue: 720, initialValue: 60);
  /// TO GET MIN/MAX TEMP VALUE - preferences.minTemp, preferences.maxTemp
  /// (these are getters, not fields)
  Preferences preferences = Preferences.defaultPreferences();

  late final Timer timer;

  int _index = 0;

  @override
  void initState() {
    super.initState();
    getData();
    timer = Timer.periodic(const Duration(milliseconds: 180), (timer) {
      setState(() => _index++);
    });
  }

  final values = [
    // 'sun-l.svg',
    // 'sun-ml.svg',
    // 'sun-m.svg',
    // 'sun-mr.svg',
    // 'sun-r.svg',
    // 'sun-mr.svg',
    // 'sun-m.svg',
    // 'sun-ml.svg',
    'angry-thunder/thunder-1.svg',
    'angry-thunder/thunder-2.svg',
    'angry-thunder/thunder-3.svg',
    'angry-thunder/thunder-4.svg',
    'angry-thunder/thunder-5.svg',
    'angry-thunder/thunder-6.svg',
    'angry-thunder/thunder-7.svg',
    'angry-thunder/thunder-8.svg',
  ];

  final animations = {
    'angry-thunder': [
      'angry-thunder/thunder-1.svg',
      'angry-thunder/thunder-2.svg',
      'angry-thunder/thunder-3.svg',
      'angry-thunder/thunder-4.svg',
      'angry-thunder/thunder-5.svg',
      'angry-thunder/thunder-6.svg',
      'angry-thunder/thunder-7.svg',
      'angry-thunder/thunder-8.svg',
    ],
    'happy-sun': [
      'sun-l.svg',
      'sun-ml.svg',
      'sun-m.svg',
      'sun-mr.svg',
      'sun-r.svg',
      'sun-mr.svg',
      'sun-m.svg',
      'sun-ml.svg',
    ],
    'happy-cloud': [
      'happy-cloud/happy-cloud-1.svg',
      'happy-cloud/happy-cloud-2.svg',
      'happy-cloud/happy-cloud-3.svg',
      'happy-cloud/happy-cloud-4.svg',
      'happy-cloud/happy-cloud-5.svg',
      'happy-cloud/happy-cloud-6.svg',
      'happy-cloud/happy-cloud-7.svg',
      'happy-cloud/happy-cloud-8.svg',
      'happy-cloud/happy-cloud-9.svg',
      'happy-cloud/happy-cloud-10.svg',
      'happy-cloud/happy-cloud-11.svg',
    ],
    'hot-sun': [
      'hot-sun/sun-too-hot-l.svg',
      'hot-sun/sun-too-hot-ml.svg',
      'hot-sun/sun-too-hot-m.svg',
      'hot-sun/sun-too-hot-mr.svg',
      'hot-sun/sun-too-hot-r.svg',
      'hot-sun/sun-too-hot-mr.svg',
      'hot-sun/sun-too-hot-m.svg',
      'hot-sun/sun-too-hot-ml.svg',
    ],
    'too-windy': [
      'too-windy/too-windy-1.svg',
      'too-windy/too-windy-2.svg',
      'too-windy/too-windy-3.svg',
      'too-windy/too-windy-4.svg',
      'too-windy/too-windy-5.svg',
      'too-windy/too-windy-6.svg',
      'too-windy/too-windy-7.svg',
    ],
    'rain': [
      'rain/rain-1.svg',
      'rain/rain-2.svg',
      'rain/rain-3.svg',
      'rain/rain-4.svg',
      'rain/rain-5.svg',
    ]
  };

  String getAnimationFrame(animationID, index) {
    final animation = animations[animationID];
    if (animation == null) {
      throw Exception('Animation $animationID not found');
    }
    // print('hello');
    // _index++;
    return 'assets/images/${animation[index % animation.length]}';
  }

  WeatherApiClient client = WeatherApiClient();
  Weather? data;

  Future<void> getData() async {
    // // sleep for 200ms
    // await Future.delayed(Duration(milliseconds: 200));

    data = await client.getWeather(preferences.selectedLocation);
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String feelsLikeTempText() {
    if (data == null) {
      return 'Loading...';
    }
    return 'Feels like ${Util.getStringForTemperature(data!.feelsLike![0].round(), preferences.isCelsius)}';
  }

  String windSpeedText() {
    if (data == null) {
      return 'Loading...';
    }
    return '${data!.windDescription![0]}';
  }

  // capitalize first letter
  String capitaliseFirstLetter(String string) {
    return '${string[0].toUpperCase()}${string.substring(1)}';
  }

  String weatherDescriptionText() {
    if (data == null) {
      return 'Loading...';
    }
    return capitaliseFirstLetter('${data!.description![0]}');
  }

  String sunriseOrSunsetText() {
    if (data == null) {
      return 'Loading...';
    }
    return data!.timeToSunriseOrSunset();
  }

  String checkRain(int hours) {
    // loop through rain data for each hour and return false if over 0.3
    for (int i = 0; i <= hours; i++) {
      if (data!.rainChance![i] > 0.3) {
        return 'It\'s going to rain in the next $hours hours';
      }
    }
    return 'No rain in the next $hours hours';
  }

  String checkWind(int hours) {
    // loop through wind data for each hour and return false if over
    for (int i = 0; i <= hours; i++) {
      if (data!.wind![i] >= 14) {
        return 'It\'s going to be a ${data!.windDescription![i]} in the next $hours hours';
      }
    }
    return 'Not too windy in the next $hours hours';
  }

  String checkTemp(int hours) {
    // loop through temp data for each hour and return false if outside of selected min and max
    for (int i = 0; i <= hours; i++) {
      if (data!.feelsLike![i] < preferences.minTemp) {
        if (i == 0) {
          return 'It\'s too cold right now';
        }

        return 'It\'s going to be too cold in $i hours';
      } else if (data!.feelsLike![i] > preferences.maxTemp) {
        if (i == 0) {
          return 'It\'s too hot right now';
        }

        return 'It\'s going to be too hot in $i hours';
      }
    }
    return 'It\'s going to be a comfortable temperature for $hours hours';
  }

  // return tuple of bool and string
  // bool is true if conditions are met
  // string is the text to display

  List checkTemp2(int hours) {
    // loop through temp data for each hour and return false if outside of selected min and max
    for (int i = 0; i <= hours && i < data!.wind!.length; i++) {
      if (data!.feelsLike![i] < preferences.minTemp) {
        if (i == 0) {
          return [false, 'It\'s too cold right now'];
        }

        return [false, 'It\'s going to be too cold in $i hours'];
      } else if (data!.feelsLike![i] > preferences.maxTemp) {
        if (i == 0) {
          return [false, 'It\'s too hot right now'];
        }

        return [false, 'It\'s going to be too hot in $i hours'];
      }
    }

    if (hours == 0) {
      return [true, 'It\'s a comfortable temperature right now'];
    }

    return [
      true,
      'It\'s going to be a comfortable temperature for $hours hours'
    ];
  }

  List checkWind2(int hours) {
    // loop through wind data for each hour and return false if over
    for (int i = 0; i <= hours && i < data!.wind!.length; i++) {
      if (data!.wind![i] >= 14) {
        return [
          false,
          'There will be a ${data!.windDescription![i]} in $hours hours'
        ];
      }
    }
    return [true, 'Not too windy in the next $hours hours'];
  }

  List checkRain2(int hours) {
    // loop through rain data for each hour and return false if over 0.3
    for (int i = 0; i <= hours && i < data!.wind!.length; i++) {
      if (data!.rainChance![i] > 0.3) {
        if (i == 0) {
          return [false, 'It\'s raining now'];
        }

        return [false, 'It\'s going to rain in the next $hours hours'];
      }
    }
    return [true, 'No rain in the next $hours hours'];
  }

  String checkConditions(int hours) {
    // call check temp -> (inBounds: bool, text: String)
    // call check wind -> (inBounds, text)
    // call check rain -> (inBounds, text)

    // if all inBounds are true, return comfortable

    // if any inBounds are false, return the text of the first one that is false

    List temp = checkTemp2(hours);
    List wind = checkWind2(hours);
    List rain = checkRain2(hours);

    if (!rain[0] && !preferences.workInRain) {
      return rain[1];
    }

    if (!wind[0] && !preferences.workInWind) {
      return wind[1];
    }

    if (!temp[0]) {
      return temp[1];
    }

    return temp[1];
  }

  /// RELATIVE POSITIONING (screen height):
  /// 0.07 - settings button
  /// 0.3 - weather graphic
  /// 0.04 - sizedbox
  /// 0.1 - slider
  /// 0.02 - sizedbox
  /// 0.03 - "Current location is Oxford"
  /// 0.02 sizedbox
  /// 0.03 - currentweather conditions go here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        /*leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () => Navigator.pop(context),
        ),*/
        title: Text('Study Outside'),
        //automaticallyImplyLeading: false,
      ),*/
      body: Container(
        //move top of container to top of screen
        alignment: AlignmentDirectional.topCenter,
        padding: EdgeInsets.all(16.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
              child: Stack(
                children: [
                  Positioned(
                    top: 5,
                    right: 5,

                    /// Button to go to 'Settings' screen
                    child: IconButton(
                      icon: SvgPicture.asset("assets/images/gear.svg"),
                      onPressed: () {
                        /// push the 'Settings' screen and wait for updated preferences
                        awaitReturnPreferencesFromSettingsScreen(context);
                      },
                      //child: Text('Settings'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.3, // 30% of screen height
              //child: Expanded(
              child: Stack(children: [
                Container(
                    alignment: AlignmentDirectional.center,
                    child: SvgPicture.asset(
                      // getAnimationFrame('happy-sun', _index),
                      getAnimationFrame('angry-thunder', _index),
                      // getAnimationFrame('happy-cloud', _index),
                      // getAnimationFrame('hot-sun', _index),
                      // getAnimationFrame('too-windy', _index),
                      // getAnimationFrame('rain', _index),
                      fit: BoxFit.cover,
                    )),

                /// PREVIOUS POSITION OF BUTTON
                /*Positioned(
                        top: 5,
                        right: 5,

                        /// Button to go to 'Settings' screen
                        child: IconButton(
                          icon: SvgPicture.asset("assets/images/gear.svg"),
                          onPressed: () {
                            /// push the 'Settings' screen and wait for updated preferences
                            awaitReturnPreferencesFromSettingsScreen(context);
                          },
                          //child: Text('Settings'),
                        ),
                      ),*/
              ]),
              //),
            ),
            /*SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbColor: Pallete.sliderThumbColor,
                      //thumbShape:
                    ),
                    child: Slider(
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
                      activeColor: Pallete.sliderActiveColor,
                      inactiveColor: Pallete.sliderInactiveColor,
                    ),
                  ),*/
            /*const SliderWithLabels(
                    minValue: 0,
                    maxValue: 12,
                    initialValue: 0,
                  ),*/
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            /////// SLIDER
            slider,
            /////// SLIDER
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
                child: Center(
                  child: Text(
                    'The current location is set to ${preferences.selectedLocation}',
                    style: const TextStyle(fontSize: 20.0),
                  ),
                )),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
              child: Text(
                checkConditions(getNumHoursStudy()),
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      // 'assets/icons/feels_like.svg',
                      "assets/images/red.svg",
                      width: 24.0,
                      height: 24.0,
                    ),
                    // SvgPicture.asset("images/sun.svg"),
                    SizedBox(width: 16.0),
                    Text(feelsLikeTempText()),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.4),
                    // Text(checkTemp(getNumHoursStudy()))
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                      child: OverflowBox(
                        alignment: Alignment.center,
                        minWidth: 0.0,
                        minHeight: 0.0,
                        maxWidth: 56,
                        maxHeight: 36,
                        child: SvgPicture.asset(
                          "assets/images/too-windy/too-windy-7.svg",
                          // getAnimationFrame('too-windy', _index),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Text(windSpeedText()),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/red.svg',
                      width: 24.0,
                      height: 24.0,
                    ),
                    SizedBox(width: 16.0),
                    Text(weatherDescriptionText()),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/red.svg',
                      width: 24.0,
                      height: 24.0,
                    ),
                    SizedBox(width: 16.0),
                    Text(sunriseOrSunsetText()),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  String checkSunrise(int hours) {
    double seconds = hours * 3600;
    if (!preferences.workAtNight) {
      if ((data!.time! + seconds) > data!.sunrise!) {
        double time_to_dark = (data!.sunset! - data!.time!) / 3600;
        return 'It\'s going to be dark in the next $time_to_dark hours';
      }
    }
    if (data!.isDay()) {
      return 'Sun is up';
    } else {
      return 'Sun is down';
    }
  }

  int getNumHoursStudy() {
    int currentTime = data!.time!;
    int endTime = currentTime + (slider.value * 60).toInt();

    int currentHour = (currentTime - currentTime % 3600) ~/ 3600;
    int endHour = (endTime - endTime % 3600) ~/ 3600;

    return endHour - currentHour;
  }

  /// awaits for the returned preferences from the settings screen
  /// and updates the preferences on stored on this screen so that
  /// we can access them later
  void awaitReturnPreferencesFromSettingsScreen(BuildContext context) async {
    final Preferences returnedPreferences = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SettingsScreen(preferences: preferences)),
    );
    setState(() {
      if (preferences.selectedLocation !=
          returnedPreferences.selectedLocation) {
        preferences.selectedLocation = returnedPreferences.selectedLocation;
        getData();
      }

      //preferences = Preferences.copy(returnedPreferences);
      preferences.isCelsius = returnedPreferences.isCelsius;
      /// minTemp, maxTemp are now getters in the Preferences class
      //preferences.minTemp = returnedPreferences.minTemp;
      //preferences.maxTemp = returnedPreferences.maxTemp;
      preferences.workAtNight = returnedPreferences.workAtNight;
      preferences.workInRain = returnedPreferences.workInRain;
      preferences.workInSnow = returnedPreferences.workInSnow;
      preferences.workInWind = returnedPreferences.workInWind;
      preferences.isLocationSetAutomatically =
          returnedPreferences.isLocationSetAutomatically;

      /// update the min/max temp indices when you come back from 
      /// 'settings' screen
      preferences.minTempIndex = returnedPreferences.minTempIndex;
      preferences.maxTempIndex = returnedPreferences.maxTempIndex;
    });
  }
}

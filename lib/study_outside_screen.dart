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
/// run flutter pub add slide_digital_clock
import 'package:slide_digital_clock/slide_digital_clock.dart';



class StudyOutsideScreen extends StatefulWidget {
  const StudyOutsideScreen({Key? key}) : super(key: key);
  @override
  _StudyOutsideScreenState createState() => _StudyOutsideScreenState();
}

class _StudyOutsideScreenState extends State<StudyOutsideScreen> {
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

  /// dictionary of animations
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

  /// get the animation frame based on the animation ID and the index
  String getAnimationFrame(animationID, index) {
    final animation = animations[animationID];
    if (animation == null) {
      throw Exception('Animation $animationID not found');
    }
    return 'assets/images/${animation[index % animation.length]}';
  }

  /// get the weather animation based on the weather data
  String getWeatherAnimation() {
    if (data == null) {
      return 'assets/images/sun-l.svg';
    }
    final weather = data!.mainDescription!;
    if (weather == 'Thunderstorm') {
      return getAnimationFrame('angry-thunder', _index);
    }
    if (weather == 'Drizzle' || weather == 'Rain' || weather.contains('rain')) {
      return getAnimationFrame('rain', _index);
    }
    if (weather == 'Snow') {
      return 'assets/images/snow/snow-1.svg';
    }
    if (weather == 'Clear') {
      if (data!.feelsLike![0] > 30) {
        return getAnimationFrame('hot-sun', _index);
      }
      return getAnimationFrame('happy-sun', _index);
    }
    if (weather == 'Clouds') {
      if (data!.wind![0] > 10) {
        return getAnimationFrame('too-windy', _index);
      }
      return getAnimationFrame('happy-cloud', _index);
    }
    if (data!.feelsLike![0] > 20) {
      return getAnimationFrame('happy-sun', _index);
    }
    return getAnimationFrame('happy-cloud', _index);
  }

  /// set up initial api client
  WeatherApiClient client = WeatherApiClient();
  Weather? data;

/// get weather data from api and store in weather object
  Future<void> getData() async {
    data = await client.getWeather(preferences.selectedLocation);
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  /// get the temperature text
  String feelsLikeTempText() {
    if (data == null) {
      return 'Loading...';
    }
    return 'Feels like ${Util.getStringForTemperature(data!.feelsLike![0], preferences.isCelsius)}';
  }

  /// get the wind speed text
  String windSpeedText() {
    if (data == null) {
      return 'Loading...';
    }
    return '${data!.windDescription![0]}';
  }

  /// capitalize first letter
  String capitaliseFirstLetter(String string) {
    return '${string[0].toUpperCase()}${string.substring(1)}';
  }

  /// get the weather description text
  String weatherDescriptionText() {
    if (data == null) {
      return 'Loading...';
    }
    return capitaliseFirstLetter('${data!.mainDescription!}');
  }

  /// get the sunrise or sunset text
  String sunriseOrSunsetText() {
    if (data == null) {
      return 'Loading...';
    }
    return data!.timeToSunriseOrSunset();
  }

  /// get weather api icon
  String iconText() {
    if (data == null) {
      /// default icon
      return "10d";
    }
    return data!.icons![0];
  }

  /// check if temperature in comfortable range for selected study hours
  List checkTemp(int hours) {
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

  /// check if wind speed is low enough for selected study hours
  List checkWind(int hours) {
    // loop through wind data for each hour and return false if over
    for (int i = 0; i <= hours && i < data!.wind!.length; i++) {
      if (data!.wind![i] >= 7.8) {
        return [
          false,
    (i == 0) ? 'There is a ${data!.windDescription![i]} right now' :
    'There will be a ${data!.windDescription![i]} in $i hours'];
      }
    }
    return [true, 'Not too windy in the next $hours hours'];
  }

  /// check if it's going to rain in selected study hours
  List checkRain(int hours) {
    // loop through rain data for each hour and return false if over 0.3
    for (int i = 0; i <= hours && i < data!.wind!.length; i++) {
      if (data!.rainChance![i] > 0.22) {
        if (i == 0) {
          return [false, 'It\'s raining now'];
        }

        return [false, 'It\'s going to rain in the next $i hours'];
      }
    }
    return [true, 'No rain in the next $hours hours'];
  }

  /// convert hours to hours and minutes
  String toHoursAndMins(double hours) {
    int hoursInt = hours.toInt();
    int mins = ((hours - hoursInt) * 60).ceil().toInt();
    if (hoursInt == 0) {
      return '$mins minutes';
    }
    return '$hoursInt hours and $mins minutes';
  }

  /// check if it's dark during study session at any point
  List checkDark(int hours) {
    // check if currently dark
    if (data!.time! < data!.sunrise! || data!.time! > data!.sunset!) {
      return [false, 'It is dark right now'];
    }
    double hoursUntilSunset = (data!.sunset! - data!.time!) / 3600;
    // check if it will be dark in the next hours
    if (hoursUntilSunset < hours) {
      return [false, 'It will be dark in ${toHoursAndMins(hoursUntilSunset)}'];
    }
    return [true, 'It will be light for $hours hours'];
  }

  /// call each condition check one at a time and return an appropriate string
  String checkConditions(int hours) {
    if (data == null) {
      return 'Loading...';
    }

    List temp = checkTemp(hours);
    List wind = checkWind(hours);
    List rain = checkRain(hours);
    List dark = checkDark(hours);

    // if it's raining and they haven't selected work in rain
    if (!rain[0] && !preferences.workInRain) {
      return rain[1];
    }

    // if it's windy and they haven't selected work in wind
    if (!wind[0] && !preferences.workInWind) {
      return wind[1];
    }

    // if it's outside comfortable temperature
    if (!temp[0]) {
      return temp[1];
    }

    // if it's dark and they haven't selected work at night
    if (!dark[0] && !preferences.workAtNight) {
      return dark[1];
    }

    // otherwise return a string saying it's comfortable for the selected hours
    return 'The weather is comfortable for ${toHoursAndMins(slider.value / 60)}';
  }


  /// convert slider value to number of hours
  int getNumHoursStudy() {
    if (data == null) {
      return 0;
    }
    int currentTime = data!.time!;
    int endTime = currentTime + (slider.value * 60).toInt();

    int currentHour = (currentTime - currentTime % 3600) ~/ 3600;
    int endHour = (endTime - endTime % 3600) ~/ 3600;

    return endHour - currentHour;
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
      body: Container(
        //move top of container to top of screen
        alignment: AlignmentDirectional.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Pallete.upperBarColor,
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                    top: 6,
                    right: 5,

                    /// Button to go to 'Settings' screen
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Pallete.settingsLocationSettingsButtonColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {
                          /// push the 'Settings' screen and wait for updated preferences
                          awaitReturnPreferencesFromSettingsScreen(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Settings',
                                        style: TextStyle(color: Colors.black,
                                          fontSize: 18.0, 
                                          fontFamily: 'Roboto')),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                            SvgPicture.asset(
                              "assets/icons/gear.svg",
                              width: 27.0,
                              height: 27.0,
                            ),
                          ],
                        )
                      ),
                    )
                  ),
                  /// CLOCK
                  Positioned(
                    top: 1,
                    left: 5,
                    child: DigitalClock(
                      hourMinuteDigitTextStyle: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: const Color.fromARGB(255, 0, 0, 0)),
                      showSecondsDigit: false,
                      is24HourTimeFormat: false,
                      colon: Text(
                        ":",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: const Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Pallete.upperBackgroundColor,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.3, // 30% of screen height
                    //child: Expanded(
                    child: Stack(
                      children: [
                        Container(
                          alignment: AlignmentDirectional.center,
                          child: SvgPicture.asset(
                            getWeatherAnimation(),
                            fit: BoxFit.cover,
                          )),
                    ]),
                    //),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                ],
              )
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.59,
              padding: const EdgeInsets.all(16.0),
              color: Pallete.lowerBackgroundColor,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Pallete.sliderContainerColor,
                      borderRadius: BorderRadius.circular(5),
                      border: const Border.fromBorderSide(BorderSide(
                            color: Color.fromARGB(255, 161, 199, 129)),
                      ),
                      //shape: 
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                        /////// SLIDER
                        slider,
                        /////// SLIDER
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.032,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(fontSize: 20.0, fontFamily: 'Roboto', color: Colors.black),
                                      children: <TextSpan>[
                                        const TextSpan(text: 'The current location is set to '),
                                        TextSpan(text: preferences.selectedLocation,
                                          style: const TextStyle(fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    "assets/icons/location.svg",
                                    width: 27.0,
                                    height: 27.0,
                                  ),
                                ],
                              ),
                            )
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.016),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.033,
                          child: Text(
                            checkConditions(getNumHoursStudy()),
                            style: const TextStyle(fontSize: 20.0),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.008),
                      ],
                    )
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.024),
                  Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/thermometer.svg",
                            width: 42.0,
                            height: 42.0,
                          ),
                          // SvgPicture.asset("images/sun.svg"),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                          Text(feelsLikeTempText()),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.4),
                          // Text(checkTemp(getNumHoursStudy()))
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      Row(
                        children: [
                          Container(
                            width: 41,
                            height: 41,
                            child: OverflowBox(
                              alignment: Alignment.center,
                              minWidth: 0.0,
                              minHeight: 0.0,
                              maxWidth: 56,
                              maxHeight: 36,
                              child: SvgPicture.asset(
                                "assets/images/too-windy/too-windy-7.svg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                          Text(windSpeedText()),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      Row(
                        children: [
                          Container(
                            height: 42.0,
                            width: 42.0,
                            child: Image.network('https://openweathermap.org/img/wn/${iconText()}@2x.png'),
                          ),    
                          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                          Text(weatherDescriptionText()),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      Row(
                        children: [
                          SvgPicture.asset(
                            (data == null) ? "assets/icons/sunset.svg" :
                            (data!.isDay() ? "assets/icons/sunset.svg" :
                            "assets/icons/sunrise.svg"),
                            width: 42.0,
                            height: 42.0,
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                          Text(sunriseOrSunsetText()),
                        ],
                      ),
                    ],
                  ),
                ]
              ),
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
          builder: (context) => SettingsScreen(preferences: preferences)),
    );
    setState(() {
      /// selectedLocation is now a getter in Preferences
      if (preferences.locationIndex !=
          returnedPreferences.locationIndex) {
        preferences.locationIndex = returnedPreferences.locationIndex;
        getData();
      }

      preferences.isCelsius = returnedPreferences.isCelsius;
      /// minTemp, maxTemp are now getters in the Preferences class
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
      
      /// update location index we got back from 'location settings'
      /// screen
      preferences.locationIndex = returnedPreferences.locationIndex;
    });
  }
}

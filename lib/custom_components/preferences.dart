import "package:flutter_application_1/util.dart";

class Preferences {
  bool isCelsius;
  /// minTemp, maxTemp are now getters
  //double minTemp;
  //double maxTemp;
  bool workInRain;
  bool workInSnow;
  bool workInWind;
  bool workAtNight;
  bool isLocationSetAutomatically;
  String selectedLocation;

  /// minTempIndex - zero-based index of currently selected
  /// minimum temperature on the 'Settings' screen
  int minTempIndex;
  /// IF YOU CHANGE THESE LISTS - CHANGE THE DEFAULT INDICES
  /// IN Preferences.defaultPreferences() BELOW 
  static List<double> minTemperaturesCelsius = [0, 5, 10, 15, 20, 25];
  static List<double> minTemperaturesFahrenheit = 
                 Util.listCelsiusToFahrenheit(minTemperaturesCelsius);
  /// maxTempIndex - zero-based index of currently selected
  /// maximum temperature on the 'Settings' screen
  int maxTempIndex;
  /// IF YOU CHANGE THESE LISTS - CHANGE THE DEFAULT INDICES
  /// IN Preferences.defaultPreferences() BELOW 
  static List<double> maxTemperaturesCelsius = [25, 30, 35, 40];
  static List<double> maxTemperaturesFahrenheit = 
                 Util.listCelsiusToFahrenheit(maxTemperaturesCelsius);

  /// getter for the currently selected minTemp,
  /// lowest minTemp if index is lower than 0,
  /// highest minTemp if index is higher than l-1
  /// ALWAYS IN CELSIUS
  double get minTemp {
    if(minTempIndex < 0){
      return minTemperaturesCelsius[0];
    }
    else if(minTempIndex > minTemperaturesCelsius.length-1){
      return minTemperaturesCelsius[minTemperaturesCelsius.length-1];
    }
    else{
      return minTemperaturesCelsius[minTempIndex];
    }
  }

  /// getter for the currently selected maxTemp,
  /// lowest maxTemp if index is lower than 0,
  /// highest maxTemp if index is higher than l-1
  /// ALWAYS IN CELSIUS
  double get maxTemp {
    if(maxTempIndex < 0){
      return maxTemperaturesCelsius[0];
    }
    else if(maxTempIndex > maxTemperaturesCelsius.length-1){
      return maxTemperaturesCelsius[maxTemperaturesCelsius.length-1];
    }
    else{
      return maxTemperaturesCelsius[maxTempIndex];
    }
  }

  Preferences(
      {required this.isCelsius,
      //required this.minTemp,
      //required this.maxTemp,
      required this.workInRain,
      required this.workInSnow,
      required this.workInWind,
      required this.workAtNight,
      required this.isLocationSetAutomatically,
      required this.selectedLocation,
      required this.minTempIndex,
      required this.maxTempIndex});

  Preferences.copy(Preferences p)
      : isCelsius = p.isCelsius,
        //minTemp = p.minTemp,
        //maxTemp = p.maxTemp,
        workInRain = p.workInRain,
        workInSnow = p.workInSnow,
        workInWind = p.workInWind,
        workAtNight = p.workAtNight,
        isLocationSetAutomatically = p.isLocationSetAutomatically,
        selectedLocation = p.selectedLocation,
        minTempIndex = p.minTempIndex,
        maxTempIndex = p.maxTempIndex;

  Preferences.defaultPreferences()
      : isCelsius = true,
        //minTemp = 18.0,
        //maxTemp = 25.0,
        workInRain = false,
        workInSnow = false,
        workInWind = false,
        workAtNight = false,
        isLocationSetAutomatically = true,
        selectedLocation = 'Cambridge',
        minTempIndex = 4,
        maxTempIndex = 0;
}

// const List<String> locations = <String>['Cambridge', 'Manchester', 'Oxford'];
const List<String> locations = <String>[
  'Cambridge',
  'Manchester',
  'Oxford',
  'London',
  'New York',
  'Orlando',
  'Paris',
  'Rome',
  'San Francisco',
  'Tokyo',
  'Toronto',
  'Vancouver',
  'Venice',
  'Vienna',
  'Washington DC',
  'Dubai',
  'Singapore',
  'Reykjavík'
];

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
  /// IF YOU CHANGE THIS - CHANGE THE DEFAULT INDICES
  /// IN Preferences.defaultPreferences() BELOW 
  static List<double> minTemperatures = [0, 5, 10, 15, 20, 25];
  /// maxTempIndex - zero-based index of currently selected
  /// maximum temperature on the 'Settings' screen
  int maxTempIndex;
  /// IF YOU CHANGE THIS - CHANGE THE DEFAULT INDICES
  /// IN Preferences.defaultPreferences() BELOW 
  static List<double> maxTemperatures = [25, 30, 35, 40];

  /// getter for the currently selected minTemp,
  /// lowest minTemp if index is lower than 0,
  /// highest minTemp if index is higher than l-1
  double get minTemp {
    if(minTempIndex < 0){
      return minTemperatures[0];
    }
    else if(minTempIndex > minTemperatures.length-1){
      return minTemperatures[minTemperatures.length-1];
    }
    else{
      return minTemperatures[minTempIndex];
    }
  }

  /// getter for the currently selected maxTemp,
  /// lowest maxTemp if index is lower than 0,
  /// highest maxTemp if index is higher than l-1
  double get maxTemp {
    if(maxTempIndex < 0){
      return maxTemperatures[0];
    }
    else if(maxTempIndex > maxTemperatures.length-1){
      return maxTemperatures[maxTemperatures.length-1];
    }
    else{
      return maxTemperatures[maxTempIndex];
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

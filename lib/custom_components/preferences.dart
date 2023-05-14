class Preferences {
  bool isCelsius;
  double minTemp;
  double maxTemp;
  bool workInRain;
  bool workInSnow;
  bool workInWind;
  bool workAtNight;
  bool isLocationEnabled;

  Preferences({
    required this.isCelsius, 
    required this.minTemp, 
    required this.maxTemp, 
    required this.workInRain, 
    required this.workInSnow, 
    required this.workInWind, 
    required this.workAtNight,
    required this.isLocationEnabled
  });

  Preferences.copy(Preferences p)
      : isCelsius = p.isCelsius,
        minTemp = p.minTemp,
        maxTemp = p.maxTemp,
        workInRain = p.workInRain,
        workInSnow = p.workInSnow,
        workInWind = p.workInWind,
        workAtNight = p.workAtNight,
        isLocationEnabled = p.isLocationEnabled;

  Preferences.defaultPreferences()
      : isCelsius = true, 
        minTemp = 18.0, 
        maxTemp = 25.0,
        workInRain = false, 
        workInSnow = false, 
        workInWind = false, 
        workAtNight = false,
        isLocationEnabled =  true;
}
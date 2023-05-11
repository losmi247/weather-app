class Preferences {
  bool isCelsius;
  double minTemp;
  double maxTemp;
  bool workInRain;
  bool workInSnow;
  bool workInWind;
  bool workAtNight;

  Preferences({
    required this.isCelsius, 
    required this.minTemp, 
    required this.maxTemp, 
    required this.workInRain, 
    required this.workInSnow, 
    required this.workInWind, 
    required this.workAtNight,
  });

  Preferences.copy(Preferences p)
      : isCelsius = p.isCelsius,
        minTemp = p.minTemp,
        maxTemp = p.maxTemp,
        workInRain = p.workInRain,
        workInSnow = p.workInSnow,
        workInWind = p.workInWind,
        workAtNight = p.workAtNight;
}
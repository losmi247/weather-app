class Preferences {
  bool isCelsius;
  double minTemp;
  double maxTemp;
  bool workInRain;
  bool workInSnow;
  bool workInWind;
  bool workAtNight;
  bool isLocationSetAutomatically;
  LocationLabel? selectedLocation;

  Preferences({
    required this.isCelsius, 
    required this.minTemp, 
    required this.maxTemp, 
    required this.workInRain, 
    required this.workInSnow, 
    required this.workInWind, 
    required this.workAtNight,
    required this.isLocationSetAutomatically,
    required this.selectedLocation
  });

  Preferences.copy(Preferences p)
      : isCelsius = p.isCelsius,
        minTemp = p.minTemp,
        maxTemp = p.maxTemp,
        workInRain = p.workInRain,
        workInSnow = p.workInSnow,
        workInWind = p.workInWind,
        workAtNight = p.workAtNight,
        isLocationSetAutomatically = p.isLocationSetAutomatically,
        selectedLocation = p.selectedLocation;

  Preferences.defaultPreferences()
      : isCelsius = true, 
        minTemp = 18.0, 
        maxTemp = 25.0,
        workInRain = false, 
        workInSnow = false, 
        workInWind = false, 
        workAtNight = false,
        isLocationSetAutomatically = true,
        selectedLocation = LocationLabel.cambridge;
}

enum LocationLabel {
  cambridge('Cambridge', 'Cambridge'),
  oxford('Oxford', 'Oxford'),
  manchester('Manchester', 'Manchester');

  const LocationLabel(this.label, this.location);
  final String label;
  final String location;
}
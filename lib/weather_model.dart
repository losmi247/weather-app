class Weather {
  List? feelsLike;
  List? wind;
  double? sunrise;
  double? sunset;
  List? rainChance;
  List? description;
  double? time;

  Weather(
  {
    this.feelsLike,
    this.wind,
    this.sunrise,
    this.sunset,
    this.rainChance,
    this.description,
    this.time
  });



  void windSpeedToDescription() {
    for (int i = 0; i < wind!.length; i++) {
      if (wind![i] < 0.27) {
        wind![i] = 'Calm';
      } else if (wind![i] < 1.4) {
        wind![i] = 'Light Air';
      } else if (wind![i] < 3.1) {
        wind![i] = 'Light Breeze';
      } else if (wind![i] < 5.3) {
        wind![i] = 'Gentle Breeze';
      } else if (wind![i] < 7.8) {
        wind![i] = 'Moderate Breeze';
      } else if (wind![i] < 11) {
        wind![i] = 'Fresh Breeze';
      } else if (wind![i] < 14) {
        wind![i] = 'Strong Breeze';
      } else if (wind![i] < 17) {
        wind![i] = 'Near Gale';
      } else if (wind![i] < 21) {
        wind![i] = 'Gale';
      } else if (wind![i] < 24) {
        wind![i] = 'Strong Gale';
      } else if (wind![i] < 28) {
        wind![i] = 'Storm';
      } else {
        wind![i] = 'Hurricane';
      }
    }
  }

  bool isDay() {
    return (time! > sunrise! && time! < sunset!);
  }

  String timeToSunrise() {
    var mins = ((sunrise! - time!) / 60).ceil();
    var hours = (mins / 60).floor();
    if (hours > 0 ){
      return 'Sunrise is in $hours hours and ${mins % 60} minutes';
    }
    else {
      return 'Sunrise is in $mins minutes';
    }
  }

  String timeToSunset() {
    var mins = ((sunset! - time!) / 60).ceil();
    var hours = (mins / 60).floor();
    if (hours > 0 ){
      return 'Sunset is in $hours hours and ${mins % 60} minutes';
    }
    else {
      return 'Sunset is in $mins minutes';
    }
  }

  String timeToSunriseOrSunset() {
    if (isDay()) {
      return timeToSunset();
    }
    else {
      return timeToSunrise();
    }
  }

  Weather.fromJson(Map<String, dynamic> json) {
    feelsLike = [];
    wind = [];
    rainChance = [];
    description = [];
    sunrise = json['current']['sunrise'];
    sunset = json['current']['sunset'];
    time = json['current']['dt'];
    // loop to get weather info for next 12 hours
    for (int i = 0; i < 12; i++) {
      feelsLike!.add(json['hourly'][i]['feels_like']);
      wind!.add(json['hourly'][i]['wind_speed']);
      rainChance!.add(json['hourly'][i]['pop']);
      description!.add(json['hourly'][i]['weather'][0]['description']);
    }
    windSpeedToDescription();
  }
}
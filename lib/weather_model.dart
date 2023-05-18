class Weather {
  List? feelsLike;
  List? wind;
  double? sunrise;
  double? sunset;
  List? rainChance;
  List? description;
  double? time;
  List? windDescription;

  Weather(
      {this.feelsLike,
      this.wind,
      this.sunrise,
      this.sunset,
      this.rainChance,
      this.description,
      this.time,
      this.windDescription});

  void windSpeedToDescription() {
    for (int i = 0; i < wind!.length; i++) {
      if (wind![i] < 0.27) {
        windDescription![i] = 'Calm';
      } else if (wind![i] < 1.4) {
        windDescription![i] = 'Light Air';
      } else if (wind![i] < 3.1) {
        windDescription![i] = 'Light Breeze';
      } else if (wind![i] < 5.3) {
        windDescription![i] = 'Gentle Breeze';
      } else if (wind![i] < 7.8) {
        windDescription![i] = 'Moderate Breeze';
      } else if (wind![i] < 14) {
        windDescription![i] = 'Strong Breeze';
      } else if (wind![i] < 17) {
        windDescription![i] = 'Near Gale';
      } else if (wind![i] < 21) {
        windDescription![i] = 'Gale';
      } else if (wind![i] < 24) {
        windDescription![i] = 'Strong Gale';
      } else if (wind![i] < 28) {
        windDescription![i] = 'Storm';
      } else {
        windDescription![i] = 'Hurricane';
      }
    }
  }

  bool isDay() {
    return (time! > sunrise! && time! < sunset!);
  }

  String getTimeUntilString(delta) {
    var mins = (delta / 60).ceil();
    var hours = (mins / 60).floor();
    if (hours == 0) {
      return '$mins minutes';
    }
    return '$hours hours and ${mins % 60} minutes';
  }

  String timeToSunrise() {
    return 'Sunrise is in ${getTimeUntilString(sunrise! - time!)}';
  }

  String timeToSunset() {
    return 'Sunset is in ${getTimeUntilString(sunset! - time!)}';
  }

  String timeToSunriseOrSunset() {
    if (isDay()) {
      return timeToSunset();
    } else {
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

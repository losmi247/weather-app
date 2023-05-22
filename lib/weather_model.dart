class Weather {
  List? feelsLike;
  List? wind;
  /*double? sunrise;
  double? sunset;*/
  int? sunrise;
  int? sunset;
  List? rainChance;
  List? description;
  int? time;
  List? windDescription;
  List? icons;
  String? mainDescription;

  Weather(
      {this.feelsLike,
      this.wind,
      this.sunrise,
      this.sunset,
      this.rainChance,
      this.description,
      this.time,
      this.windDescription,
      this.icons,
      this.mainDescription});

  void windSpeedToDescription() {
    for (int i = 0; i < wind!.length; i++) {
      if (wind![i] < 0.27) {
        windDescription![i] = 'Calm';
      } else if (wind![i] < 1.4) {
        windDescription![i] = 'Light air';
      } else if (wind![i] < 3.1) {
        windDescription![i] = 'Light breeze';
      } else if (wind![i] < 5.3) {
        windDescription![i] = 'Gentle breeze';
      } else if (wind![i] < 7.8) {
        windDescription![i] = 'Moderate breeze';
      } else if (wind![i] < 14) {
        windDescription![i] = 'Strong breeze';
      } else if (wind![i] < 17) {
        windDescription![i] = 'Near gale';
      } else if (wind![i] < 21) {
        windDescription![i] = 'Gale';
      } else if (wind![i] < 24) {
        windDescription![i] = 'Strong gale';
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
    delta = positiveOnlyMod(delta, 86400);
    //var mins = (delta / 60).ceil();
    int mins = (delta + 60 - 1) ~/ 60;
    //var hours = (mins / 60).floor();
    int hours = mins ~/ 60;
    if (hours > 0) {
      return '$hours hours and ${mins % 60} minutes';
    }
    //return '$hours hours and ${mins % 60} minutes';
    return '${mins % 60} minutes';
  }

  int positiveOnlyMod(int a, int b) {
    return (a % b + b) % b;
  }

  String timeToSunrise() {
    return 'Sunrise is in ${getTimeUntilString(sunrise! - time!)}';
  }

  String timeToSunset() {
    /*var mins = ((sunset! - time!) / 60).ceil();
    var hours = (mins / 60).floor();
    if (hours > 0) {
      return 'Sunset is in $hours hours and ${mins % 60} minutes';
    } else {
      return 'Sunset is in $mins minutes';
    }*/
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
    windDescription = [];
    sunrise = json['current']['sunrise'];
    sunset = json['current']['sunset'];
    time = json['current']['dt'];
    icons = [];
    mainDescription = json['current']['weather'][0]['main'];
    // loop to get weather info for next 12 hours
    for (int i = 0; i < 12; i++) {
      feelsLike!.add(json['hourly'][i]['feels_like']);
      wind!.add(json['hourly'][i]['wind_speed']);
      rainChance!.add(json['hourly'][i]['pop']);
      description!.add(json['hourly'][i]['weather'][0]['description']);
      windDescription!.add('');
      icons!.add(json['hourly'][i]['weather'][0]['icon']);
    }
    windSpeedToDescription();
  }
}

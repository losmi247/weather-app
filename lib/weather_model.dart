class Weather {
  List? feelsLike;
  List? wind;
  double? sunrise;
  double? sunset;
  List? rainChance;

  Weather(
  {
    this.feelsLike,
    this.wind,
    this.sunrise,
    this.sunset,
    this.rainChance
  });

  Weather.fromJson(Map<String, dynamic> json) {
    feelsLike = [];
    wind = [];
    rainChance = [];
    sunrise = json['current']['sunrise'];
    sunset = json['current']['sunset'];
    // loop to get weather info for next 12 hours
    for (int i = 0; i < 12; i++) {
      feelsLike!.add(json['hourly'][i]['feels_like']);
      wind!.add(json['hourly'][i]['wind_speed']);
      rainChance!.add(json['hourly'][i]['pop']);
    }
  }
}
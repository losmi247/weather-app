class Weather {
  double? feelsLike;
  double? wind;
  double? sunrise;
  double? sunset;
  double? rainChance;

  Weather(
  {
    this.feelsLike,
    this.wind,
    this.sunrise,
    this.sunset,
    this.rainChance
  });

  Weather.fromJson(Map<String, dynamic> json) {
    feelsLike = json['main']['feels_like'];
    wind = json['wind']['speed'];
    /*sunrise = json['sys']['sunrise'];
    sunset = json['sys']['sunset'];*/
  }
}
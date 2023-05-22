class Util {
  static double celsiusToFahrenheit(double celsius) {
    return (celsius * 9 / 5) + 32;
  }

  static String getStringForTemperature(
      double temperatureCelsius, bool isCelsius) {
    if (!isCelsius) {
      return '${celsiusToFahrenheit(temperatureCelsius).toStringAsFixed(1)}°F';
    }

    return '${temperatureCelsius.toStringAsFixed(1)}°C';
  }


  static List<double> listCelsiusToFahrenheit(List<double> celsiusTemps) {
    List<double> fahrenheitTemps = [];
    for (var cTemp in celsiusTemps) {
      fahrenheitTemps.add(celsiusToFahrenheit(cTemp));
    }
    return fahrenheitTemps;
  }
}

class Util {
  static double celsiusToFahrenheit(double celsius) {
    return (celsius * 9 / 5) + 32;
  }

  static String getStringForTemperature(
      double temperatureCelsius, bool isCelsius) {
    if (!isCelsius) {
      return '${celsiusToFahrenheit(temperatureCelsius).toStringAsFixed(0)}°F';
    }

    return '${temperatureCelsius.toStringAsFixed(0)}°C';
  }
}

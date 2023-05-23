import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_application_1/weather_model.dart';

/// hard coded geolocations
const Map<String, List<double>> hardCodedLocations = {
  'Cambridge': [52.2053, 0.1218],
  'Manchester': [53.4808, -2.2426],
  'Oxford': [51.7520, -1.2577],
  'London': [51.5085, -0.1257],
  'New York': [40.7128, -74.0060],
  'Orlando': [28.5383, -81.3792],
  'Paris': [48.8566, 2.3522],
  'Rome': [41.9028, 12.4964],
  'San Francisco': [37.7749, -122.4194],
  'Tokyo': [35.6762, 139.6503],
  'Toronto': [43.6532, -79.3832],
  'Vancouver': [49.2827, -123.1207],
  'Venice': [45.4408, 12.3155],
  'Vienna': [48.2082, 16.3738],
  'Washington DC': [38.9072, -77.0369],
  'Dubai': [25.2048, 55.2708],
  'Singapore': [1.3521, 103.8198],
  'Reykjavík': [64.1466, -21.9426],
};

class WeatherApiClient {
  /// Get latitude and longitude of location
  Future<List>? getCoordinates(String? location) async {
    if (hardCodedLocations.containsKey(location)) {
      return Future.value(hardCodedLocations[location]);
    }

    var endpoint = Uri.parse(
        'https://api.openweathermap.org/geo/1.0/direct?q=$location&appid=01e382c94f9a635a208f2368295c3597');
    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    return [body[0]['lat'], body[0]['lon']];
  }

  /// Call api to get weather data
  Future<Weather>? getWeather(String? location) async {
    List? latLon = await getCoordinates(location);
    double? lat = latLon?[0];
    double? lon = latLon?[1];
    var endpoint = Uri.parse(
        'https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&exclude=minutely,daily,alerts&units=metric&appid=01e382c94f9a635a208f2368295c3597');
    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);

    return Weather.fromJson(body);
  }
}

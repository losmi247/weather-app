import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_application_1/weather_model.dart';

class WeatherApiClient{

  Future<List>? getCoordinates(String? location) async {
    var endpoint = Uri.parse('https://api.openweathermap.org/geo/1.0/direct?q=$location&appid=01e382c94f9a635a208f2368295c3597');
    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    return [body[0]['lat'], body[0]['lon']];
  }

  Future<String>? getCurrentWeather(String? location) async {
    List? latLon = await getCoordinates(location);
    double? lat = latLon?[0];
    double? lon = latLon?[1];
    var endpoint = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=01e382c94f9a635a208f2368295c3597');
    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);

    return body;
  }

  Future<String>? getHourlyWeather(String? location) async {
    List? latLon = await getCoordinates(location);
    double? lat = latLon?[0];
    double? lon = latLon?[1];
    var endpoint = Uri.parse('https://pro.openweathermap.org/data/2.5/forecast/hourly?lat=$lat&lon=$lon&cnt=12&appid=01e382c94f9a635a208f2368295c3597');
    var response = await http.get(endpoint);
    var body = jsonDecode(response.body)['list'][0];

    return body;
  }

}
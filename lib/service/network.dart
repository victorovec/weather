import 'dart:convert';
import 'package:app_weather/models/model.dart';
import 'package:http/http.dart' as http;


  Future<WeatherResponse> getWeather(double? latitude, double? longitude) async {
    // Define the API endpoint
    const String endpoint = 'https://api.open-meteo.com/v1/forecast';

    // Define query parameters
     final Map<String, String> queryParams = {
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'current_weather': 'true',
    }; 

    // Build the full URL
    final uri = Uri.parse(endpoint).replace(queryParameters: queryParams);

    // Make the API request
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // Parse the JSON response
      final jsonData = json.decode(response.body);
      return WeatherResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }



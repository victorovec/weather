class WeatherResponse {
  final double latitude;
  final double longitude;
  final double generationTimeMs;
  final int utcOffsetSeconds;
  final String timezone;
  final String timezoneAbbreviation;
  final double elevation;
  final CurrentWeather currentWeather;

  WeatherResponse({
    required this.latitude,
    required this.longitude,
    required this.generationTimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.currentWeather,
  });

  // Factory method to create an instance from JSON
  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      latitude: json['latitude'],
      longitude: json['longitude'],
      generationTimeMs: json['generationtime_ms'],
      utcOffsetSeconds: json['utc_offset_seconds'],
      timezone: json['timezone'],
      timezoneAbbreviation: json['timezone_abbreviation'],
      elevation: json['elevation'],
      currentWeather: CurrentWeather.fromJson(json['current_weather']),
    );
  }

  // Convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'generationtime_ms': generationTimeMs,
      'utc_offset_seconds': utcOffsetSeconds,
      'timezone': timezone,
      'timezone_abbreviation': timezoneAbbreviation,
      'elevation': elevation,
      'current_weather': currentWeather.toJson(),
    };
  }
}

class CurrentWeather {
  final double temperature;
  final double windspeed;
  final int winddirection;
  final int weathercode;
  final String time;

  CurrentWeather({
    required this.temperature,
    required this.windspeed,
    required this.winddirection,
    required this.weathercode,
    required this.time,
  });

  // Factory method to create an instance from JSON
  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    String date = json['time'].substring(0,10);
    return CurrentWeather(
      temperature: json['temperature'],
      windspeed: json['windspeed'],
      winddirection: json['winddirection'],
      weathercode: json['weathercode'],
      time:date
    );
  }

  // Convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'windspeed': windspeed,
      'winddirection': winddirection,
      'weathercode': weathercode,
      'time': time,
    };
  }
}

import 'package:app_weather/pages/home.dart';
import 'package:app_weather/pages/initial_page.dart';
import 'package:flutter/material.dart';
import 'package:app_weather/pages/time_zone_selection_page.dart';
void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const InitialPage(),
        '/home': (context) =>const HomeScreen(),
        '/timeZoneSelectionList': (context) => TimeZoneSelectionPage(),
      },
    ),
  );
}



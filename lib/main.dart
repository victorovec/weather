import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_weather/pages/home.dart';
import 'package:app_weather/pages/initial_page.dart';
import 'package:app_weather/pages/time_zone_selection_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Set your base design size
      minTextAdapt: true,
      splitScreenMode: true, // Supports multi-screen devices
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.system, // Supports light/dark mode
          initialRoute: '/',
          routes: {
            '/': (context) => const InitialPage(),
            '/home': (context) => const HomeScreen(),
            '/timeZoneSelectionList': (context) => const TimeZoneSelectionPage(),
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lottie/lottie.dart';
import 'package:app_weather/service/transform.dart';


class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  List<String> timezones = [];
  bool isLoading = false;

  Future<void> fetchTimeZones() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response =
          await http.get(Uri.parse('https://worldtimeapi.org/api/timezone'));
      if (response.statusCode == 200) {
        setState(() {
          List data = json.decode(response.body);
          timezones = List<String>.from(data);
        });
      } else {
        throw Exception('Failed to load timezones');
      }
    } catch (e) {
      throw Exception('Error fetching timezones: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: ResponsiveLayout(
        mobileLayout: _buildMobileLayout(),
        tabletLayout: _buildTabletLayout(),
      ),
    );
  }

  // Mobile layout (portrait or small screens)
  Widget _buildMobileLayout() {
    return SingleChildScrollView(  // Wrap the Column in a SingleChildScrollView to prevent overflow
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/weather2.json'),
            const Text(
              'Weather',
              style: TextStyle(
                color: Colors.white,
                fontSize: 75.0,
              ),
            ),
            const Text(
              'Forecasts',
              style: TextStyle(
                color: Colors.yellow,
                fontSize: 75.0,
              ),
            ),
            const SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/timeZoneSelectionList',
                  arguments: timezones,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tablet layout (larger screens or landscape mode)
  Widget _buildTabletLayout() {
    return SingleChildScrollView(  // Ensure scrolling on large screens too
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstrainedBox(  // Prevent overflow by setting constraints
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width,  // Prevent it from overflowing horizontally
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset('assets/weather2.json'),
                  const Text(
                    'Weather',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 100.0,
                    ),
                  ),
                  const Text(
                    'Forecasts',
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 100.0,
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        '/timeZoneSelectionList',
                        arguments: timezones,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 40.0,
                            color: Colors.deepPurpleAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

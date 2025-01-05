import 'package:flutter/material.dart';
import 'package:app_weather/models/model.dart';
import 'package:app_weather/service/network.dart';
import 'package:lottie/lottie.dart';
import 'package:app_weather/service/transform.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Retrieve arguments passed from the previous page
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    double? latitude = args?['latitude'];
    double? longitude = args?['longitude'];
    String country = args?['country'];

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: false,
        actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                  color: Colors.yellow,
                  width: 3), // Outline color and thickness
              padding: const EdgeInsets.symmetric(
                  horizontal: 24, vertical: 12), // Padding
            ),
            child: const Row(
              children: [
                Text(
                  "Edit Location",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
      body: ResponsiveLayout(
        mobileLayout: _buildMobileLayout(latitude, longitude, country),
        tabletLayout: _buildTabletLayout(latitude, longitude, country),
      ),
    );
  }

  // Mobile layout (portrait or small screens)
  Widget _buildMobileLayout(
      double? latitude, double? longitude, String country) {
    return SingleChildScrollView(
      // Wrap the Column in a SingleChildScrollView to prevent overflow
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(70.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text(
                      country,
                      style: const TextStyle(
                        fontSize: 35.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              FutureBuilder<WeatherResponse>(
                future: getWeather(latitude,
                    longitude), // Fetch weather for specific coordinates
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 5.0,
                    ));
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final weather = snapshot.data!;
                    final temperature = weather.currentWeather.temperature;
                    String weatherImage = temperature >= 25
                        ? 'assets/sunny.json'
                        : (temperature >= 10 && temperature < 25
                            ? 'assets/cloudy.json'
                            : 'assets/rainy.json');
                    return Column(
                      children: [
                        Lottie.asset(weatherImage),
                        Text(
                          '$temperature°C',
                          style: const TextStyle(
                            fontSize: 35.0,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          weather.currentWeather.time,
                          style: const TextStyle(
                            fontSize: 35.0,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 100.0),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                width: 100,
                                height: 100,
                                padding: const EdgeInsets.all(16.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.yellow, // Border color
                                    width:
                                        5.0, // Increased border width for more obvious border
                                  ),
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'wnds\n${weather.currentWeather.windspeed}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20.0),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                height: 100,
                                padding: const EdgeInsets.all(16.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.yellow, // Border color
                                    width:
                                        5.0, // Increased border width for more obvious border
                                  ),
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'wthc\n${weather.currentWeather.weathercode}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20.0),
                            Expanded(
                              child: Container(
                                width: 100,
                                height: 100,
                                padding: const EdgeInsets.all(16.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.yellow, // Border color
                                    width:
                                        5.0, // Increased border width for more obvious border
                                  ),
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'tmez\n${weather.timezone}',
                                  textAlign: TextAlign.center,
                                  style:const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  } else {
                    return const Center(child: Text('No data available'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Tablet layout (larger screens or landscape mode)
  Widget _buildTabletLayout(
      double? latitude, double? longitude, String country) {
    return SingleChildScrollView(
      // Ensure scrolling on large screens too
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstrainedBox(
              // Prevent overflow by setting constraints
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context)
                    .size
                    .width, // Prevent it from overflowing horizontally
              ),
              child: Padding(
                padding: const EdgeInsets.all(70.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      country,
                      style: const TextStyle(
                        fontSize: 35.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    FutureBuilder<WeatherResponse>(
                      future: getWeather(latitude,
                          longitude), // Fetch weather for specific coordinates
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 5.0,
                          ));
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          final weather = snapshot.data!;
                          final temperature =
                              weather.currentWeather.temperature;
                          String weatherImage = temperature >= 25
                              ? 'assets/sunny.json'
                              : (temperature >= 10 && temperature < 25
                                  ? 'assets/cloudy.json'
                                  : 'assets/rainy.json');
                          return Column(
                            children: [
                              Lottie.asset(weatherImage),
                              Text(
                                '$temperature°C',
                                style: const TextStyle(
                                  fontSize: 35.0,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                weather.currentWeather.time,
                                style: const TextStyle(
                                  fontSize: 35.0,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 50.0),
                              Row(
                          children: [
                            Expanded(
                              child: Container(
                                width: 100,
                                height: 100,
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.yellow, // Border color
                                    width:
                                        5.0, // Increased border width for more obvious border
                                  ),
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'windspeed\n${weather.currentWeather.windspeed}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20.0),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                height: 100,
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.yellow, // Border color
                                    width:
                                        5.0, // Increased border width for more obvious border
                                  ),
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'weather code\n${weather.currentWeather.weathercode}',
                                  textAlign:TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20.0),
                            Expanded(
                              child: Container(
                                width: 100,
                                height: 100,
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.yellow, // Border color
                                    width:
                                        5.0, // Increased border width for more obvious border
                                  ),
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Timezone\n${weather.timezone}',
                                  textAlign: TextAlign.center,
                                  style:const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                            ],
                          );
                        } else {
                          return const Center(child: Text('No data available'));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

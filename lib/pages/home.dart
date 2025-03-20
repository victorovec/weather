import 'package:flutter/material.dart';
import 'package:app_weather/models/model.dart';
import 'package:app_weather/service/network.dart';
import 'package:lottie/lottie.dart';
import 'package:app_weather/service/transform.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        toolbarHeight: 45.h,
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
              side:  BorderSide(
                  color: Colors.yellow,
                  width: 1.w), // Outline color and thickness
                 
            ),
            child:  Row(
              children: [
                Text(
                  "Edit Location",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.0.sp,
                  ),
                ),
              const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                  size: 30,
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
    return Center(
      child: Padding(
        padding:  EdgeInsets.all(70.0.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Text(
                    country,
                    style:  TextStyle(
                      fontSize: 35.0.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
             SizedBox(height: 10.0.h),
            FutureBuilder<WeatherResponse>(
              future: getWeather(latitude,
                  longitude), // Fetch weather for specific coordinates
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
        
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
                        style:  TextStyle(
                          fontSize: 35.0.sp,
                          color: Colors.white,
                        ),
                      ),
                       SizedBox(height: 10.0.h),
                      Text(
                        weather.currentWeather.time,
                        style: TextStyle(
                          fontSize: 35.0.sp,
                          color: Colors.white,
                        ),
                      ),
                       SizedBox(height: 80.0.h),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              width: 100.w,
                              height: 100.h,
                              padding:  EdgeInsets.all(4.0.h),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.yellow, // Border color
                                  width:
                                      5.0.w, // Increased border width for more obvious border
                                ),
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Text(
                                'wnds\n${weather.currentWeather.windspeed}',
                                textAlign: TextAlign.center,
                                style:  TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ),
                           SizedBox(width: 20.0.w),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              height: 100.h,
                              padding:  EdgeInsets.all(4.0.h),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.yellow, // Border color
                                  width:
                                      5.0.w, // Increased border width for more obvious border
                                ),
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'wthc\n${weather.currentWeather.weathercode}',
                                textAlign: TextAlign.center,
                                style:  TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ),
                           SizedBox(width: 20.0.w),
                          Expanded(
                            child: Container(
                              width: 100.w,
                              height: 100.h,
                              padding:  EdgeInsets.all(4.0.h),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.yellow, // Border color
                                  width:
                                      5.0.w, // Increased border width for more obvious border
                                ),
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Text(
                                'tmez\n${weather.timezone}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
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
    );
  }

  // Tablet layout (larger screens or landscape mode)
  Widget _buildTabletLayout(
      double? latitude, double? longitude, String country) {
    return Expanded(
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
                padding:  EdgeInsets.all(70.0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      country,
                      style:  TextStyle(
                        fontSize: 35.0.sp,
                        color: Colors.white,
                      ),
                    ),
                     SizedBox(height: 10.0.h),
                    FutureBuilder<WeatherResponse>(
                      future: getWeather(latitude,
                          longitude), // Fetch weather for specific coordinates
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator(
                            color: Colors.white,
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
                                style:  TextStyle(
                                  fontSize: 35.0.sp,
                                  color: Colors.white,
                                ),
                              ),
                               SizedBox(height: 10.0.h),
                              Text(
                                weather.currentWeather.time,
                                style:  TextStyle(
                                  fontSize: 35.0.sp,
                                  color: Colors.white,
                                ),
                              ),
                               SizedBox(height: 50.0.h),
                              Row(
                          children: [
                            Expanded(
                              child: Container(
                                width: 100.w,
                                height: 100.h,
                                padding:  EdgeInsets.all(4.0.h),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.yellow, // Border color
                                    width:
                                        5.0.w, // Increased border width for more obvious border
                                  ),
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'windspeed\n${weather.currentWeather.windspeed}',
                                  textAlign: TextAlign.center,
                                  style:  TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            ),
                             SizedBox(width: 20.0.w),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                height: 100.h,
                                padding:  EdgeInsets.all(4.0.h),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.yellow, // Border color
                                    width:
                                        5.0.w, // Increased border width for more obvious border
                                  ),
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'weather code\n${weather.currentWeather.weathercode}',
                                  textAlign:TextAlign.center,
                                  style:  TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            ),
                             SizedBox(width: 20.0.w),
                            Expanded(
                              child: Container(
                                width: 100.w,
                                height: 100.h,
                                padding:  EdgeInsets.all(4.0.h),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.yellow, // Border color
                                    width:
                                        5.0.w, // Increased border width for more obvious border
                                  ),
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Timezone\n${weather.timezone}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
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

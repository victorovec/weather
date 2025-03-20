import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:app_weather/service/transform.dart';
import 'package:app_weather/service/network.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  List<String> timezones = [];

  @override
  void initState() {
    super.initState();
    fetchTimeZones((data) {
      setState(() {
        timezones = data;
      });
    });
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
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200.h,
              child: Lottie.asset('assets/weather2.json')),
             Text(
              'Weather',
              style: TextStyle(
                color: Colors.white,
                fontSize: 55.0.sp,
              ),
            ),

             Text(
              'Forecasts',
              style: TextStyle(
                color: Colors.yellow,
                fontSize: 55.0.sp,
              ),
            ),
             SizedBox(height: 10.0.h),
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
              child:  Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 20.0.sp,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200.h,
                    child: Lottie.asset('assets/weather2.json')),
                   Text(
                    'Weather',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 55.0.sp,
                    ),
                  ),
                   Text(
                    'Forecasts',
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 55.0.sp,
                    ),
                  ),
                   SizedBox(height: 50.0.h),
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
                    child:  Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 20.0.sp,
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

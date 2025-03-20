import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class TimeZoneSelectionPage extends StatelessWidget {
 const TimeZoneSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the arguments
   final timezones = ModalRoute.of(context)?.settings.arguments as List<String>;
    if (timezones.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text(
            'Select a Timezone',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
            ),
          centerTitle: true,
          ),
        body: const Center( child: Text('No timezones available')),
        
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text(
            'Select a Timezone',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            ),
          centerTitle: true,
          ),
        body: ListView.builder(
          itemCount: timezones.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                  timezones[index]), // Directly display the timezone string
          onTap: () async {
                  try {
                    final selectedTimezone = timezones[index];  //("Selected timezone: $selectedTimezone");
                  String country = selectedTimezone.replaceAll('_', ' ');
                    // Convert timezone to location name
                    
                    String locationName = selectedTimezone.replaceAll('_', ' ').split('/').last;

                    // Fetch location using Geocoding package
                    List<Location> locations = await locationFromAddress(locationName);

                    if (locations.isNotEmpty) {
                      double latitude = locations.first.latitude;
                      double longitude = locations.first.longitude;

                    // print("Fetched Coordinates: Latitude=$latitude, Longitude=$longitude");

                      // Navigate to home page and pass coordinates
                      if (context.mounted) {
                        Navigator.pushNamed(
                          context,
                          '/home',
                          arguments: {'latitude': latitude, 'longitude': longitude,'country':country },
                        );
                      }
                    } else {
                      throw Exception('No location found for timezone: $selectedTimezone');
                    }
                  } catch (e) {
                    //print("Error in onTap: $e");
                    if (context.mounted) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title:const Text('Error'),
                          content:const Text('Unable to fetch location for the selected timezone. Please try again.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child:const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                },



            );
          },
        ),
      );
    }
  }
}

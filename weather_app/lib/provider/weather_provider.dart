import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/keys.dart';

class WeatherProvider extends ChangeNotifier {
  TextEditingController controller = TextEditingController();
  String searchLocation = '';

  String forecastLocation = '';
  double forecastValue = 0.0;
  String forecastIcon = '';

  bool isLoading = false;

  Set<String> searchListLocations = {};
  List<double> searchListValues = [];
  List<String> searchListIcons = [];

  Future<void> getCurrentWeather(BuildContext context) async {
    if (searchLocation.isEmpty) {
      return;
    }

    try {
      isLoading = true;
      notifyListeners();

      final res = await http.get(
        Uri.parse(
            'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$searchLocation&aqi=no'),
      );

      final data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        forecastValue = data['current']['temp_c'];
        forecastLocation = data['location']['name'];
        forecastIcon = data['current']['condition']['icon'];

        searchListLocations.add(forecastLocation);
        searchListValues.add(forecastValue);
        searchListIcons.add(forecastIcon);
      }
    } catch (e) {
      showNoDataDialog(
          context, 'Failed to fetch weather data. Please try again.');
    } finally {
      //listen to the deleted data
      isLoading = false;
      notifyListeners();
    }
  }

  //Alert for errors
  void showNoDataDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void removeForecast(String location, double value, String icon) {
    searchListLocations.remove(location);
    searchListValues.remove(value);
    searchListIcons.remove(icon);
    notifyListeners();
  }
}

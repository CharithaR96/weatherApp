import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/city_forecast.dart';

import 'keys.dart';

var _controller = TextEditingController();
var searchList = [];
var forecastLocation = '';
var forecastValue = 0.0;
var forecastIcon = Icons.shape_line;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  Future getCurrentWeather() async {
    try {
      String cityName = 'London';
      final res = await http.get(
        Uri.parse(
            'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$cityName&aqi=no'),
      );

      if (res.statusCode == 200) {
        print(res.body);
      } else {
        print(res.statusCode);
      }
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.blueAccent,
          ),
        ),
      ),
      body: Column(
        children: [
          //Search Bar
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SearchBar(
              hintText: 'Search',
              leading: Icon(
                Icons.search,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          //Search list
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                CityForecast(
                  location: 'Colombo',
                  value: '37',
                  weatherIcon: Icons.sunny,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

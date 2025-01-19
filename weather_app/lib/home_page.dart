import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/city_forecast.dart';

import 'keys.dart';

var _controller = TextEditingController();
var searchList = [];
String forecastLocation = '';
double forecastValue = 0.0;
IconData forecastIcon = Icons.shape_line;
bool isLoading = false;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    //Network call to get weather data
    getCurrentWeather();
  }

  Future getCurrentWeather() async {
    try {
      setState(() {
        isLoading = true;
      });
      String cityName = 'London';
      final res = await http.get(
        Uri.parse(
            'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$cityName&aqi=no'),
      );
      //Getting data from network call
      final data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        setState(() {
          forecastValue = (data['current']['temp_c']);
          forecastLocation = (data['location']['name']);
          // forecastIcon = (data['current']['condition']['icon']);

          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
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
                //Show loading
                isLoading
                    ? CircularProgressIndicator()
                    : CityForecast(
                        location: forecastLocation,
                        value: forecastValue,
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

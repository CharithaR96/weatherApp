import 'package:flutter/material.dart';
import 'package:weather_app/city_forecast.dart';

var _controller = TextEditingController();
var searchList = [];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/city_forecast.dart';

import 'keys.dart';

var _controller = TextEditingController();
String searchLocation = '';
Set<String> searchList = {};
String forecastLocation = '';
double forecastValue = 0.0;
String forecastIcon = '';
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
    if (searchLocation.isNotEmpty) {
      getCurrentWeather();
    }
  }

  Future getCurrentWeather() async {
    try {
      setState(() {
        isLoading = true;
      });
      final res = await http.get(
        Uri.parse(
            'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$searchLocation&aqi=no'),
      );
      //Getting data from network call
      final data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        setState(() {
          forecastValue = (data['current']['temp_c']);
          forecastLocation = (data['location']['name']);
          forecastIcon = (data['current']['condition']['icon']);

          //Adding to the location list
          searchList.add(forecastLocation);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          _showDialog(context, (data['error']['message']));
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      throw e.toString();
    }
  }

  Future _showDialog(BuildContext context, String errorMessage) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
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
            child: TextField(
              textInputAction: TextInputAction.search,
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onSubmitted: (String value) {
                setState(() {
                  searchLocation = _controller.text;
                  getCurrentWeather();
                });
              },
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
                    : Column(
                        children: [
                          for (var i = 0; i < searchList.length; i++)
                            CityForecast(
                              location: forecastLocation,
                              value: forecastValue,
                              weatherIcon: ('https:$forecastIcon'),
                            ),
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

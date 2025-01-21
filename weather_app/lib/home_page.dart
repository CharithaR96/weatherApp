import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/city_forecast.dart';
import 'package:weather_app/provider/weather_provider.dart';

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
      body: Consumer<WeatherProvider>(
        builder: (context, weatherProvider, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  textInputAction: TextInputAction.search,
                  controller: weatherProvider.controller,
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onSubmitted: (String value) {
                    weatherProvider.searchLocation = value;
                    weatherProvider.getCurrentWeather(context);
                  },
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              //Search list
              weatherProvider.isLoading
                  ? const CircularProgressIndicator()
                  : Expanded(
                      child: ListView.builder(
                        itemCount: weatherProvider.searchListLocations.length,
                        itemBuilder: (context, index) {
                          return CityForecast(
                            value: weatherProvider.searchListValues
                                .elementAt(index),
                            location: weatherProvider.searchListLocations
                                .elementAt(index),
                            weatherIcon: weatherProvider.searchListIcons
                                .elementAt(index),
                            indexItem: index.toString(),
                          );
                        },
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';

class CityForecast extends StatelessWidget {
  //Constructor
  final String location;
  final double value;
  final String weatherIcon;
  final String indexItem;

  const CityForecast({
    super.key,
    required this.location,
    required this.value,
    required this.weatherIcon,
    required this.indexItem,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, weatherProvider, child) {
        return SizedBox(
          height: 120,
          width: MediaQuery.of(context).size.width,
          child: (location.isEmpty)
              ? SizedBox(
                  height: 0,
                )
              : Card(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 10,
                          child: Column(
                            children: [
                              Text(
                                location,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Image.network(
                                ('https:$weatherIcon'),
                                height: 40,
                              ),
                              Text(
                                ('$value°C'),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            icon: const Icon(
                              Icons.delete,
                            ),
                            onPressed: () {
                              weatherProvider.removeForecast(
                                  location, value, weatherIcon);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}

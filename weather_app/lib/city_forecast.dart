import 'package:flutter/material.dart';

class CityForecast extends StatelessWidget {
  //Constructor
  final String location;
  final String value;
  final IconData weatherIcon;

  const CityForecast({
    super.key,
    required this.location,
    required this.value,
    required this.weatherIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
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
              Icon(
                weatherIcon,
                size: 30,
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
      ),
    );
  }
}

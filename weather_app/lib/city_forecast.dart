import 'package:flutter/material.dart';

class CityForecast extends StatelessWidget {
  //Constructor
  final String location;
  final double value;
  final String weatherIcon;

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
                      flex: 15,
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
                            weatherIcon,
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
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                        child: IconButton(
                          icon: const Icon(
                            Icons.delete,
                          ),
                          onPressed: () {
                            //delete cities
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

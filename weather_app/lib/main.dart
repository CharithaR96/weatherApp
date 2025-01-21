import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/home_page.dart';
import 'package:weather_app/provider/weather_provider.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WeatherProvider(),
      child: MaterialApp(
        theme: ThemeData.dark(),
        home: const HomePage(),
      ),
    );
  }
}

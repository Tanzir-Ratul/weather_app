import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/app/ui/weather_home/weather_section.dart';
import 'package:weather_app/app/viewmodel/weather_home_viewmodel/weather_home_viewmodel.dart';

import '../components/custom_text_widget.dart';
import 'forecast_section.dart';

class WeatherScreen extends GetView<WeatherHomeController> {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Weather Application',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blueAccent[100],
        ),
        body: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(
                'assets/images/beautiful_skyscape_daytime.jpg',
                fit: BoxFit.cover,
              ),
            ),
            // Blur effect
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
            ),
            const Column(
              children: [
                SizedBox(height: 50),
                WeatherSection(),
                SizedBox(height: 30,),
                Expanded(
                  child: ForecastSection(),
                ),
                SizedBox(height: 20,)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

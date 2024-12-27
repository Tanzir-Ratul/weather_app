import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/app/ui/weather_home/weather_section.dart';
import 'package:weather_app/app/viewmodel/weather_home_viewmodel/weather_home_viewmodel.dart';

import 'forecast_section.dart';

class WeatherScreen extends GetView<WeatherHomeController> {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(
                height: screenHeight,
                'assets/images/beautiful_skyscape_daytime.jpg',
                fit: BoxFit.fitHeight,
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
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                IntrinsicHeight(
                  child: Obx(() {
                    return controller.isLoading.value
                        ? const SizedBox(
                            height: 200,
                            child: Center(child: CircularProgressIndicator()))
                        : WeatherSection(screenWidth: screenWidth);
                  }),
                ),
                const Spacer(),
                SizedBox(
                    height: screenHeight * .3, child: const ForecastSection()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

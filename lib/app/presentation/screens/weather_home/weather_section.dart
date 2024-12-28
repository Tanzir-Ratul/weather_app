import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/app/utils/helper_function.dart';

import '../../../utils/constant.dart';
import '../../viewmodel/weather_home_viewmodel/weather_home_viewmodel.dart';
import '../components/custom_text_widget.dart';
import '../components/network_image.dart';

class WeatherSection extends GetView<WeatherHomeController> {
  final double screenWidth;

  const WeatherSection({super.key, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    final isTablet = screenWidth > 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => CustomText(
            text:
                '${controller.weatherData.value.name}, ${controller.weatherData.value.country}',
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        Obx(
          () => CustomText(
              text:
                  Helper.formatTimestamp(controller.weatherData.value.dt ?? 0),
              color: Colors.white),
        ),
        const SizedBox(height: 30),
        Obx(
          () => CustomText(
            text:
                '${controller.displayedTemperature.toStringAsFixed(1)} ${controller.isCelsius.value ? '°C' : '°F'}',
            fontSize: 70,
            color: Colors.white,
          ),
        ),
        Obx(
          () => Switch(
            value: controller.isCelsius.value,
            onChanged: (newValue) {
              controller.toggleTemperatureUnit();
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,
          ),
        ),
        const SizedBox(height: 30),
        Obx(
          () => CustomText(
            text:
                'Feels like ${controller.weatherData.value.feelsLike?.toInt()}${Constant.degreeSymbol}C',
            color: Colors.white,
          ),
        ),
        //const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () {
                final iconLink = Helper.concatIconUrl(
                    controller.weatherData.value.icon ?? '');
                if (kDebugMode) {
                  print('iconLink$iconLink');
                }
                return NetworkImageSet(
                  imageUrl: iconLink,
                  height: 50,
                  width: 50,
                );
              },
            ),
            const SizedBox(width: 10),
            Obx(
              () => CustomText(
                text: controller.weatherData.value.description ?? '',
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Container(
          padding: EdgeInsets.symmetric(horizontal: isTablet ? 40 : 10),
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => buildWeatherDataColumn()),
              const VerticalDivider(
                width: 20,
                color: Colors.white,
                thickness: 2,
                indent: 10,
                endIndent: 10,
              ),
              Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text:
                          'Sunrise ${Helper.toFormattedTime(controller.weatherData.value.sunrise?.toInt() ?? 0)}',
                      color: Colors.white,
                    ),
                    CustomText(
                      text:
                          'Sunset ${Helper.toFormattedTime(controller.weatherData.value.sunset?.toInt() ?? 0)}',
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column buildWeatherDataColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text:
              'Humidity ${controller.weatherData.value.humidity}${Constant.degreeSymbol}C',
          color: Colors.white,
        ),
        CustomText(
          text: 'Pressure ${controller.weatherData.value.pressure}hpa',
          color: Colors.white,
        ),
        CustomText(
          text: 'Visibility ${controller.weatherData.value.visibility}km',
          color: Colors.white,
        ),
      ],
    );
  }
}

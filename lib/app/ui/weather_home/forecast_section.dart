import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/app/ui/components/network_image.dart';
import 'package:weather_app/app/utils/constant.dart';
import 'package:weather_app/app/utils/helper_function.dart';
import 'package:weather_app/app/viewmodel/weather_home_viewmodel/weather_home_viewmodel.dart';

import '../components/custom_text_widget.dart';

class ForecastSection extends GetView<WeatherHomeController> {
  const ForecastSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final cardWidth = isTablet ? screenWidth / 5 : screenWidth / 3.5;

    return Obx(
      () {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.forecastData.value.list?.length ?? 0,
          itemBuilder: (context, index) {
            final item = controller.forecastData.value.list?[index];
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SizedBox(
                  width: cardWidth,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    child: Column(
                      children: [
                        CustomText(
                          text: Helper.getDayOfWeek(item?.dt ?? 0),
                          color: Colors.white,
                        ),
                        const SizedBox(height: 10),
                        CustomText(
                          text: Helper.toFormattedTime(item?.dt ?? 0),
                          color: Colors.white,
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: NetworkImageSet(
                            imageUrl: Helper.concatIconUrl(
                                item?.weather?.first.icon ?? ''),
                            fit: BoxFit.fill,
                          ),
                        ),
                        const Spacer(),
                        CustomText(
                          text: '${item?.main?.temp}${Constant.degreeSymbol}C',
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

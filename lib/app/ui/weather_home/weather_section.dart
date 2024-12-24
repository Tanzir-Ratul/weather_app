import 'package:flutter/material.dart';

import '../../utils/constant.dart';
import '../components/custom_text_widget.dart';

class WeatherSection extends StatelessWidget {
  const WeatherSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CustomText(
          text: 'Dhaka',
          color: Colors.white,
        ),
        CustomText(text: 'Dec 24 2024', color: Colors.white),
        SizedBox(height: 30),
        CustomText(
          text: '25${Constant.degreeSymbol}',
          fontSize: 70,
          color: Colors.white,
        ),
        SizedBox(height: 30),
        CustomText(
          text: 'Feels like 20${Constant.degreeSymbol}C',
          color: Colors.white,
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.percent_sharp),
            SizedBox(width: 10),
            CustomText(
              text: 'Clear Sky',
              color: Colors.white,
            ),
          ],
        ),
        SizedBox(height: 30),
        SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Humidity 71${Constant.degreeSymbol}C',
                    color: Colors.white,
                  ),
                  CustomText(
                    text: 'Pressure 12000hpa',
                    color: Colors.white,
                  ),
                  CustomText(
                    text: 'Visibility 1000km',
                    color: Colors.white,
                  ),
                ],
              ),
              VerticalDivider(
                width: 20,
                color: Colors.white,
                thickness: 2,
                indent: 10,
                endIndent: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Sunrise 05:49',
                    color: Colors.white,
                  ),
                  CustomText(
                    text: 'Sunset 17:42',
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

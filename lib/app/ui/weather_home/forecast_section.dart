import 'package:flutter/material.dart';
import 'package:weather_app/app/ui/components/network_image.dart';
import 'package:weather_app/app/utils/constant.dart';

import '../components/custom_text_widget.dart';

class ForecastSection extends StatelessWidget {
  const ForecastSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 20,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // Rounded corners
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                child: Column(
                  children: [
                    CustomText(
                      text: 'Thu',
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: '03:00',
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: NetworkImageSet(
                        imageUrl: '',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Spacer(),
                    CustomText(
                      text: '70${Constant.degreeSymbol}C',
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}

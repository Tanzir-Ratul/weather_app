
import 'package:get/get.dart';
import 'package:weather_app/app/routes/routes_path.dart';

import '../ui/weather_home/weather_screen.dart';


class AppRoutes {
  static final pages = [
    GetPage(
      name: Routes.initial,
      page: () => const WeatherScreen(),
    ),

  ];
}

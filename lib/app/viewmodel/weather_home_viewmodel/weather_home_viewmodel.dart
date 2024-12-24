import 'package:get/get.dart';

import '../../data/repository/weather_repo.dart';

class WeatherHomeController extends GetxController{

  WeatherRepository repository;

  WeatherHomeController(this.repository);
  //dotenv.env['APP_BASE_URL'] ?? "";
}
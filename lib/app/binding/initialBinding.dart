import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:weather_app/app/data/repository/weather_repo.dart';

import 'package:weather_app/app/viewmodel/weather_home_viewmodel/weather_home_viewmodel.dart';

import '../data/data_source/network/api_services/base_api_services.dart';
import '../data/data_source/network/api_services/network_api_services.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {

    Get.put<Dio>(Dio());
    Get.put<BaseApiServices>(
        HttpClientService(Get.find<Dio>()),
        permanent: true);
    //DatabaseHelper().initDatabase();
    Get.put<WeatherRepository>(WeatherRepositoryImpl(Get.find<BaseApiServices>()));
    Get.put<WeatherHomeController>(WeatherHomeController(Get.find<WeatherRepository>()), permanent: true);

  }
}

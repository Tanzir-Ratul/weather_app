import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:weather_app/app/domain/repository/weather_repo.dart';


import '../../data/data_source/local/databases/database_helper.dart';
import '../../data/data_source/network/api_services/base_api_services.dart';
import '../../data/data_source/network/api_services/network_api_services.dart';
import '../../data/repository/weather_repo_impl.dart';

import '../../domain/usecases/db_use_case/db_use_case.dart';
import '../../domain/usecases/forecast_use_case/forecast_use_case.dart';
import '../../domain/usecases/weather_use_case/weather_use_case.dart';
import '../viewmodel/weather_home_viewmodel/weather_home_viewmodel.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies()  {
    Get.put<Dio>(Dio());
    Get.put<BaseApiServices>(
      HttpClientService(Get.find<Dio>()),
      permanent: true,
    );

    // Initialize DatabaseHelper and ensure the database is ready.
    final databaseHelper = DatabaseHelper();
    databaseHelper.initDatabase();

    Get.put<WeatherRepository>(
      WeatherRepositoryImpl(Get.find<BaseApiServices>(), databaseHelper),
    );

    Get.lazyPut<FetchWeatherUseCase>(() => FetchWeatherUseCase(Get.find()));
    Get.lazyPut<FetchForecastUseCase>(() => FetchForecastUseCase(Get.find()));
    Get.lazyPut<InsertWeatherDataUseCase>(() => InsertWeatherDataUseCase(Get.find()));
    Get.lazyPut<GetWeatherDataUseCase>(() => GetWeatherDataUseCase(Get.find()));
    Get.lazyPut<DeleteWeatherDataUseCase>(() => DeleteWeatherDataUseCase(Get.find()));

    Get.put<WeatherHomeController>(
      WeatherHomeController(
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
      ),
    );
  }
}

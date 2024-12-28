import 'package:weather_app/app/domain/entities/weather_data.dart';

import '../../data/data_source/network/response/api_response.dart';

import '../entities/forecast_data.dart';

abstract class WeatherRepository {
  Future<ApiResponse<WeatherDataClass>> fetchCurrentWeather(
      Map<String, dynamic>? data);

  Future<ApiResponse<List<ForecastDataClass>>> fetchForecastData(
      Map<String, dynamic>? data);

  Future<void> insertWeatherData(WeatherDataClass weatherData);
  Future<List<WeatherDataClass>> getWeatherData();
  Future<void> deleteWeatherData();
}

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/url.dart';
import '../data_source/network/api_services/base_api_services.dart';
import '../data_source/network/exception/StatusCodeHandler.dart';
import '../data_source/network/response/api_response.dart';
import '../model/current_weather_data.dart';
import '../model/forecast_data.dart';


abstract class WeatherRepository {
  Future<ApiResponse<CurrentWeatherData>> fetchCurrentWeather(
      Map<String, dynamic>? data);

  Future<ApiResponse<ForecastData>> fetchForecastData(
      Map<String, dynamic>? data);


}

class  WeatherRepositoryImpl extends WeatherRepository {
  final BaseApiServices _apiClient;
  WeatherRepositoryImpl(this._apiClient);

  @override
  Future<ApiResponse<CurrentWeatherData>> fetchCurrentWeather (
      Map<String, dynamic>? data) async {
    try {
      final response = await _apiClient.get(Urls.currentWeather, queryParameters: data ?? {});
      debugPrint('repos $response');
      return ApiResponse.completed(CurrentWeatherData.fromJson(response.data),response.statusCode);
    } on DioException catch (e) {
      return ApiResponse.error(handleDioError(e));
    } catch (e) {
      return ApiResponse.error('Unexpected error');
    }
  }

  @override
  Future<ApiResponse<ForecastData>> fetchForecastData(Map<String, dynamic>? data) async{
    try {
      final response = await _apiClient.get(Urls.forecast, queryParameters: data ?? {});
      debugPrint('repos $response');
      return ApiResponse.completed(ForecastData.fromJson(response.data),response.statusCode);
    } on DioException catch (e) {
      return ApiResponse.error(handleDioError(e));
    } catch (e) {
      return ApiResponse.error('Unexpected error');
    }
  }



}


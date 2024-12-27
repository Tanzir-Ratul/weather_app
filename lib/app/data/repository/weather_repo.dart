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
      debugPrint('reposfetchCurrentWeather $response');
      if (response.statusCode == 200) {
        return ApiResponse.completed(CurrentWeatherData.fromJson(response.data), response.statusCode);
      } else {
        return ApiResponse.error('Failed to fetch data with status code: ${response.statusCode}');
      }    } on DioException catch (e) {
      return ApiResponse.error(handleDioError(e));
    } catch (e,stackTrace) {
      print('errorIn:$e');
      print('Error parsing data: $e');
      print('Stack trace: $stackTrace');
      return ApiResponse.error('Unexpected error');
    }
  }

  @override
  Future<ApiResponse<ForecastData>> fetchForecastData(Map<String, dynamic>? data) async{
    try {
      final response = await _apiClient.get(Urls.forecast, queryParameters: data ?? {});
      debugPrint('reposfetchForecastData $response');
      return ApiResponse.completed(ForecastData.fromJson(response.data),response.statusCode);
    } on DioException catch (e) {
      return ApiResponse.error(handleDioError(e));
    } catch (e) {
      print('error:$e');
      return ApiResponse.error('Unexpected error');
    }
  }



}


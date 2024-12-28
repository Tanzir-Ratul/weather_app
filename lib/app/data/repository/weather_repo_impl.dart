import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_app/app/domain/entities/weather_data.dart';

import '../../domain/entities/forecast_data.dart';
import '../data_source/local/databases/database_helper.dart';
import '../data_source/network/api_services/base_api_services.dart';
import '../data_source/network/exception/StatusCodeHandler.dart';
import '../data_source/network/response/api_response.dart';
import '../mappers/current_weather_dto_to_weather_data.dart';
import '../mappers/forecasr_mapper.dart';
import '../model/current_weather_data.dart';
import '../model/forecast_data.dart';
import '../../domain/repository/weather_repo.dart';
import '../../utils/url.dart';

class  WeatherRepositoryImpl extends WeatherRepository {
  final BaseApiServices _apiClient;
  final DatabaseHelper _databaseHelper;

  WeatherRepositoryImpl(this._apiClient,this._databaseHelper){
    print("WeatherRepository initialized with DatabaseHelper: ${_databaseHelper}");

  }

  @override
  Future<ApiResponse<WeatherDataClass>> fetchCurrentWeather (
      Map<String, dynamic>? data) async {
    try {
      final response = await _apiClient.get(Urls.currentWeather, queryParameters: data ?? {});
      if (response.statusCode == 200) {
        final  currentWeatherDTO = CurrentWeatherDataDTO.fromJson(response.data);

        return ApiResponse.completed(WeatherMapper.mapDtoToDomain(currentWeatherDTO),response.statusCode);
      } else {
        return ApiResponse.error('Failed to fetch data with status code: ${response.statusCode}');
      }    } on DioException catch (e) {
      return ApiResponse.error(handleDioError(e));
    } catch (e,stackTrace) {
      if (kDebugMode) {
        print('Error parsing data: $e');
        print('Stack trace: $stackTrace');
      }

      return ApiResponse.error('Unexpected error');
    }
  }

  @override
  Future<ApiResponse<List<ForecastDataClass>>> fetchForecastData(Map<String, dynamic>? data) async{
    try {
      final response = await _apiClient.get(Urls.forecast, queryParameters: data ?? {});
      final forecastDataDTO = ForecastDataDTO.fromJson(response.data);
      final  mappedData = ForecastDataMapper.mapDtoListToDomainList(forecastDataDTO);
      return ApiResponse.completed(mappedData,response.statusCode);
    } on DioException catch (e) {
      return ApiResponse.error(handleDioError(e));
    } catch (e) {
      if (kDebugMode) {
        print('error:$e');
      }
      return ApiResponse.error('Unexpected error');
    }
  }

  @override
  Future<void> deleteWeatherData() async{
    return await(await _databaseHelper.weatherDataDao).deleteAllWeatherData();
  }

  @override
  Future<WeatherDataClass> getWeatherData() async{
    return await(await _databaseHelper.weatherDataDao).fetchWeatherData();
  }

  @override
  Future<void> insertWeatherData(WeatherDataClass weatherData) async{
    print('insertRepos ${weatherData.toJson()}');
    return await(await _databaseHelper.weatherDataDao).insertWeatherData(weatherData);
  }



}

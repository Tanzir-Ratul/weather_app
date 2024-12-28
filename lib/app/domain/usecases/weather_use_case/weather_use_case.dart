import '../../../data/data_source/network/response/api_response.dart';
import '../../entities/weather_data.dart';
import '../../repository/weather_repo.dart';

class FetchWeatherUseCase {
  final WeatherRepository weatherRepository;

  FetchWeatherUseCase(this.weatherRepository);

  Future<ApiResponse<WeatherDataClass>> execute(Map<String, dynamic> data) {
    return weatherRepository.fetchCurrentWeather(data);
  }
}
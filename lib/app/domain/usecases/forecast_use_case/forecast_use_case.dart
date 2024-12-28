
import 'package:weather_app/app/domain/entities/forecast_data.dart';

import '../../../data/data_source/network/response/api_response.dart';
import '../../repository/weather_repo.dart';

class FetchForecastUseCase {
  final WeatherRepository weatherRepository;

  FetchForecastUseCase(this.weatherRepository);

  Future<ApiResponse<List<ForecastDataClass>>> execute(Map<String, dynamic> data) {
    return weatherRepository.fetchForecastData(data);
  }
}
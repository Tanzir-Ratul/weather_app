import '../../entities/weather_data.dart';
import '../../repository/weather_repo.dart';

class InsertWeatherDataUseCase {
  final WeatherRepository _repository;

  InsertWeatherDataUseCase(this._repository);

  Future<void> execute(WeatherDataClass weatherData) async {
    print("indertUseCase ${weatherData.toJson()}");
    await _repository.insertWeatherData(weatherData);
  }
}

class GetWeatherDataUseCase {
  final WeatherRepository _repository;

  GetWeatherDataUseCase(this._repository);

  Future<WeatherDataClass> execute() async {
    return await _repository.getWeatherData();
  }
}

class DeleteWeatherDataUseCase {
  final WeatherRepository _repository;

  DeleteWeatherDataUseCase(this._repository);

  Future<void> execute() async {
    await _repository.deleteWeatherData();
  }
}

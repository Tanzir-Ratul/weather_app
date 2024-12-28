import '../../domain/entities/forecast_data.dart';
import '../../domain/entities/weather_data.dart';
import '../model/current_weather_data.dart';
import '../model/forecast_data.dart';

class WeatherMapper {
  static WeatherDataClass mapDtoToDomain(CurrentWeatherDataDTO dto) {
    return WeatherDataClass(
      name: dto.name,
      country: dto.sys?.country,
      dt: dto.dt,
      temp: dto.main?.temp ?? 0.0,
      feelsLike: dto.main?.feelsLike ?? 0.0,
      icon: dto.weather?.isNotEmpty == true ? dto.weather!.first.icon : '',
      description: dto.weather?.isNotEmpty == true ? dto.weather!.first.description : '',
      sunrise: dto.sys?.sunrise ?? 0.0,
      sunset: dto.sys?.sunset ?? 0.0,
      humidity: dto.main?.humidity ?? 0,
      pressure: dto.main?.pressure ?? 0,
      visibility: dto.visibility ?? 0,
    );
  }




}

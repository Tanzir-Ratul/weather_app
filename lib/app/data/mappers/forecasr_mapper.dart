import '../../domain/entities/forecast_data.dart';
import '../model/forecast_data.dart';

class ForecastDataMapper {
  static List<ForecastDataClass> mapDtoListToDomainList(ForecastDataDTO dto) {
    if (dto.list != null && dto.list!.isNotEmpty) {
      return dto.list!.map((element) {
        return ForecastDataClass(
          description: element.weather?.first.description,
          dt: element.dt,
          temp: element.main?.temp,
          icon: element.weather?.first.icon
        );
      }).toList();
    } else {
      return [];
    }
  }
}


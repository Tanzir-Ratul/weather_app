
import 'package:sqflite/sqflite.dart';
import 'package:weather_app/app/utils/constant.dart';

import '../../../../../domain/entities/weather_data.dart';




class WeatherDataDAO {
  final Database db;

  WeatherDataDAO(this.db);

  /// Insert a WeatherDataClass
  Future<void> insertWeatherData(WeatherDataClass weatherData) async {
    try {
      print("Inserting data: ${weatherData.toJson()}");
      await db.insert(
        Constant.tableName,
        weatherData.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print("Data inserted successfully");
    } catch (e) {
      print("Error inserting weather data: $e");

    }
  }

  /// Fetch all WeatherData
  Future<WeatherDataClass> fetchWeatherData() async {
    try {
      final List<Map<String, dynamic>>? maps = await db.query(Constant.tableName);

      if (maps != null && maps.isNotEmpty) {
        return WeatherDataClass.fromMap(maps.first);
      } else {
        return WeatherDataClass();
      }
    } catch (e) {
      print("Error fetching weather data: $e");
      return WeatherDataClass();
    }
  }


  /// Delete all WeatherData
  Future<void> deleteAllWeatherData() async {
    try {
      await db.delete(Constant.tableName);
      print("All weather data deleted successfully");
    } catch (e) {
      print("Error deleting weather data: $e");
    }
  }
}


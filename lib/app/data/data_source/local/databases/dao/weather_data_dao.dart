
import 'package:sqflite/sqflite.dart';
import 'package:weather_app/app/utils/constant.dart';

import '../../../../../domain/entities/weather_data.dart';


class WeatherDataDAO {
  final Database? db;

  WeatherDataDAO(this.db);

  // Insert a WeatherDataClass
  Future<void> insertWeatherData(WeatherDataClass weatherData) async {
    try{

      print('Database initialized: $db');
      print("Inserting data:${weatherData.toJson()} ---- ${weatherData.toMap()}");
      await db?.insert(
        Constant.tableName,
        weatherData.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }catch(e){
      print("inside catch $e");
    }
  }

  // Fetch all WeatherData
  Future<List<WeatherDataClass>> fetchWeatherData() async {
    final List<Map<String, dynamic>>? maps = await db?.query(Constant.tableName);

    return List.generate(maps!.length, (i) {
      return WeatherDataClass(
        name: maps[i]['name'],
        country: maps[i]['country'],
        dt: maps[i]['dt'],
        temp: maps[i]['temp'],
        feelsLike: maps[i]['feelsLike'],
        icon: maps[i]['icon'],
        description: maps[i]['description'],
        sunrise: maps[i]['sunrise'],
        sunset: maps[i]['sunset'],
        humidity: maps[i]['humidity'],
        pressure: maps[i]['pressure'],
        visibility: maps[i]['visibility'],
      );
    });
  }

  Future<void> deleteAllWeatherData() async {
    await db?.delete(
      Constant.tableName, // Table name
    );
  }
}


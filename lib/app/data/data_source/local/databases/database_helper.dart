import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather_app/app/data/data_source/local/databases/dao/weather_data_dao.dart';
import 'dart:io' as io;

import '../../../../utils/constant.dart';


class DatabaseHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, Constant.dbName);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  Future _onCreate(Database db, int version) async {
    await  db.execute(
      '''CREATE TABLE ${Constant.tableName}(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            country TEXT,
            dt INTEGER,
            temp REAL,
            feelsLike REAL,
            icon TEXT,
            description TEXT,
            sunrise REAL,
            sunset REAL,
            humidity INTEGER,
            pressure INTEGER,
            visibility INTEGER)''',
    );
  }

  WeatherDataDAO? _weatherDao;

  Future<WeatherDataDAO> get weatherDataDao async {
    final database = await db;
    if (database == null) {
      throw Exception("Database is not initialized.");
    }
    _weatherDao ??= WeatherDataDAO(database);
    return _weatherDao!;
  }

}

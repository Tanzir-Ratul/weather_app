/*
import 'package:sqflite/sqflite.dart';

import '../../../../models/general_category.dart';
import '../../../../utils/global_data/constant.dart';

class GeneralCategoryDAO {
  final Database? _db;

  GeneralCategoryDAO(this._db);

  Future<void> insertCategories(List<Category> categories) async {
    final batch = _db?.batch();
    for (var category in categories) {
      batch?.insert(
        Constant.generalCategory,
        category.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch?.commit();
  }

  Future<List<Category>> getCategories() async {
    final List<Map<String, Object?>>? maps =
        await _db?.query(Constant.generalCategory);
    return List.generate(maps?.length ?? 0, (i) {
      return Category.fromJson(maps?[i] ?? {});
    });
  }

  Future<void> deleteGeneralCategory() async {
    await _db?.delete(Constant.generalCategory);
  }

  Future<void> deleteGeneralCategoryById(int id) async {
    await _db?.delete(
      Constant.generalCategory,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
*/

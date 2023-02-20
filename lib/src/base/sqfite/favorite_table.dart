import 'package:cinema/src/base/sqfite/sql_dao.dart';
import 'package:cinema/src/model/favorite_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@Singleton()
class FavoriteTable implements SqlDao<FavoriteEntity> {
  static const String tableName = "favorite_entity";
  static const String columnNameID = "id";
  static const String columnNameImage = "image";

  final Database db;

  @FactoryMethod()
  FavoriteTable(this.db);

  @override
  Future<int> delete(String id) async {
    final numberColumn = await db
        .delete(tableName, where: '${columnNameID} = ?', whereArgs: [id]);

    return numberColumn;
  }

  @override
  Future<FavoriteEntity?> findByID(String id) async {
    List<Map> maps = await db.query(tableName,
        columns: [columnNameID, columnNameImage],
        where: '$columnNameID = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return FavoriteEntity.fromJson(maps.first as Map<String, dynamic>);
    }
    return null;
  }

  @override
  Future<FavoriteEntity?> insert(entity) async {
    try {
      final _id = await db.insert(tableName, entity.toJson());
      return entity;
    } on Exception catch (_) {
      return null;
    }
  }

  @override
  Future<bool> update(entity) async {
    final numberColumn = await db.update(tableName, entity.toJson(),
        where: '$columnNameID = ?', whereArgs: [entity.id]);
    return numberColumn > 0;
  }

  @override
  Future<List<FavoriteEntity>> getAll() async {
    List<Map> maps =
        await db.query(tableName, columns: [columnNameID, columnNameImage]);
    if (maps.isNotEmpty) {
      final list = maps
          .map((e) => FavoriteEntity.fromJson(e as Map<String, dynamic>))
          .toList()
          .reversed
          .toList();
      return list;
    }
    return [];
  }
}

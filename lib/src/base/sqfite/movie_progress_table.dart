import 'package:cinema/src/base/sqfite/sql_dao.dart';
import 'package:cinema/src/model/movie_progress.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@Singleton()
class MovieProgressTable implements SqlDao<MovieProgress> {
  static const String tableName = "movie_progress_table";
  static const String columnIdMovie = 'idMovie';
  static const String columnImage = 'image';
  static const String columnCurrentProgress = 'currentProgress';
  static const String columnMaxProgress = 'maxProgress';
  static const String columnLastWatched = 'lastWatched';
  static const String columnEpisode = 'episode';

  final Database db;

  @FactoryMethod()
  MovieProgressTable(this.db);

  @override
  Future<int> delete(String id) async {
    final numberColumn = await db
        .delete(tableName, where: '$columnIdMovie = ?', whereArgs: [id]);

    return numberColumn;
  }

  @override
  Future<MovieProgress?> findByID(String id) async {
    List<Map> maps = await db.query(tableName,
        columns: [
          columnIdMovie,
          columnImage,
          columnCurrentProgress,
          columnMaxProgress,
          columnLastWatched,
          columnEpisode
        ],
        where: '$columnIdMovie = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return MovieProgress.fromJson(maps.first as Map<String, dynamic>);
    }
    return null;
  }

  @override
  Future<List<MovieProgress>> getAll() async {
    List<Map> maps = await db.query(tableName, columns: [
      columnIdMovie,
      columnImage,
      columnCurrentProgress,
      columnMaxProgress,
      columnLastWatched,
      columnEpisode
    ]);
    if (maps.isNotEmpty) {
      final list = maps
          .map((e) => MovieProgress.fromJson(e as Map<String, dynamic>))
          .toList()
          .reversed
          .toList();
      return list;
    }
    return [];
  }

  @override
  Future<MovieProgress?> insert(MovieProgress entity) async {
    try {
      final _id = await db.insert(tableName, entity.toJson());
      return entity;
    } on Exception catch (_) {
      return null;
    }
  }

  @override
  Future<bool> update(MovieProgress entity) async {
    final numberColumn = await db.update(tableName, entity.toJson(),
        where: '$columnIdMovie = ?', whereArgs: [entity.idMovie]);
    return numberColumn > 0;
  }
}

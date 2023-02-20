import 'package:cinema/src/base/sqfite/database_config.dart';
import 'package:cinema/src/base/sqfite/favorite_table.dart';
import 'package:cinema/src/base/sqfite/movie_progress_table.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@module
abstract class SqlFileHelper {
  @preResolve
  Future<Database> initDatabase() async {
    final path = await getDatabasesPath();
    final pathDatabase = "$path/${DatabaseConfig.databaseName}";

    final db = await openDatabase(
      pathDatabase,
      version: DatabaseConfig.version,
      onCreate: (Database db, int version) async {
        await db.execute('''
  create table ${FavoriteTable.tableName} ( 
  ${FavoriteTable.columnNameID} text not null,
  ${FavoriteTable.columnNameImage} text not null)
  ''');

        await db.execute('''
  create table ${MovieProgressTable.tableName} ( 
  ${MovieProgressTable.columnIdMovie} text not null,
  ${MovieProgressTable.columnImage} text not null,
  ${MovieProgressTable.columnCurrentProgress} text not null,
  ${MovieProgressTable.columnMaxProgress} text not null,
  ${MovieProgressTable.columnLastWatched} text not null,
  ${MovieProgressTable.columnEpisode} text not null
  )
  ''');
      },
    );

    return db;
  }
}

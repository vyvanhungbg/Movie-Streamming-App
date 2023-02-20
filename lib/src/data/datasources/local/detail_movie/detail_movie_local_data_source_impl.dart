import 'package:cinema/src/base/sqfite/favorite_table.dart';
import 'package:cinema/src/data/datasources/local/detail_movie/detail_movie_local_data_source.dart';
import 'package:cinema/src/model/favorite_entity.dart';

class DetailMovieLocalDataSourceImpl implements DetailMovieLocalDataSource {
  final FavoriteTable db;

  DetailMovieLocalDataSourceImpl(this.db);

  @override
  Future<int> deleteFavoriteMovie(String id) {
    return db.delete(id);
  }

  @override
  Future<FavoriteEntity?> insertFavoriteMovie(FavoriteEntity entity) {
    return db.insert(entity);
  }

  @override
  Future<FavoriteEntity?> findMovie(String id) {
    return db.findByID(id);
  }

  @override
  Future<List<FavoriteEntity>> getAllMovies() {
    return db.getAll();
  }
}

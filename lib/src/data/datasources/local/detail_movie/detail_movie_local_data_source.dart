import 'package:cinema/src/base/sqfite/favorite_table.dart';
import 'package:cinema/src/data/datasources/local/detail_movie/detail_movie_local_data_source_impl.dart';
import 'package:cinema/src/model/favorite_entity.dart';
import 'package:injectable/injectable.dart';

@Singleton()
abstract class DetailMovieLocalDataSource {
  @factoryMethod
  factory DetailMovieLocalDataSource(FavoriteTable db) =>
      DetailMovieLocalDataSourceImpl(db);

  Future<FavoriteEntity?> insertFavoriteMovie(FavoriteEntity entity);

  Future<int> deleteFavoriteMovie(String id);

  Future<FavoriteEntity?> findMovie(String id);

  Future<List<FavoriteEntity>> getAllMovies();
}

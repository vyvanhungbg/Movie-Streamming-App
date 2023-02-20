import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/model/favorite_entity.dart';
import 'package:cinema/src/model/movie_detail.dart';

abstract class DetailMovieRepository {
  Future<DataState<MovieDetail?>> getMoviesById(Map<String, String> parameters);
  Future<DataState<FavoriteEntity?>> addFavorite(FavoriteEntity entity);
  Future<DataState<int>> removeFavorite(String id);
  Future<DataState<FavoriteEntity?>> findByID(String id);
  Future<DataState<List<FavoriteEntity>>> getAll();
}

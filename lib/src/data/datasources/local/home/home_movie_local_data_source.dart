import 'package:cinema/src/base/sqfite/movie_progress_table.dart';
import 'package:cinema/src/data/datasources/local/home/home_movie_local_data_source_impl.dart';
import 'package:cinema/src/model/movie_progress.dart';
import 'package:injectable/injectable.dart';

@Singleton()
abstract class HomeMovieLocalDataSource {
  @factoryMethod
  factory HomeMovieLocalDataSource(MovieProgressTable db) =>
      HomeMovieLocalDataSourceImpl(db);

  Future<MovieProgress?> insertMovieProgress(MovieProgress entity);
  Future<bool> updateMovieProgress(MovieProgress entity);

  Future<int> deleteMovieProgress(String id);

  Future<MovieProgress?> findMovieProgress(String id);

  Future<List<MovieProgress>> getAllMovieProgress();
}

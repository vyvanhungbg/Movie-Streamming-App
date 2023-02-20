import 'package:cinema/src/base/sqfite/movie_progress_table.dart';
import 'package:cinema/src/data/datasources/local/home/home_movie_local_data_source.dart';
import 'package:cinema/src/model/movie_progress.dart';

class HomeMovieLocalDataSourceImpl implements HomeMovieLocalDataSource {
  final MovieProgressTable db;

  HomeMovieLocalDataSourceImpl(this.db);

  @override
  Future<int> deleteMovieProgress(String id) {
    return db.delete(id);
  }

  @override
  Future<MovieProgress?> findMovieProgress(String id) {
    return db.findByID(id);
  }

  @override
  Future<List<MovieProgress>> getAllMovieProgress() {
    return db.getAll();
  }

  @override
  Future<MovieProgress?> insertMovieProgress(MovieProgress entity) {
    return db.insert(entity);
  }

  @override
  Future<bool> updateMovieProgress(MovieProgress entity) {
    return db.update(entity);
  }
}

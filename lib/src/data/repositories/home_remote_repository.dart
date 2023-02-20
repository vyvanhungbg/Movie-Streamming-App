import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/model/movie_progress.dart';
import 'package:cinema/src/model/movie_response_model.dart';
import 'package:cinema/src/model/recent_show_entity.dart';
import 'package:retrofit/retrofit.dart';

import '../../base/response/array_response.dart';

abstract class HomeRemoteRepository {
  Future<DataState<ArrayResponse<MovieResponseModel>>> getMoviesTrending();

  Future<DataState<List<MovieResponseModel>>> getMoviesRecent();
  Future<DataState<List<RecentShowEntity>>> getMoviesRecentShow();

  Future<DataState<MovieResponseModel?>> getMoviesById(String id);

  Future<DataState<MovieProgress?>> insert(MovieProgress entity);
  Future<DataState<bool>> update(MovieProgress entity);
  Future<DataState<int>> delete(String id);
  Future<DataState<MovieProgress?>> findByID(String id);
  Future<DataState<List<MovieProgress>>> getAll();
}

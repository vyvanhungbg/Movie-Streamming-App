import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/model/movie_response_model.dart';
import 'package:cinema/src/model/recent_show_entity.dart';
import 'package:retrofit/retrofit.dart';

import '../../base/response/array_response.dart';

abstract class HomeRemoteRepository {
  Future<DataState<ArrayResponse<MovieResponseModel>>> getMoviesTrending();

  Future<DataState<List<MovieResponseModel>>> getMoviesRecent();
  Future<DataState<List<RecentShowEntity>>> getMoviesRecentShow();

  Future<DataState<MovieResponseModel?>> getMoviesById(String id);
}

import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/model/movie_response_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../base/response/array_response.dart';

abstract class HomeRemoteRepository {
  Future<DataState<ArrayResponse<MovieResponseModel>>> getMoviesTrending();

  Future<DataState<List<MovieResponseModel>>> getMoviesRecent();

  Future<DataState<MovieResponseModel?>> getMoviesById(String id);
}

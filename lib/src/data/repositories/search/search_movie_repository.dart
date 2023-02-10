import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/base/response/array_response.dart';
import 'package:cinema/src/model/recent_show_entity.dart';
import 'package:cinema/src/model/watch_movie_entity.dart';
import 'package:retrofit/retrofit.dart';

abstract class SearchMovieRepository {
  Future<DataState<ArrayResponse<RecentShowEntity>>> searchMovie(
      String searchKey);
}

import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/model/watch_movie_entity.dart';
import 'package:retrofit/retrofit.dart';

abstract class WatchMovieRepository {
  Future<DataState<WatchMovieEntity>> getWatchMoviesEntityByOptions(
      Map<String, String> parameters);
}

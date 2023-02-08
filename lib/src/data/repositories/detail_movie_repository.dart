import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/model/movie_detail.dart';

abstract class DetailMovieRepository {

  Future<DataState<MovieDetail?>> getMoviesById(Map<String, String> parameters);
}
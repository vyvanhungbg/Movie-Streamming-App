import 'package:cinema/src/base/network/apiendpoint.dart';
import 'package:cinema/src/model/watch_movie_entity.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'watch_movie_remote_data_source.g.dart';

@RestApi(baseUrl: ApiEndPoints.baseUrl)
abstract class WatchMovieRemoteDataSource {
  factory WatchMovieRemoteDataSource(Dio dio, {required String baseUrl}) =
  _WatchMovieRemoteDataSource;

  @GET(ApiEndPoints.watch)
  Future<HttpResponse<WatchMovieEntity>> getWatchMoviesEntityByOptions(@Queries() final Map<String, String> parameters);

}
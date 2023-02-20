import 'package:cinema/src/base/network/apiendpoint.dart';
import 'package:cinema/src/model/watch_movie_entity.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'watch_movie_remote_data_source.g.dart';

@RestApi(baseUrl: ApiEndPoints.baseUrl)
@Singleton()
abstract class WatchMovieRemoteDataSource {
  @factoryMethod
  factory WatchMovieRemoteDataSource(Dio dio,
          {@Named(ApiEndPoints.nameOfBaseUrl) required String baseUrl}) =
      _WatchMovieRemoteDataSource;

  @GET(ApiEndPoints.watch)
  Future<HttpResponse<WatchMovieEntity>> getWatchMoviesEntityByOptions(
      @Queries() final Map<String, String> parameters);
}

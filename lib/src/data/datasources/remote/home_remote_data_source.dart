import 'package:cinema/src/base/network/apiendpoint.dart';
import 'package:cinema/src/base/response/array_response.dart';
import 'package:cinema/src/model/movie_response_model.dart';
import 'package:cinema/src/model/recent_show_entity.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'home_remote_data_source.g.dart';

@RestApi(baseUrl: ApiEndPoints.baseUrl)
@Singleton()
abstract class HomeRemoteDataSource {
  @factoryMethod
  factory HomeRemoteDataSource(Dio dio,
          {@Named(ApiEndPoints.nameOfBaseUrl) required String baseUrl}) =
      _HomeRemoteDataSource;

  @GET(ApiEndPoints.trending)
  Future<HttpResponse<ArrayResponse<MovieResponseModel>>> getMoviesTrending();

  @GET(ApiEndPoints.recentMovies)
  Future<HttpResponse<List<MovieResponseModel>>> getMoviesRecent();

  @GET(ApiEndPoints.recentShow)
  Future<HttpResponse<List<RecentShowEntity>>> getMoviesRecentShow();

  @GET(ApiEndPoints.info)
  Future<HttpResponse<MovieResponseModel?>> getMoviesById(String id);
}

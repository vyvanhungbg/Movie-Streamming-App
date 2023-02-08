import 'package:cinema/src/base/network/apiendpoint.dart';
import 'package:cinema/src/base/response/array_response.dart';
import 'package:cinema/src/model/movie_response_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'home_remote_data_source.g.dart';

@RestApi(baseUrl: ApiEndPoints.baseUrl)
abstract class HomeRemoteDataSource {
  factory HomeRemoteDataSource(Dio dio, {required String baseUrl}) =
      _HomeRemoteDataSource;

  @GET(ApiEndPoints.trending)
  Future<HttpResponse<ArrayResponse<MovieResponseModel>>> getMoviesTrending();

  @GET(ApiEndPoints.recentMovies)
  Future<HttpResponse<List<MovieResponseModel>>> getMoviesRecent();

  @GET(ApiEndPoints.info)
  Future<HttpResponse<MovieResponseModel?>> getMoviesById(String id);
}

import 'package:cinema/src/base/network/apiendpoint.dart';
import 'package:cinema/src/model/movie_detail.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'detail_movie_remote_data_source.g.dart';
@RestApi(baseUrl: ApiEndPoints.baseUrl)
abstract class DetailMovieRemoteDataSource {
  factory DetailMovieRemoteDataSource(Dio dio, {required String baseUrl}) =
  _DetailMovieRemoteDataSource;


  @GET(ApiEndPoints.info)
  Future<HttpResponse<MovieDetail?>> getMoviesById(@Queries() final Map<String, String> parameters);
}
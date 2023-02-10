import 'package:cinema/src/base/network/apiendpoint.dart';
import 'package:cinema/src/base/response/array_response.dart';
import 'package:cinema/src/model/movie_detail.dart';
import 'package:cinema/src/model/recent_show_entity.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'search_movie_remote_data_srource.g.dart';

@RestApi(baseUrl: ApiEndPoints.baseUrl)
abstract class SearchMovieRemoteDataSource {
  factory SearchMovieRemoteDataSource(Dio dio, {required String baseUrl}) =
  _SearchMovieRemoteDataSource;


  @GET(ApiEndPoints.search+"{search}")
  Future<HttpResponse<ArrayResponse<RecentShowEntity>>> getMoviesById(@Path("search")  String searchKey);
}
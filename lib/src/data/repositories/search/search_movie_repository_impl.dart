import 'dart:io';

import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/base/eror/api_error.dart';
import 'package:cinema/src/base/response/array_response.dart';
import 'package:cinema/src/data/datasources/remote/search_movie_remote_data_srource.dart';
import 'package:cinema/src/data/repositories/search/search_movie_repository.dart';
import 'package:cinema/src/model/recent_show_entity.dart';

class SearchMovieRepositoryImpl implements SearchMovieRepository {
  final SearchMovieRemoteDataSource _searchMovieRemoteDataSource;

  SearchMovieRepositoryImpl(this._searchMovieRemoteDataSource);

  @override
  Future<DataState<ArrayResponse<RecentShowEntity>>> searchMovie(
      String searchKey) async {
    try {
      final response =
          await _searchMovieRemoteDataSource.getMoviesById(searchKey);
      if (response.response.statusCode == HttpStatus.ok) {
        // print("watch movie respo impl response_______${response.data.toString()}");
        return DataSuccess(response.data);
      } else {
        return DataFailed(ApiError(
            code: response.response.statusCode,
            message: response.response.statusMessage));
      }
    } catch (e) {
      return DataFailed(ApiError(message: e.toString()));
    }
  }
}

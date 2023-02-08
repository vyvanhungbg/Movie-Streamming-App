import 'dart:io';

import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/base/eror/api_error.dart';
import 'package:cinema/src/data/datasources/remote/detail_movie_remote_data_source.dart';
import 'package:cinema/src/data/repositories/detail_movie_repository.dart';
import 'package:cinema/src/model/movie_detail.dart';

class DetailMovieRepositoryImpl implements DetailMovieRepository {
  final DetailMovieRemoteDataSource _detailMovieRemoteDataSource;

  DetailMovieRepositoryImpl(this._detailMovieRemoteDataSource);

  @override
  Future<DataState<MovieDetail?>> getMoviesById(Map<String, String> parameters ) async {
    try {
      final response = await _detailMovieRemoteDataSource.getMoviesById(parameters);
      if (response.response.statusCode == HttpStatus.ok) {
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

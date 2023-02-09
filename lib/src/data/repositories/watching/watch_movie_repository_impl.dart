import 'dart:io';

import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/base/eror/api_error.dart';
import 'package:cinema/src/data/datasources/remote/watch_movie_remote_data_source.dart';
import 'package:cinema/src/data/repositories/watching/watch_movie_repository.dart';
import 'package:cinema/src/model/watch_movie_entity.dart';

class WatchMovieRepositoryImpl implements WatchMovieRepository {
  final WatchMovieRemoteDataSource _watchMovieRemoteDataSource;

  WatchMovieRepositoryImpl(this._watchMovieRemoteDataSource);

  @override
  Future<DataState<WatchMovieEntity>> getWatchMoviesEntityByOptions(
      Map<String, String> parameters) async {
    try {
      final response = await _watchMovieRemoteDataSource
          .getWatchMoviesEntityByOptions(parameters);
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

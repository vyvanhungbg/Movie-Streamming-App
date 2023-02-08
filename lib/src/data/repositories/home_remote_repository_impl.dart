import 'dart:io';

import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/base/eror/api_error.dart';
import 'package:cinema/src/base/response/array_response.dart';
import 'package:cinema/src/data/datasources/remote/home_remote_data_source.dart';
import 'package:cinema/src/data/repositories/home_remote_repository.dart';
import 'package:cinema/src/model/movie_response_model.dart';

class HomeRemoteRepositoryImpl implements HomeRemoteRepository {
  final HomeRemoteDataSource _homeScreenDataSource;

  HomeRemoteRepositoryImpl(this._homeScreenDataSource);

  @override
  Future<DataState<ArrayResponse<MovieResponseModel>>>
      getMoviesTrending() async {
    try {
      final response = await _homeScreenDataSource.getMoviesTrending();
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

  @override
  Future<DataState<MovieResponseModel?>> getMoviesById(String id) async {
    try {
      final response = await _homeScreenDataSource.getMoviesById(id);
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

  @override
  Future<DataState<List<MovieResponseModel>>> getMoviesRecent() async {
    try {
      final response = await _homeScreenDataSource.getMoviesRecent();
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

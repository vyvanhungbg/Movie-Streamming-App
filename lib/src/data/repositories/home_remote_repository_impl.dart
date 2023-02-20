import 'dart:io';

import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/base/eror/base_error.dart';
import 'package:cinema/src/base/response/array_response.dart';
import 'package:cinema/src/data/datasources/local/home/home_movie_local_data_source.dart';
import 'package:cinema/src/data/datasources/remote/home_remote_data_source.dart';
import 'package:cinema/src/data/repositories/home_remote_repository.dart';
import 'package:cinema/src/model/movie_progress.dart';
import 'package:cinema/src/model/movie_response_model.dart';
import 'package:cinema/src/model/recent_show_entity.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: HomeRemoteRepository)
class HomeRemoteRepositoryImpl implements HomeRemoteRepository {
  final HomeRemoteDataSource _homeScreenDataSource;
  final HomeMovieLocalDataSource _homeMovieLocalDataSource;

  @factoryMethod
  HomeRemoteRepositoryImpl(
      this._homeScreenDataSource, this._homeMovieLocalDataSource);

  @override
  Future<DataState<ArrayResponse<MovieResponseModel>>>
      getMoviesTrending() async {
    try {
      final response = await _homeScreenDataSource.getMoviesTrending();
      if (response.response.statusCode == HttpStatus.ok) {
        return DataSuccess(response.data);
      } else {
        return DataFailed(BaseError(
            code: response.response.statusCode,
            message: response.response.statusMessage));
      }
    } catch (e) {
      return DataFailed(BaseError(message: e.toString()));
    }
  }

  @override
  Future<DataState<MovieResponseModel?>> getMoviesById(String id) async {
    try {
      final response = await _homeScreenDataSource.getMoviesById(id);
      if (response.response.statusCode == HttpStatus.ok) {
        return DataSuccess(response.data);
      } else {
        return DataFailed(BaseError(
            code: response.response.statusCode,
            message: response.response.statusMessage));
      }
    } catch (e) {
      return DataFailed(BaseError(message: e.toString()));
    }
  }

  @override
  Future<DataState<List<MovieResponseModel>>> getMoviesRecent() async {
    try {
      final response = await _homeScreenDataSource.getMoviesRecent();
      if (response.response.statusCode == HttpStatus.ok) {
        return DataSuccess(response.data);
      } else {
        return DataFailed(BaseError(
            code: response.response.statusCode,
            message: response.response.statusMessage));
      }
    } catch (e) {
      return DataFailed(BaseError(message: e.toString()));
    }
  }

  @override
  Future<DataState<List<RecentShowEntity>>> getMoviesRecentShow() async {
    try {
      final response = await _homeScreenDataSource.getMoviesRecentShow();
      if (response.response.statusCode == HttpStatus.ok) {
        return DataSuccess(response.data);
      } else {
        return DataFailed(BaseError(
            code: response.response.statusCode,
            message: response.response.statusMessage));
      }
    } catch (e) {
      return DataFailed(BaseError(message: e.toString()));
    }
  }

  @override
  Future<DataState<int>> delete(String id) async {
    try {
      final response = await _homeMovieLocalDataSource.deleteMovieProgress(id);
      return DataSuccess(response);
    } catch (e) {
      return DataFailed(BaseError(message: e.toString()));
    }
  }

  @override
  Future<DataState<MovieProgress?>> findByID(String id) async {
    try {
      final response = await _homeMovieLocalDataSource.findMovieProgress(id);
      if (response != null) {
        return DataSuccess(response);
      } else {
        throw ArgumentError.notNull();
      }
    } catch (e) {
      return DataFailed(BaseError(message: e.toString()));
    }
  }

  @override
  Future<DataState<List<MovieProgress>>> getAll() async {
    try {
      final response = await _homeMovieLocalDataSource.getAllMovieProgress();
      return DataSuccess(response);
    } catch (e) {
      return DataFailed(BaseError(message: e.toString()));
    }
  }

  @override
  Future<DataState<MovieProgress?>> insert(MovieProgress entity) async {
    try {
      final response =
          await _homeMovieLocalDataSource.insertMovieProgress(entity);
      if (response != null) {
        return DataSuccess(response);
      } else {
        throw ArgumentError.notNull();
      }
    } catch (e) {
      return DataFailed(BaseError(message: e.toString()));
    }
  }

  @override
  Future<DataState<bool>> update(MovieProgress entity) async {
    try {
      final response =
          await _homeMovieLocalDataSource.updateMovieProgress(entity);
      if (response) {
        return DataSuccess(response);
      } else {
        throw ArgumentError.notNull();
      }
    } catch (e) {
      return DataFailed(BaseError(message: e.toString()));
    }
  }
}

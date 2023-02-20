import 'dart:io';

import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/base/eror/base_error.dart';
import 'package:cinema/src/data/datasources/local/detail_movie/detail_movie_local_data_source.dart';

import 'package:cinema/src/data/datasources/remote/detail_movie_remote_data_source.dart';
import 'package:cinema/src/data/repositories/detail_movie_repository.dart';
import 'package:cinema/src/model/favorite_entity.dart';
import 'package:cinema/src/model/movie_detail.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: DetailMovieRepository)
class DetailMovieRepositoryImpl implements DetailMovieRepository {
  final DetailMovieRemoteDataSource _detailMovieRemoteDataSource;
  final DetailMovieLocalDataSource _detailMovieLocalDataSource;

  @factoryMethod
  DetailMovieRepositoryImpl(
      this._detailMovieRemoteDataSource, this._detailMovieLocalDataSource);

  @override
  Future<DataState<MovieDetail?>> getMoviesById(
      Map<String, String> parameters) async {
    try {
      final response =
          await _detailMovieRemoteDataSource.getMoviesById(parameters);
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
  Future<DataState<FavoriteEntity?>> addFavorite(FavoriteEntity entity) async {
    try {
      final response =
          await _detailMovieLocalDataSource.insertFavoriteMovie(entity);
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
  Future<DataState<int>> removeFavorite(String id) async {
    try {
      final response =
          await _detailMovieLocalDataSource.deleteFavoriteMovie(id);
      if (response == 1) {
        return DataSuccess(response);
      } else {
        return DataFailed(BaseError(
            message: 'Tìm thấy khác 1 dòng khi xóa ${response} dòng'));
      }
    } catch (e) {
      return DataFailed(BaseError(message: e.toString()));
    }
  }

  @override
  Future<DataState<FavoriteEntity?>> findByID(String id) async {
    try {
      final response = await _detailMovieLocalDataSource.findMovie(id);
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
  Future<DataState<List<FavoriteEntity>>> getAll() async {
    try {
      final response = await _detailMovieLocalDataSource.getAllMovies();
      return DataSuccess(response);
    } catch (e) {
      return DataFailed(BaseError(message: e.toString()));
    }
  }
}

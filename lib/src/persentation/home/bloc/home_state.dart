import 'package:cinema/src/base/data/data_status.dart';
import 'package:cinema/src/base/eror/api_error.dart';
import 'package:cinema/src/base/response/array_response.dart';
import 'package:cinema/src/model/movie_response_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class HomeState extends Equatable {
  final DataStatus? moviesTrendingStatus;
  final DataStatus? moviesRecentStatus;

  final ApiError? apiError;
  final ArrayResponse<MovieResponseModel>? moviesTrendingData;
  final List<MovieResponseModel>? moviesRecentData;

  const HomeState(
      {this.moviesTrendingStatus,
      this.moviesTrendingData,
      this.moviesRecentData,
      this.moviesRecentStatus,
      this.apiError});

  @override
  List<Object?> get props => [
        moviesTrendingStatus,
        moviesTrendingData,
        moviesRecentStatus,
        moviesRecentData,
        apiError
      ];

  HomeState copyWith(
      {DataStatus? moviesTrendingStatus,
      ArrayResponse<MovieResponseModel>? moviesTrendingData,
      DataStatus? moviesRecentStatus,
      List<MovieResponseModel>? moviesRecentData,
      ApiError? error}) {
    return HomeState(
        moviesTrendingStatus: moviesTrendingStatus ?? this.moviesTrendingStatus,
        moviesTrendingData: moviesTrendingData ?? this.moviesTrendingData,
        moviesRecentStatus: moviesRecentStatus ?? this.moviesRecentStatus,
        moviesRecentData: moviesRecentData ?? this.moviesRecentData,
        apiError: error);
  }
}

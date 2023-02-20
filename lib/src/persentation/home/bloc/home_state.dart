import 'package:cinema/src/base/data/data_status.dart';
import 'package:cinema/src/base/eror/base_error.dart';
import 'package:cinema/src/base/response/array_response.dart';
import 'package:cinema/src/model/movie_response_model.dart';
import 'package:cinema/src/model/recent_show_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class HomeState extends Equatable {
  final DataStatus? moviesTrendingStatus;
  final DataStatus? moviesRecentStatus;
  final DataStatus? moviesRecentShowStatus;

  final BaseError? apiError;
  final ArrayResponse<MovieResponseModel>? moviesTrendingData;
  final List<MovieResponseModel>? moviesRecentData;
  final List<RecentShowEntity>? moviesRecentShowData;

  const HomeState(
      {this.moviesTrendingStatus,
      this.moviesTrendingData,
      this.moviesRecentData,
      this.moviesRecentStatus,
      this.moviesRecentShowData,
      this.moviesRecentShowStatus,
      this.apiError});

  @override
  List<Object?> get props => [
        moviesTrendingStatus,
        moviesTrendingData,
        moviesRecentStatus,
        moviesRecentData,
        moviesRecentShowStatus,
        moviesRecentShowData,
        apiError
      ];

  HomeState copyWith(
      {DataStatus? moviesTrendingStatus,
      ArrayResponse<MovieResponseModel>? moviesTrendingData,
      DataStatus? moviesRecentStatus,
      List<MovieResponseModel>? moviesRecentData,
      DataStatus? moviesRecentShowStatus,
      List<RecentShowEntity>? moviesRecentShowData,
      BaseError? error}) {
    return HomeState(
        moviesTrendingStatus: moviesTrendingStatus ?? this.moviesTrendingStatus,
        moviesTrendingData: moviesTrendingData ?? this.moviesTrendingData,
        moviesRecentStatus: moviesRecentStatus ?? this.moviesRecentStatus,
        moviesRecentData: moviesRecentData ?? this.moviesRecentData,
        moviesRecentShowStatus:
            moviesRecentShowStatus ?? this.moviesRecentShowStatus,
        moviesRecentShowData: moviesRecentShowData ?? this.moviesRecentShowData,
        apiError: error);
  }
}

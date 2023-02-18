import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/base/data/data_status.dart';
import 'package:cinema/src/base/response/array_response.dart';
import 'package:cinema/src/domain/use_cases/get_movies_recent_show_use_case.dart';
import 'package:cinema/src/domain/use_cases/get_movies_recent_use_case.dart';
import 'package:cinema/src/domain/use_cases/get_trending_movies_use_case.dart';
import 'package:cinema/src/model/movie_response_model.dart';
import 'package:cinema/src/model/recent_show_entity.dart';
import 'package:cinema/src/persentation/home/bloc/home_event.dart';
import 'package:cinema/src/persentation/home/bloc/home_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetTrendingMoviesUseCase _getTrendingMoviesUseCase;
  final GetMoviesRecentUseCase _getMoviesRecentUseCase;
  final GetMoviesRecentShowUseCase _getMoviesRecentShowUseCase;

  HomeBloc(this._getTrendingMoviesUseCase, this._getMoviesRecentUseCase,
      this._getMoviesRecentShowUseCase)
      : super(const HomeState()) {
    on<HomeStarted>(started);
    on<HomeGetMoviesTrending>(getMoviesTrending);
    on<HomeGetMoviesRecent>(getMoviesRecent);
    on<HomeGetMoviesRecentShow>(getMoviesRecentShow);
  }

  Future<void> started(
    HomeStarted event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(
      moviesTrendingStatus: DataStatus.initial,
    ));
    emit(state.copyWith());
  }

  Future<void> getMoviesTrending(
      HomeGetMoviesTrending event, Emitter<HomeState> emit) async {
    emit(state.copyWith(
      moviesTrendingStatus: DataStatus.loading,
    ));
    final DataState<ArrayResponse<MovieResponseModel>?> dataState =
        await _getTrendingMoviesUseCase.call()
            as DataState<ArrayResponse<MovieResponseModel>>;

    if (dataState is DataSuccess && dataState.data != null) {
      emit(state.copyWith(
          moviesTrendingStatus: DataStatus.success,
          moviesTrendingData: dataState.data));
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(
          moviesTrendingStatus: DataStatus.failure, error: dataState.error));
    }
  }

  Future<void> getMoviesRecent(
      HomeGetMoviesRecent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(moviesRecentStatus: DataStatus.loading));

    final DataState<List<MovieResponseModel>> dataState =
        await _getMoviesRecentUseCase.call()
            as DataState<List<MovieResponseModel>>;
    if (dataState is DataSuccess && dataState.data != null) {
      emit(state.copyWith(
          moviesRecentStatus: DataStatus.success,
          moviesRecentData: dataState.data));
    } else {
      emit(state.copyWith(
          moviesRecentStatus: DataStatus.failure, error: dataState.error));
    }
  }

  Future<void> getMoviesRecentShow(
      HomeGetMoviesRecentShow event, Emitter<HomeState> emit) async {
    emit(state.copyWith(moviesRecentShowStatus: DataStatus.loading));

    final DataState<List<RecentShowEntity>> dataState =
        await _getMoviesRecentShowUseCase.call()
            as DataState<List<RecentShowEntity>>;
    if (dataState is DataSuccess && dataState.data != null) {
      emit(state.copyWith(
          moviesRecentShowStatus: DataStatus.success,
          moviesRecentShowData: dataState.data));
    } else {
      emit(state.copyWith(
          moviesRecentShowStatus: DataStatus.failure, error: dataState.error));
    }

    debugPrint(dataState.toString());
  }
}

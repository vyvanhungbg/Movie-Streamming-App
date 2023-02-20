import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/base/data/data_status.dart';
import 'package:cinema/src/base/eror/base_error.dart';
import 'package:cinema/src/domain/use_cases/get_all_movie_favorite_use_case.dart';
import 'package:cinema/src/model/favorite_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'favorite_movie_event.dart';
part 'favorite_movie_state.dart';

class FavoriteMovieBloc extends Bloc<FavoriteMovieEvent, FavoriteMovieState> {
  final GetAllMovieFavoriteUseCase _getAllMovieFavoriteUseCase;

  FavoriteMovieBloc(this._getAllMovieFavoriteUseCase)
      : super(const FavoriteMovieState()) {
    on<FavoriteMovieStaredEvent>(started);
    on<FavoriteMovieGetMovieFavoriteEvent>(getMoviesFavorite);
  }

  Future<void> started(
    FavoriteMovieStaredEvent event,
    Emitter<FavoriteMovieState> emit,
  ) async {
    emit(state.copyWith(
      favoriteMovieStatus: DataStatus.initial,
    ));
    emit(state.copyWith());
  }

  Future<void> getMoviesFavorite(FavoriteMovieGetMovieFavoriteEvent event,
      Emitter<FavoriteMovieState> emit) async {
    emit(state.copyWith(
      favoriteMovieStatus: DataStatus.loading,
    ));
    final DataState<List<FavoriteEntity>?> dataState =
        await _getAllMovieFavoriteUseCase.call(params: 1)
            as DataState<List<FavoriteEntity>>;

    if (dataState is DataSuccess && dataState.data != null) {
      emit(state.copyWith(
          favoriteMovieStatus: DataStatus.success,
          favoriteEntityListData: dataState.data?.toSet().toList()));
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(
          favoriteMovieStatus: DataStatus.failure, apiError: dataState.error));
    }
  }
}

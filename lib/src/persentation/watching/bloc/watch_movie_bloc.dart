import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/base/data/data_status.dart';
import 'package:cinema/src/base/network/querymodel/watch_paramerter.dart';
import 'package:cinema/src/domain/use_cases/get_watch_movie_use_case.dart';
import 'package:cinema/src/model/watch_movie_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../base/eror/api_error.dart';

part 'watch_movie_event.dart';
part 'watch_movie_state.dart';

class WatchMovieBloc extends Bloc<WatchMovieEvent, WatchMovieState> {
  final GetWatchMovieUseCase _getWatchMovieUseCase;

  WatchMovieBloc(this._getWatchMovieUseCase) : super(WatchMovieState()) {
    on<WatchMovieStarted>(started);
    on<WatchMovieGetData>(getWatchMovies);
    on<WatchMovieBegin>(begin);
  }

  Future<void> started(
    WatchMovieStarted event,
    Emitter<WatchMovieState> emit,
  ) async {
    emit(state.copyWith(
      watchMovieStatus: DataStatus.initial,
    ));
    emit(state.copyWith());
  }

  Future<void> getWatchMovies(
      WatchMovieGetData event, Emitter<WatchMovieState> emit) async {
    emit(state.copyWith(
      watchMovieStatus: DataStatus.loading,
    ));

    final DataState<WatchMovieEntity> dataState = await _getWatchMovieUseCase
        .call(params: event.parameter.toJson()) as DataState<WatchMovieEntity>;
    print("__________${event.parameter.toJson().toString()}");
    if (dataState is DataSuccess && dataState.data != null) {
      emit(state.copyWith(
          watchMovieStatus: DataStatus.success,
          watchMovieData: dataState.data));
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(
          watchMovieStatus: DataStatus.failure, error: dataState.error));
    }
  }

  Future<void> begin(
      WatchMovieBegin event, Emitter<WatchMovieState> emit) async {
    if (state.watchMovieStatus == DataStatus.success &&
        state.watchMovieData != null) {
      emit(state.copyWith(watchMovieStatus: DataStatus.begin));
    }
  }
}

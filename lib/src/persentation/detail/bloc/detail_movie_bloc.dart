import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/base/data/data_status.dart';
import 'package:cinema/src/base/eror/base_error.dart';
import 'package:cinema/src/domain/use_cases/add_favorite_movie_use_case.dart';
import 'package:cinema/src/domain/use_cases/find_favorite_movie_use_case.dart';
import 'package:cinema/src/domain/use_cases/get_detail_movie_use_case.dart';
import 'package:cinema/src/domain/use_cases/remove_favorite_movie_use_case.dart';
import 'package:cinema/src/model/favorite_entity.dart';
import 'package:cinema/src/model/movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'detail_movie_event.dart';
part 'detail_movie_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  final GetDetailMovieUseCase _getDetailMovieUseCase;
  final AddFavoriteMovieUseCase _addFavoriteMovieUseCase;
  final RemoveFavoriteMovieUseCase _removeFavoriteMovie;
  final FindFavoriteMovieUseCase _findMovieUseCase;

  DetailMovieBloc(this._getDetailMovieUseCase, this._addFavoriteMovieUseCase,
      this._removeFavoriteMovie, this._findMovieUseCase)
      : super(const DetailMovieState()) {
    on<DetailStarted>(detailStarted);
    on<GetMovieDetail>(getMovieDetail);
    on<AddFavoriteMovie>(addFavorite);
    on<RemoveFavoriteMovie>(removeFavorite);
    on<FindFavoriteMovie>(findFavorite);
  }

  Future<void> detailStarted(
      DetailStarted event, Emitter<DetailMovieState> emitter) async {
    emit(state.copyWith(movieDetailStatus: DataStatus.initial));
  }

  Future<void> addFavorite(
      AddFavoriteMovie event, Emitter<DetailMovieState> emitter) async {
    final dataState = await _addFavoriteMovieUseCase.call(params: event.entity)
        as DataState<FavoriteEntity?>;
    if (dataState.data != null && dataState is DataSuccess) {
      emit(state.copyWith(actionFavoriteStatus: ActionFavoriteStatus.favorite));
    }
    print('add' + dataState.toString());
  }

  Future<void> removeFavorite(
      RemoveFavoriteMovie event, Emitter<DetailMovieState> emitter) async {
    final dataState =
        await _removeFavoriteMovie.call(params: event.id) as DataState<int?>;
    if (dataState.data != null && dataState is DataSuccess) {
      emit(state.copyWith(
          actionFavoriteStatus: ActionFavoriteStatus.unFavorite));
    }
    print(dataState.toString());
  }

  Future<void> findFavorite(
      FindFavoriteMovie event, Emitter<DetailMovieState> emitter) async {
    final dataState = await _findMovieUseCase.call(params: event.id)
        as DataState<FavoriteEntity?>;
    if (dataState.data != null && dataState is DataSuccess) {
      emit(state.copyWith(actionFavoriteStatus: ActionFavoriteStatus.favorite));
    } else {
      emit(state.copyWith(
          actionFavoriteStatus: ActionFavoriteStatus.unFavorite));
    }
    print('find' + dataState.toString());
  }

  Future<void> getMovieDetail(
      GetMovieDetail event, Emitter<DetailMovieState> emitter) async {
    emit(state.copyWith(movieDetailStatus: DataStatus.loading));

    final DataState<MovieDetail?> dataState = await _getDetailMovieUseCase.call(
        params: event.parameters) as DataState<MovieDetail?>;

    if (dataState.data != null && dataState is DataSuccess) {
      emit(state.copyWith(
          movieDetailStatus: DataStatus.success,
          movieDetailData: dataState.data));
    } else {
      print(dataState.error!.toString());
      emit(state.copyWith(movieDetailStatus: DataStatus.failure));
    }
  }
}

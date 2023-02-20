import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/base/data/data_status.dart';
import 'package:cinema/src/base/eror/base_error.dart';
import 'package:cinema/src/base/response/array_response.dart';
import 'package:cinema/src/domain/use_cases/home/search_movie_use_case.dart';
import 'package:cinema/src/model/recent_show_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovieUseCase _searchMovieUseCase;

  SearchMovieBloc(this._searchMovieUseCase) : super(SearchMovieState()) {
    on<SearchMovieStarted>(searchMovie);
  }

  Future<void> searchMovie(
      SearchMovieStarted event, Emitter<SearchMovieState> emitter) async {
    emit(state.copyWith(searchMovieStatus: DataStatus.loading));

    final DataState<ArrayResponse<RecentShowEntity>> dataState =
        await _searchMovieUseCase.call(params: event.searchKey)
            as DataState<ArrayResponse<RecentShowEntity>>;

    if (dataState.data != null && dataState is DataSuccess) {
      emit(state.copyWith(
          searchMovieStatus: DataStatus.success,
          searchMovieData: dataState.data));
    } else {
      emit(state.copyWith(searchMovieStatus: DataStatus.failure));
    }
  }
}

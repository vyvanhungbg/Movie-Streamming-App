import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/base/data/data_status.dart';
import 'package:cinema/src/base/eror/api_error.dart';
import 'package:cinema/src/domain/use_cases/get_detail_movie_use_case.dart';
import 'package:cinema/src/model/movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'detail_movie_event.dart';
part 'detail_movie_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  final GetDetailMovieUseCase _getDetailMovieUseCase;

  DetailMovieBloc(this._getDetailMovieUseCase) : super(const DetailMovieState()) {
    on<DetailStarted>(detailStarted);
    on<GetMovieDetail>(getMovieDetail);
  }
  
  Future<void> detailStarted(DetailStarted event, Emitter<DetailMovieState> emitter) async{
    emit(state.copyWith(movieDetailStatus: DataStatus.initial));
  }

  Future<void> getMovieDetail(GetMovieDetail event, Emitter<DetailMovieState> emitter) async{
    emit(state.copyWith(movieDetailStatus: DataStatus.loading));
    
    final DataState<MovieDetail?> dataState = await _getDetailMovieUseCase.call(params: event.parameters) as DataState<MovieDetail?>;

    if(dataState.data != null && dataState is DataSuccess){
      emit(state.copyWith(movieDetailStatus: DataStatus.success, movieDetailData: dataState.data));
    }else{
      print(dataState.error!.toString());
      emit(state.copyWith(movieDetailStatus: DataStatus.failure));
    }
  }
}

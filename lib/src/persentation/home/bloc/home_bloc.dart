import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/base/data/data_status.dart';
import 'package:cinema/src/base/response/array_response.dart';
import 'package:cinema/src/domain/use_cases/home/find_movie_progress_use_case.dart';
import 'package:cinema/src/domain/use_cases/home/get_all_movie_progress_use_case.dart';
import 'package:cinema/src/domain/use_cases/home/get_movies_recent_show_use_case.dart';
import 'package:cinema/src/domain/use_cases/home/get_movies_recent_use_case.dart';
import 'package:cinema/src/domain/use_cases/home/get_trending_movies_use_case.dart';
import 'package:cinema/src/domain/use_cases/home/save_movie_progress_use_case.dart';
import 'package:cinema/src/domain/use_cases/home/update_movie_progress_use_case.dart';
import 'package:cinema/src/model/movie_progress.dart';
import 'package:cinema/src/model/movie_response_model.dart';
import 'package:cinema/src/model/recent_show_entity.dart';
import 'package:cinema/src/persentation/home/bloc/home_event.dart';
import 'package:cinema/src/persentation/home/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetTrendingMoviesUseCase _getTrendingMoviesUseCase;
  final GetMoviesRecentUseCase _getMoviesRecentUseCase;
  final GetMoviesRecentShowUseCase _getMoviesRecentShowUseCase;
  final GetAllMovieProgressUseCase _getAllMovieProgressUseCase;

  final SaveMovieProgressUseCase _saveMovieProgressUseCase;
  final UpdateMovieProgressUseCase _updateMovieProgressUseCase;
  final FindMovieProgressUseCase _findMovieProgressUseCase;

  HomeBloc(
      this._getTrendingMoviesUseCase,
      this._getMoviesRecentUseCase,
      this._getMoviesRecentShowUseCase,
      this._getAllMovieProgressUseCase,
      this._saveMovieProgressUseCase,
      this._updateMovieProgressUseCase,
      this._findMovieProgressUseCase)
      : super(const HomeState()) {
    on<HomeStarted>(started);
    on<HomeGetMoviesTrending>(getMoviesTrending);
    on<HomeGetMoviesRecent>(getMoviesRecent);
    on<HomeGetMoviesRecentShow>(getMoviesRecentShow);
    on<HomeGetMovieProgressEvent>(getAllMovieProgress);
    on<HomeSaveMovieProgressEvent>(saveMovieProgress);
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

  Future<void> saveMovieProgress(
      HomeSaveMovieProgressEvent event, Emitter<HomeState> emit) async {
    // emit(state.copyWith(moviesRecentStatus: DataStatus.loading));

    final DataState<MovieProgress?> dataStateFind =
        await _findMovieProgressUseCase.call(params: event.movieProgress)
            as DataState<MovieProgress?>;

    if (dataStateFind is DataSuccess && dataStateFind.data != null) {
      final DataState<bool> dataStateUpdate = await _updateMovieProgressUseCase
          .call(params: event.movieProgress) as DataState<bool>;
      // update tiến trình phim
    } else {
      final DataState<MovieProgress?> dataStateFind =
          await _saveMovieProgressUseCase.call(params: event.movieProgress)
              as DataState<MovieProgress?>;
    }
    add(HomeGetMovieProgressEvent());
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
  }

  Future<void> getAllMovieProgress(
      HomeGetMovieProgressEvent event, Emitter<HomeState> emitter) async {
    emit(state.copyWith(moviesProgressStatus: DataStatus.loading));

    final DataState<List<MovieProgress>> dataState =
        await _getAllMovieProgressUseCase.call(params: null)
            as DataState<List<MovieProgress>>;

    if (dataState.data != null && dataState is DataSuccess) {
      emit(state.copyWith(
          moviesProgressStatus: DataStatus.success,
          moviesMovieProgressData: dataState.data));
    } else {
      emit(state.copyWith(moviesProgressStatus: DataStatus.failure));
    }
  }
}

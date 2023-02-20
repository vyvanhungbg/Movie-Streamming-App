part of 'watch_movie_bloc.dart';

@immutable
class WatchMovieState extends Equatable {
  final DataStatus? watchMovieStatus;
  final DataStatus? movieProgressStatus;
  final WatchMovieEntity? watchMovieData;
  final MovieProgress? movieProgressData;
  final BaseError? error;

  WatchMovieState(
      {this.watchMovieStatus,
      this.watchMovieData,
      this.movieProgressStatus,
      this.movieProgressData,
      this.error});

  @override
  // TODO: implement props
  List<Object?> get props => [
        watchMovieStatus,
        watchMovieData,
        watchMovieData,
        movieProgressData,
        error
      ];

  WatchMovieState copyWith(
      {DataStatus? watchMovieStatus,
      WatchMovieEntity? watchMovieData,
      DataStatus? movieProgressStatus,
      MovieProgress? movieProgressData,
      BaseError? error}) {
    return WatchMovieState(
        watchMovieStatus: watchMovieStatus ?? this.watchMovieStatus,
        watchMovieData: watchMovieData ?? this.watchMovieData,
        movieProgressStatus: movieProgressStatus ?? this.movieProgressStatus,
        movieProgressData: movieProgressData ?? this.movieProgressData,
        error: error ?? this.error);
  }
}

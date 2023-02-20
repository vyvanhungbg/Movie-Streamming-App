part of 'watch_movie_bloc.dart';

@immutable
class WatchMovieState extends Equatable {
  final DataStatus? watchMovieStatus;
  final WatchMovieEntity? watchMovieData;
  final BaseError? error;

  WatchMovieState({this.watchMovieStatus, this.watchMovieData, this.error});

  @override
  // TODO: implement props
  List<Object?> get props => [watchMovieStatus, watchMovieData, error];

  WatchMovieState copyWith(
      {DataStatus? watchMovieStatus,
      WatchMovieEntity? watchMovieData,
      BaseError? error}) {
    return WatchMovieState(
        watchMovieStatus: watchMovieStatus ?? this.watchMovieStatus,
        watchMovieData: watchMovieData ?? this.watchMovieData,
        error: error ?? this.error);
  }
}

part of 'watch_movie_bloc.dart';

@immutable
abstract class WatchMovieEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class WatchMovieStarted extends WatchMovieEvent {}

class WatchMovieGetData extends WatchMovieEvent {
  final WatchParameter parameter;

  WatchMovieGetData(this.parameter);
}

class WatchMovieBegin extends WatchMovieEvent {}

class GetDurationMovieProgressEvent extends WatchMovieEvent {
  final MovieProgress movieProgress;

  GetDurationMovieProgressEvent({required this.movieProgress});
}

class WatchMovieFinished extends WatchMovieEvent {}

class WatchMoviePaused extends WatchMovieEvent {}

class WatchMovieCancelled extends WatchMovieEvent {}

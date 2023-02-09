part of 'watch_movie_bloc.dart';

@immutable
abstract class WatchMovieEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class WatchMovieStarted extends WatchMovieEvent {}

class WatchMovieGetData extends WatchMovieEvent {
  final WatchParameter parameter;

  WatchMovieGetData(this.parameter){
    print("___truy van "+parameter.toJson().toString());
  }
}

class WatchMovieBegin extends WatchMovieEvent{

}

class WatchMovieFinished extends WatchMovieEvent {}

class WatchMoviePaused extends WatchMovieEvent {}

class WatchMovieCancelled extends WatchMovieEvent {}




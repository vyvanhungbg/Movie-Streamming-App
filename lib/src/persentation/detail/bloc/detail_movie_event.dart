part of 'detail_movie_bloc.dart';

@immutable
abstract class DetailMovieEvent {
  @override
  List<Object> get props => [];
}

class DetailStarted extends DetailMovieEvent {}

class GetMovieDetail extends DetailMovieEvent {
  final Map<String, String> parameters;

  GetMovieDetail(this.parameters);
}

class AddFavoriteMovie extends DetailMovieEvent {
  final FavoriteEntity entity;
  AddFavoriteMovie(this.entity);
}

class RemoveFavoriteMovie extends DetailMovieEvent {
  final String id;
  RemoveFavoriteMovie(this.id);
}

class FindFavoriteMovie extends DetailMovieEvent {
  final String id;
  FindFavoriteMovie(this.id);
}

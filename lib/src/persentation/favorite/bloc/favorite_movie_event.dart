part of 'favorite_movie_bloc.dart';

@immutable
abstract class FavoriteMovieEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FavoriteMovieStaredEvent extends FavoriteMovieEvent {}

class FavoriteMovieGetMovieFavoriteEvent extends FavoriteMovieEvent {}

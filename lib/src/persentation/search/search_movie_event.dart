part of 'search_movie_bloc.dart';

@immutable
abstract class SearchMovieEvent {}

class SearchMovieStarted extends SearchMovieEvent{
  final String searchKey;

  SearchMovieStarted({required this.searchKey});
}


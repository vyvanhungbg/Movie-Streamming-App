import 'package:cinema/src/model/movie_progress.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeStarted extends HomeEvent {}

class HomeGetMoviesTrending extends HomeEvent {}

class HomeGetMoviesRecent extends HomeEvent {}

class HomeGetMoviesRecentShow extends HomeEvent {}

class HomeGetMovieProgressEvent extends HomeEvent {}

class HomeSaveMovieProgressEvent extends HomeEvent {
  final MovieProgress movieProgress;
  HomeSaveMovieProgressEvent({required this.movieProgress});
}

class HomeSearchMovies extends HomeEvent {
  final String search;
  HomeSearchMovies(this.search);
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeStarted extends HomeEvent {}

class HomeGetMoviesTrending extends HomeEvent{}

class HomeGetMoviesRecent extends HomeEvent{}
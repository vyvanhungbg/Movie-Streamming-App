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
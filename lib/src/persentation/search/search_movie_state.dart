part of 'search_movie_bloc.dart';

@immutable
class SearchMovieState extends Equatable {
  DataStatus? searchMovieStatus;
  ArrayResponse<RecentShowEntity>? searchMovieData;
  BaseError? error;

  SearchMovieState({this.searchMovieStatus, this.searchMovieData, this.error});

  SearchMovieState copyWith(
      {DataStatus? searchMovieStatus,
      ArrayResponse<RecentShowEntity>? searchMovieData,
      BaseError? error}) {
    return SearchMovieState(
        searchMovieStatus: searchMovieStatus,
        searchMovieData: searchMovieData,
        error: error);
  }

  @override
  List<Object?> get props => [searchMovieStatus, searchMovieData, error];
}

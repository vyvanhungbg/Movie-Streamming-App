part of 'search_movie_bloc.dart';

@immutable
class SearchMovieState extends Equatable {
  DataStatus? searchMovieStatus;
  ArrayResponse<RecentShowEntity>? searchMovieData;
  ApiError? error;

  SearchMovieState({this.searchMovieStatus, this.searchMovieData, this.error});

  SearchMovieState copyWith({DataStatus? searchMovieStatus,
    ArrayResponse<RecentShowEntity>? searchMovieData, ApiError? error}) {
    return SearchMovieState(
        searchMovieStatus: searchMovieStatus,
        searchMovieData: searchMovieData,
        error: error);
  }

  @override
  List<Object?> get props => [searchMovieStatus, searchMovieData, error];
}

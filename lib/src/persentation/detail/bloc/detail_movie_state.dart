part of 'detail_movie_bloc.dart';

@immutable
class DetailMovieState extends Equatable {
  final DataStatus? movieDetailStatus;
  final MovieDetail? movieDetailData;
  final ApiError? apiError;

  const DetailMovieState(
      {this.movieDetailStatus, this.movieDetailData, this.apiError});

  DetailMovieState copyWith(
      {DataStatus? movieDetailStatus, MovieDetail? movieDetailData, ApiError? apiError}) {
    return DetailMovieState(
        movieDetailStatus: movieDetailStatus ?? this.movieDetailStatus,
        movieDetailData: movieDetailData ?? this.movieDetailData,
        apiError: apiError ?? this.apiError
    );
  }

  @override
  List<Object?> get props => [movieDetailStatus, movieDetailData, apiError];
}

part of 'detail_movie_bloc.dart';

@immutable
class DetailMovieState extends Equatable {
  final DataStatus? movieDetailStatus;
  final MovieDetail? movieDetailData;
  final ActionFavoriteStatus? actionFavoriteStatus;
  final AddFavoriteMovie? actionAddFavoriteMovie;
  final RemoveFavoriteMovie? actionRemoveFavoriteMovie;
  final BaseError? apiError;

  const DetailMovieState(
      {this.movieDetailStatus,
      this.movieDetailData,
      this.actionFavoriteStatus,
      this.actionAddFavoriteMovie,
      this.actionRemoveFavoriteMovie,
      this.apiError});

  DetailMovieState copyWith(
      {DataStatus? movieDetailStatus,
      MovieDetail? movieDetailData,
      ActionFavoriteStatus? actionFavoriteStatus,
      AddFavoriteMovie? actionAddFavoriteMovie,
      RemoveFavoriteMovie? actionRemoveFavoriteMovie,
      BaseError? apiError}) {
    return DetailMovieState(
        movieDetailStatus: movieDetailStatus ?? this.movieDetailStatus,
        movieDetailData: movieDetailData ?? this.movieDetailData,
        apiError: apiError ?? this.apiError,
        actionAddFavoriteMovie:
            actionAddFavoriteMovie ?? this.actionAddFavoriteMovie,
        actionRemoveFavoriteMovie:
            actionRemoveFavoriteMovie ?? this.actionRemoveFavoriteMovie,
        actionFavoriteStatus:
            actionFavoriteStatus ?? this.actionFavoriteStatus);
  }

  @override
  List<Object?> get props => [
        movieDetailStatus,
        movieDetailData,
        actionFavoriteStatus,
        actionAddFavoriteMovie,
        actionRemoveFavoriteMovie,
        apiError
      ];
}

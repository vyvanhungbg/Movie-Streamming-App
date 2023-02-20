part of 'favorite_movie_bloc.dart';

@immutable
class FavoriteMovieState extends Equatable {
  final DataStatus? favoriteMovieStatus;
  final BaseError? apiError;
  final List<FavoriteEntity>? favoriteEntityListData;

  const FavoriteMovieState(
      {this.favoriteMovieStatus, this.apiError, this.favoriteEntityListData});

  @override
  List<Object?> get props =>
      [favoriteMovieStatus, apiError, favoriteEntityListData];

  FavoriteMovieState copyWith(
      {DataStatus? favoriteMovieStatus,
      BaseError? apiError,
      List<FavoriteEntity>? favoriteEntityListData}) {
    return FavoriteMovieState(
      favoriteMovieStatus: favoriteMovieStatus ?? this.favoriteMovieStatus,
      apiError: apiError ?? this.apiError,
      favoriteEntityListData:
          favoriteEntityListData ?? this.favoriteEntityListData,
    );
  }
}

import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../base/sqfite/movie_progress_table.dart';
part 'movie_progress.g.dart';

@JsonSerializable()
class MovieProgress {
  @Named(MovieProgressTable.columnIdMovie)
  String? idMovie;
  @Named(MovieProgressTable.columnImage)
  String? image;
  @Named(MovieProgressTable.columnCurrentProgress)
  String? currentProgress;
  @Named(MovieProgressTable.columnMaxProgress)
  String? maxProgress;
  @Named(MovieProgressTable.columnLastWatched)
  String? lastWatched;

  @Named(MovieProgressTable.columnEpisode)
  String? episode;

  MovieProgress();

  MovieProgress.init(
      {this.idMovie,
      this.image,
      this.currentProgress,
      this.maxProgress,
      this.lastWatched,
      this.episode});

  factory MovieProgress.fromJson(Map<String, dynamic> json) =>
      _$MovieProgressFromJson(json);

  Map<String, dynamic> toJson() => _$MovieProgressToJson(this);

  @override
  String toString() {
    return 'MovieProgress{idMovie: $idMovie, image: $image, currentProgress: $currentProgress, maxProgress: $maxProgress, lastWatched: $lastWatched}';
  }
}

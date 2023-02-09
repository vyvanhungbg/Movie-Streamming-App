import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'watch_movie_entity.g.dart';

@JsonSerializable()
class WatchMovieEntity {
  @JsonKey(name: "headers")
  final WatchMovieHeaders? headers;
  @JsonKey(name: "sources")
  final List<WatchMovieSources>? sources;
  @JsonKey(name: "subtitles")
  final List<WatchMovieSubtitles>? subtitles;

  WatchMovieEntity(this.headers, this.sources, this.subtitles);

  factory WatchMovieEntity.fromJson(Map<String, dynamic> json) =>
      _$WatchMovieEntityFromJson(json);

  Map<String, dynamic> toJson() => _$WatchMovieEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class WatchMovieHeaders {
  @JsonKey(name: "Referer")
  late String referer;

  WatchMovieHeaders();

  factory WatchMovieHeaders.fromJson(Map<String, dynamic> json) =>
      _$WatchMovieHeadersFromJson(json);

  Map<String, dynamic> toJson() => _$WatchMovieHeadersToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class WatchMovieSources {
  late String url;
  late String quality;
  late bool isM3U8;

  WatchMovieSources();

  factory WatchMovieSources.fromJson(Map<String, dynamic> json) =>
      _$WatchMovieSourcesFromJson(json);

  Map<String, dynamic> toJson() => _$WatchMovieSourcesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class WatchMovieSubtitles {
  late String url;
  late String lang;

  WatchMovieSubtitles();

  factory WatchMovieSubtitles.fromJson(Map<String, dynamic> json) =>
      _$WatchMovieSubtitlesFromJson(json);

  Map<String, dynamic> toJson() => _$WatchMovieSubtitlesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

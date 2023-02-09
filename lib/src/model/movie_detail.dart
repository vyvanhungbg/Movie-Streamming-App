import 'dart:convert';

import 'package:cinema/src/model/episode_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_detail.g.dart';

@JsonSerializable()
class MovieDetail {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "url")
  String? url;
  @JsonKey(name: "cover")
  String? cover;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "type")
  String? type;
  @JsonKey(name: "releaseDate")
  String? releaseDate;
  @JsonKey(name: "genres")
  List<String>? genres;
  @JsonKey(name: "casts")
  List<String>? casts;
  @JsonKey(name: "tags")
  List<String>? tags;
  @JsonKey(name: "production")
  String? production;
  @JsonKey(name: "country")
  String? country;
  @JsonKey(name: "duration")
  String? duration;
  @JsonKey(name: "rating")
  double? rating;

  //late List<MovieDetailRecommendations> recommendations;
  @JsonKey(name: "episodes")
  List<EpisodeEntity>? episodes;

  MovieDetail();

  factory MovieDetail.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailFromJson(json);

  @override
  String toString() {
    return 'MovieDetail{id: $id, title: $title, url: $url, cover: $cover, image: $image, description: $description, type: $type, releaseDate: $releaseDate, genres: $genres, casts: $casts, tags: $tags, production: $production, country: $country, duration: $duration, rating: $rating}';
  }
}

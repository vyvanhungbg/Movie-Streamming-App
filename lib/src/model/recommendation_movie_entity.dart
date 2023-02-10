import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
part 'recommendation_movie_entity.g.dart';
@JsonSerializable()
class RecommendationMovieEntity {

  @JsonKey(name: "id")
	String? id;
  @JsonKey(name: "title")
	String? title;
  @JsonKey(name: "image")
	String? image;
  @JsonKey(name: "duration")
	String? duration;
  @JsonKey(name: "type")
	String? type;
  
  RecommendationMovieEntity();

  factory RecommendationMovieEntity.fromJson(Map<String, dynamic> json) => _$RecommendationMovieEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendationMovieEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
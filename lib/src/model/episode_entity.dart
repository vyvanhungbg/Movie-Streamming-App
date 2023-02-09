import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
part 'episode_entity.g.dart';
@JsonSerializable()
class EpisodeEntity {

	late String id;
	late String title;
	late String url;
  
  EpisodeEntity();

  factory EpisodeEntity.fromJson(Map<String, dynamic> json) => _$EpisodeEntityFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
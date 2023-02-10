import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
part 'recent_show_entity.g.dart';
@JsonSerializable()
class RecentShowEntity {

	String? id;
	String? title;
	String? url;
	String? image;
	String? season;
	String? latestEpisode;
	String? type;
  
  RecentShowEntity();

  factory RecentShowEntity.fromJson(Map<String, dynamic> json) => _$RecentShowEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RecentShowEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
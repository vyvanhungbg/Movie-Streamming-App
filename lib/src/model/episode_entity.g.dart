// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EpisodeEntity _$EpisodeEntityFromJson(Map<String, dynamic> json) =>
    EpisodeEntity()
      ..id = json['id'] as String
      ..title = json['title'] as String
      ..url = json['url'] as String;

Map<String, dynamic> _$EpisodeEntityToJson(EpisodeEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'url': instance.url,
    };

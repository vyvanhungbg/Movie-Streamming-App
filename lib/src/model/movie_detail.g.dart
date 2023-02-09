// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetail _$MovieDetailFromJson(Map<String, dynamic> json) => MovieDetail()
  ..id = json['id'] as String?
  ..title = json['title'] as String?
  ..url = json['url'] as String?
  ..cover = json['cover'] as String?
  ..image = json['image'] as String?
  ..description = json['description'] as String?
  ..type = json['type'] as String?
  ..releaseDate = json['releaseDate'] as String?
  ..genres =
      (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..casts = (json['casts'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..tags = (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..production = json['production'] as String?
  ..country = json['country'] as String?
  ..duration = json['duration'] as String?
  ..rating = (json['rating'] as num?)?.toDouble()
  ..episodes = (json['episodes'] as List<dynamic>?)
      ?.map((e) => EpisodeEntity.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$MovieDetailToJson(MovieDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'url': instance.url,
      'cover': instance.cover,
      'image': instance.image,
      'description': instance.description,
      'type': instance.type,
      'releaseDate': instance.releaseDate,
      'genres': instance.genres,
      'casts': instance.casts,
      'tags': instance.tags,
      'production': instance.production,
      'country': instance.country,
      'duration': instance.duration,
      'rating': instance.rating,
      'episodes': instance.episodes,
    };

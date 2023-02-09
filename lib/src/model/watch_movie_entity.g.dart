// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watch_movie_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WatchMovieEntity _$WatchMovieEntityFromJson(Map<String, dynamic> json) =>
    WatchMovieEntity(
      json['headers'] == null
          ? null
          : WatchMovieHeaders.fromJson(json['headers'] as Map<String, dynamic>),
      (json['sources'] as List<dynamic>?)
          ?.map((e) => WatchMovieSources.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['subtitles'] as List<dynamic>?)
          ?.map((e) => WatchMovieSubtitles.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WatchMovieEntityToJson(WatchMovieEntity instance) =>
    <String, dynamic>{
      'headers': instance.headers,
      'sources': instance.sources,
      'subtitles': instance.subtitles,
    };

WatchMovieHeaders _$WatchMovieHeadersFromJson(Map<String, dynamic> json) =>
    WatchMovieHeaders()..referer = json['Referer'] as String;

Map<String, dynamic> _$WatchMovieHeadersToJson(WatchMovieHeaders instance) =>
    <String, dynamic>{
      'Referer': instance.referer,
    };

WatchMovieSources _$WatchMovieSourcesFromJson(Map<String, dynamic> json) =>
    WatchMovieSources()
      ..url = json['url'] as String
      ..quality = json['quality'] as String
      ..isM3U8 = json['isM3U8'] as bool;

Map<String, dynamic> _$WatchMovieSourcesToJson(WatchMovieSources instance) =>
    <String, dynamic>{
      'url': instance.url,
      'quality': instance.quality,
      'isM3U8': instance.isM3U8,
    };

WatchMovieSubtitles _$WatchMovieSubtitlesFromJson(Map<String, dynamic> json) =>
    WatchMovieSubtitles()
      ..url = json['url'] as String
      ..lang = json['lang'] as String;

Map<String, dynamic> _$WatchMovieSubtitlesToJson(
        WatchMovieSubtitles instance) =>
    <String, dynamic>{
      'url': instance.url,
      'lang': instance.lang,
    };

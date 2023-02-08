// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'array_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArrayResponse<T> _$ArrayResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ArrayResponse<T>(
      (json['results'] as List<dynamic>?)?.map(fromJsonT).toList(),
    );

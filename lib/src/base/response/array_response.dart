import 'package:cinema/src/model/movie_response_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'array_response.g.dart';
@JsonSerializable(createToJson: false, genericArgumentFactories: true)
class ArrayResponse<T> {

  @JsonKey(name: 'results')
  List<T>? results;

  ArrayResponse(this.results);

  factory ArrayResponse.fromJson(Map<String,dynamic> json, T Function(Object? json) fromJsonT) => _$ArrayResponseFromJson<T>(json, fromJsonT);

  @override
  String toString() {
    return 'ArrayResponse{results: $results}';
  }
}

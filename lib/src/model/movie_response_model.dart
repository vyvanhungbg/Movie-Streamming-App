import 'package:json_annotation/json_annotation.dart';
part 'movie_response_model.g.dart';
@JsonSerializable(createToJson: false)
class MovieResponseModel {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'url')
  String? url;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'releaseDate')
  String? releaseDate;
  @JsonKey(name: 'duration')
  String? duration;
  @JsonKey(name: 'type')
  String? type;

  MovieResponseModel(this.id, this.title, this.url, this.image,
      this.releaseDate, this.duration, this.type);

  factory MovieResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseModelFromJson(json);

  @override
  String toString() {
    return 'MovieResponseModel{id: $id, title: $title, url: $url, image: $image, releaseDate: $releaseDate, duration: $duration, type: $type}';
  }
}

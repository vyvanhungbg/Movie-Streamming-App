import 'package:cinema/src/base/sqfite/favorite_table.dart';
import 'package:json_annotation/json_annotation.dart';
part 'favorite_entity.g.dart';

@JsonSerializable()
class FavoriteEntity {
  @JsonKey(name: FavoriteTable.columnNameID)
  late String id;
  @JsonKey(name: FavoriteTable.columnNameImage)
  String? image;

  FavoriteEntity.init({required this.id, required this.image});

  FavoriteEntity();
  factory FavoriteEntity.fromJson(Map<String, dynamic> json) =>
      _$FavoriteEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteEntityToJson(this);

  @override
  String toString() {
    return 'FavoriteEntity{id: $id, image: $image}';
  }
}

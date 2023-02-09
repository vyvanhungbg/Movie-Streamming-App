// episodeId=2&mediaId=1&server=upcloud
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
enum Server { upcloud, vidcloud, mixdrop }
@JsonSerializable()
class WatchParameter {
  @JsonKey(name: "episodeId")
  final String episodeId;
  @JsonKey(name: "mediaId")
  final String mediaId;
  @JsonKey(name: "server")
  String server = Server.upcloud.name;

  WatchParameter({required this.episodeId, required this.mediaId,required this.server});


  Map<String,String> toJson() {
    return {'episodeId': episodeId, 'mediaId': mediaId, 'server': server};
  }

  WatchParameter copyWith({required Server server}){
    return WatchParameter(episodeId: this.episodeId, mediaId: this.mediaId, server: server.name);
  }

}

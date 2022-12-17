import 'package:json_annotation/json_annotation.dart';

part 'comment_info.g.dart';

@JsonSerializable()
class CommentInfo {
  String name;
  String avatar;

  CommentInfo(this.name, this.avatar);

  factory CommentInfo.fromJson(Map<String, dynamic> json) => _$CommentInfoFromJson(json);
  Map<String, dynamic> toJson() => _$CommentInfoToJson(this);
}
import 'package:json_annotation/json_annotation.dart';
import 'package:let_tutor/model/tutor/comment_info.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  String id;
  String bookingId;
  String firstId;
  String secondId;
  int rating;
  String content;
  String createdAt;
  String updatedAt;
  CommentInfo firstInfo;

  Comment(this.id,
    this.bookingId,
    this.firstId,
    this.secondId,
    this.rating,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.firstInfo);

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
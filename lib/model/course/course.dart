import 'package:json_annotation/json_annotation.dart';
import 'package:let_tutor/model/course/category.dart';
import 'package:let_tutor/model/course/topic.dart';

part 'course.g.dart';

@JsonSerializable()
class Course {
  String id;
  String name;
  String description;
  String imageUrl;
  String level;
  String reason;
  String purpose;
  bool visible;
  String createdAt;
  String updatedAt;
  List<Topic> topics;
  List<Category> categories;

  Course(this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.level,
    this.reason,
    this.purpose,
    this.visible,
    this.createdAt,
    this.updatedAt,
    this.topics,
    this.categories);

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
  Map<String, dynamic> toJson() => _$CourseToJson(this);
}
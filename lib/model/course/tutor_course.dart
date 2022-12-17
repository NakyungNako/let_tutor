
import 'package:json_annotation/json_annotation.dart';

part 'tutor_course.g.dart';

@JsonSerializable()
class TutorCourse {
  String id;
  String name;

  TutorCourse(this.id,
  this.name,);

  factory TutorCourse.fromJson(Map<String, dynamic> json) => _$TutorCourseFromJson(json);
  Map<String, dynamic> toJson() => _$TutorCourseToJson(this);
}
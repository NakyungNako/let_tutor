import 'package:json_annotation/json_annotation.dart';
import 'package:let_tutor/model/course/tutor_course.dart';

import 'learn_topics.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String id;
  String? email;
  String name;
  String avatar;
  String country;
  String? phone;
  List<String>? roles;
  String? language;
  String? birthday;
  bool? isActivated;
  List<TutorCourse> courses;
  String? level;
  List<LearnTopics>? learnTopics;
  String? studySchedule;

  User(this.id,
    this.email,
    this.name,
    this.avatar,
    this.country,
    this.phone,
    this.roles,
    this.language,
    this.birthday,
    this.isActivated,
    this.courses,
    this.level,
    this.learnTopics,
    this.studySchedule
      );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
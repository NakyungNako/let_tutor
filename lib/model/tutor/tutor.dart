import 'package:json_annotation/json_annotation.dart';

import '../user/user.dart';

part 'tutor.g.dart';

@JsonSerializable()
class Tutor {
  String video;
  String bio;
  String education;
  String experience;
  String profession;
  String targetStudent;
  String interests;
  String languages;
  String specialties;
  double? rating;
  User user;
  bool isFavorite;
  double avgRating;
  int totalFeedback;

  Tutor(this.video,
    this.bio,
    this.education,
    this.experience,
    this.profession,
    this.targetStudent,
    this.interests,
    this.languages,
    this.specialties,
    this.rating,
    this.user,
    this.isFavorite,
    this.avgRating,
    this.totalFeedback);

  factory Tutor.fromJson(Map<String, dynamic> json) => _$TutorFromJson(json);
  Map<String, dynamic> toJson() => _$TutorToJson(this);
}
import 'package:json_annotation/json_annotation.dart';

part 'tutor_search.g.dart';

@JsonSerializable()
class TutorSearch {
  String? level;
  String email;
  String avatar;
  String name;
  String country;
  String phone;
  String? language;
  String birthday;
  String createdAt;
  String updatedAt;
  String id;
  String userId;
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
  String? schedulestimes;
  String? isfavoritetutor;

  TutorSearch(this.level,
      this.email,
      this.avatar,
      this.name,
      this.country,
      this.phone,
      this.language,
      this.birthday,
      this.createdAt,
      this.updatedAt,
      this.id,
      this.userId,
      this.video,
      this.bio,
      this.education,
      this.experience,
      this.profession,
      this.targetStudent,
      this.interests,
      this.languages,
      this.specialties,
      this.rating,
      this.schedulestimes,
      this.isfavoritetutor,
      );

  factory TutorSearch.fromJson(Map<String, dynamic> json) => _$TutorSearchFromJson(json);
  Map<String, dynamic> toJson() => _$TutorSearchToJson(this);
}
import 'package:json_annotation/json_annotation.dart';

part 'tutor_schedule.g.dart';

@JsonSerializable()
class TutorSchedule {
  String id;
  String level;
  String email;
  String avatar;
  String name;
  String country;
  String phone;
  String language;
  String birthday;
  bool requestPassword;
  bool isActivated;
  bool isPhoneAuthActivated;
  bool canSendMessage;
  bool isPublicRecord;

  TutorSchedule(this.id,
    this.level,
    this.email,
    this.avatar,
    this.name,
    this.country,
    this.phone,
    this.language,
    this.birthday,
    this.requestPassword,
    this.isActivated,
    this.isPhoneAuthActivated,
    this.canSendMessage,
    this.isPublicRecord,);

  factory TutorSchedule.fromJson(Map<String, dynamic> json) => _$TutorScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$TutorScheduleToJson(this);
}
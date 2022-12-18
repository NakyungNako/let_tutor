import 'package:json_annotation/json_annotation.dart';
import 'package:let_tutor/model/tutor_schedule.dart';

part 'schedule_tutor.g.dart';

@JsonSerializable()
class ScheduleTutor {
  String date;
  int startTimestamp;
  int endTimestamp;
  String id;
  String tutorId;
  String startTime;
  String endTime;
  bool isDeleted;
  String createdAt;
  String updatedAt;
  TutorSchedule tutorInfo;

  ScheduleTutor(this.date,
      this.startTimestamp,
      this.endTimestamp,
      this.id,
      this.tutorId,
      this.startTime,
      this.endTime,
      this.isDeleted,
      this.createdAt,
      this.updatedAt,
      this.tutorInfo);

  factory ScheduleTutor.fromJson(Map<String, dynamic> json) => _$ScheduleTutorFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleTutorToJson(this);
}
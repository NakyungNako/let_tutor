// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_tutor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleTutor _$ScheduleTutorFromJson(Map<String, dynamic> json) =>
    ScheduleTutor(
      json['date'] as String,
      json['startTimestamp'] as int,
      json['endTimestamp'] as int,
      json['id'] as String,
      json['tutorId'] as String,
      json['startTime'] as String,
      json['endTime'] as String,
      json['isDeleted'] as bool,
      json['createdAt'] as String,
      json['updatedAt'] as String,
      TutorSchedule.fromJson(json['tutorInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ScheduleTutorToJson(ScheduleTutor instance) =>
    <String, dynamic>{
      'date': instance.date,
      'startTimestamp': instance.startTimestamp,
      'endTimestamp': instance.endTimestamp,
      'id': instance.id,
      'tutorId': instance.tutorId,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'isDeleted': instance.isDeleted,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'tutorInfo': instance.tutorInfo,
    };

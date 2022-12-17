// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedule _$ScheduleFromJson(Map<String, dynamic> json) => Schedule(
      json['id'] as String,
      json['tutorId'] as String,
      json['startTime'] as String,
      json['endTime'] as String,
      json['startTimestamp'] as int,
      json['endTimestamp'] as int,
      json['createdAt'] as String,
      json['isBooked'] as bool,
      (json['scheduleDetails'] as List<dynamic>)
          .map((e) => ScheduleDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'id': instance.id,
      'tutorId': instance.tutorId,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'startTimestamp': instance.startTimestamp,
      'endTimestamp': instance.endTimestamp,
      'createdAt': instance.createdAt,
      'isBooked': instance.isBooked,
      'scheduleDetails': instance.scheduleDetails,
    };

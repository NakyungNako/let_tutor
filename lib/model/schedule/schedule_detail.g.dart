// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleDetail _$ScheduleDetailFromJson(Map<String, dynamic> json) =>
    ScheduleDetail(
      json['startPeriodTimestamp'] as int,
      json['endPeriodTimestamp'] as int,
      json['id'] as String,
      json['scheduleId'] as String,
      json['startPeriod'] as String,
      json['endPeriod'] as String,
      json['createdAt'] as String,
      json['updatedAt'] as String,
      (json['bookingInfo'] as List<dynamic>)
          .map((e) => BookingInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['isBooked'] as bool,
    );

Map<String, dynamic> _$ScheduleDetailToJson(ScheduleDetail instance) =>
    <String, dynamic>{
      'startPeriodTimestamp': instance.startPeriodTimestamp,
      'endPeriodTimestamp': instance.endPeriodTimestamp,
      'id': instance.id,
      'scheduleId': instance.scheduleId,
      'startPeriod': instance.startPeriod,
      'endPeriod': instance.endPeriod,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'bookingInfo': instance.bookingInfo,
      'isBooked': instance.isBooked,
    };

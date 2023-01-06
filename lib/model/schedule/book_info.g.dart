// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingInfo _$BookingInfoFromJson(Map<String, dynamic> json) => BookingInfo(
      json['createdAtTimeStamp'] as int,
      json['updatedAtTimeStamp'] as int,
      json['id'] as String,
      json['isDeleted'] as bool,
      json['createdAt'] as String,
      json['scheduleDetailId'] as String,
      json['studentMeetingLink'] as String,
      json['updatedAt'] as String,
      json['cancelReasonId'] as int?,
      json['userId'] as String,
      json['scheduleDetailInfo'] == null
          ? null
          : ScheduleDetail.fromJson(
              json['scheduleDetailInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookingInfoToJson(BookingInfo instance) =>
    <String, dynamic>{
      'createdAtTimeStamp': instance.createdAtTimeStamp,
      'updatedAtTimeStamp': instance.updatedAtTimeStamp,
      'id': instance.id,
      'isDeleted': instance.isDeleted,
      'createdAt': instance.createdAt,
      'scheduleDetailId': instance.scheduleDetailId,
      'studentMeetingLink': instance.studentMeetingLink,
      'updatedAt': instance.updatedAt,
      'cancelReasonId': instance.cancelReasonId,
      'userId': instance.userId,
      'scheduleDetailInfo': instance.scheduleDetailInfo,
    };

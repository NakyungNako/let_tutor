// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TutorSchedule _$TutorScheduleFromJson(Map<String, dynamic> json) =>
    TutorSchedule(
      json['id'] as String,
      json['level'] as String,
      json['email'] as String,
      json['avatar'] as String,
      json['name'] as String,
      json['country'] as String,
      json['phone'] as String,
      json['language'] as String,
      json['birthday'] as String,
      json['requestPassword'] as bool,
      json['isActivated'] as bool,
      json['isPhoneAuthActivated'] as bool,
      json['canSendMessage'] as bool,
      json['isPublicRecord'] as bool,
    );

Map<String, dynamic> _$TutorScheduleToJson(TutorSchedule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
      'email': instance.email,
      'avatar': instance.avatar,
      'name': instance.name,
      'country': instance.country,
      'phone': instance.phone,
      'language': instance.language,
      'birthday': instance.birthday,
      'requestPassword': instance.requestPassword,
      'isActivated': instance.isActivated,
      'isPhoneAuthActivated': instance.isPhoneAuthActivated,
      'canSendMessage': instance.canSendMessage,
      'isPublicRecord': instance.isPublicRecord,
    };

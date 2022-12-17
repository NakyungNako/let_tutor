// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['id'] as String,
      json['email'] as String?,
      json['name'] as String,
      json['avatar'] as String,
      json['country'] as String,
      json['phone'] as String?,
      (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['language'] as String?,
      json['birthday'] as String?,
      json['isActivated'] as bool?,
      (json['courses'] as List<dynamic>)
          .map((e) => TutorCourse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['level'] as String?,
      (json['learnTopics'] as List<dynamic>?)
          ?.map((e) => LearnTopics.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['studySchedule'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'avatar': instance.avatar,
      'country': instance.country,
      'phone': instance.phone,
      'roles': instance.roles,
      'language': instance.language,
      'birthday': instance.birthday,
      'isActivated': instance.isActivated,
      'courses': instance.courses,
      'level': instance.level,
      'learnTopics': instance.learnTopics,
      'studySchedule': instance.studySchedule,
    };

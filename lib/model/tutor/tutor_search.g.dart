// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TutorSearch _$TutorSearchFromJson(Map<String, dynamic> json) => TutorSearch(
      json['level'] as String?,
      json['email'] as String,
      json['avatar'] as String,
      json['name'] as String,
      json['country'] as String,
      json['phone'] as String,
      json['language'] as String?,
      json['birthday'] as String,
      json['createdAt'] as String,
      json['updatedAt'] as String,
      json['id'] as String,
      json['userId'] as String,
      json['video'] as String,
      json['bio'] as String,
      json['education'] as String,
      json['experience'] as String,
      json['profession'] as String,
      json['targetStudent'] as String,
      json['interests'] as String,
      json['languages'] as String,
      json['specialties'] as String,
      (json['rating'] as num?)?.toDouble(),
      json['schedulestimes'] as String?,
      json['isfavoritetutor'] as String?,
    );

Map<String, dynamic> _$TutorSearchToJson(TutorSearch instance) =>
    <String, dynamic>{
      'level': instance.level,
      'email': instance.email,
      'avatar': instance.avatar,
      'name': instance.name,
      'country': instance.country,
      'phone': instance.phone,
      'language': instance.language,
      'birthday': instance.birthday,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'id': instance.id,
      'userId': instance.userId,
      'video': instance.video,
      'bio': instance.bio,
      'education': instance.education,
      'experience': instance.experience,
      'profession': instance.profession,
      'targetStudent': instance.targetStudent,
      'interests': instance.interests,
      'languages': instance.languages,
      'specialties': instance.specialties,
      'rating': instance.rating,
      'schedulestimes': instance.schedulestimes,
      'isfavoritetutor': instance.isfavoritetutor,
    };

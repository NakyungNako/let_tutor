// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tutor _$TutorFromJson(Map<String, dynamic> json) => Tutor(
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
      User.fromJson(json['User'] as Map<String, dynamic>),
      json['isFavorite'] as bool,
      (json['avgRating'] as num).toDouble(),
      json['totalFeedback'] as int,
    );

Map<String, dynamic> _$TutorToJson(Tutor instance) => <String, dynamic>{
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
      'user': instance.user,
      'isFavorite': instance.isFavorite,
      'avgRating': instance.avgRating,
      'totalFeedback': instance.totalFeedback,
    };

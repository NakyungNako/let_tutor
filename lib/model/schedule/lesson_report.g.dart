// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonReport _$LessonReportFromJson(Map<String, dynamic> json) => LessonReport(
      json['createdAt'] as String,
      json['id'] as int,
      json['reason'] as String,
      json['updatedAt'] as String,
    );

Map<String, dynamic> _$LessonReportToJson(LessonReport instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'id': instance.id,
      'reason': instance.reason,
      'updatedAt': instance.updatedAt,
    };

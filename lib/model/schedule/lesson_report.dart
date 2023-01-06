import 'package:json_annotation/json_annotation.dart';

part 'lesson_report.g.dart';

@JsonSerializable()
class LessonReport {
  String createdAt;
  int id;
  String reason;
  String updatedAt;

  LessonReport(this.createdAt,
      this.id,
      this.reason,
      this.updatedAt);

  factory LessonReport.fromJson(Map<String, dynamic> json) => _$LessonReportFromJson(json);
  Map<String, dynamic> toJson() => _$LessonReportToJson(this);
}
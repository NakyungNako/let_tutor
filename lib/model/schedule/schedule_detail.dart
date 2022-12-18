import 'package:json_annotation/json_annotation.dart';
import 'package:let_tutor/model/schedule/schedule.dart';
import 'package:let_tutor/model/schedule_tutor.dart';
import 'book_info.dart';

part 'schedule_detail.g.dart';

@JsonSerializable()
class ScheduleDetail {
  int startPeriodTimestamp;
  int endPeriodTimestamp;
  String id;
  String scheduleId;
  String startPeriod;
  String endPeriod;
  String createdAt;
  String updatedAt;
  List<BookingInfo>? bookingInfo;
  bool isBooked = false;
  ScheduleTutor? scheduleInfo;

  ScheduleDetail(this.startPeriodTimestamp,
    this.endPeriodTimestamp,
    this.id,
    this.scheduleId,
    this.startPeriod,
    this.endPeriod,
    this.createdAt,
    this.updatedAt,
    this.bookingInfo,
    this.isBooked,
      this.scheduleInfo
      );

  factory ScheduleDetail.fromJson(Map<String, dynamic> json) => _$ScheduleDetailFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleDetailToJson(this);
}
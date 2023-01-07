import 'package:json_annotation/json_annotation.dart';
import 'package:let_tutor/model/schedule/schedule_detail.dart';

import 'feedback.dart';

part 'book_info.g.dart';

@JsonSerializable()
class BookingInfo {
  int createdAtTimeStamp;
  int updatedAtTimeStamp;
  String id;
  bool isDeleted;
  String createdAt;
  String scheduleDetailId;
  String studentMeetingLink;
  String updatedAt;
  int? cancelReasonId;
  String userId;
  ScheduleDetail? scheduleDetailInfo;
  List<Feedback> feedbacks;

  BookingInfo(this.createdAtTimeStamp,
    this.updatedAtTimeStamp,
    this.id,
    this.isDeleted,
    this.createdAt,
    this.scheduleDetailId,
    this.studentMeetingLink,
    this.updatedAt,
    this.cancelReasonId,
    this.userId,
      this.scheduleDetailInfo,
      this.feedbacks);

  factory BookingInfo.fromJson(Map<String, dynamic> json) => _$BookingInfoFromJson(json);
  Map<String, dynamic> toJson() => _$BookingInfoToJson(this);
}
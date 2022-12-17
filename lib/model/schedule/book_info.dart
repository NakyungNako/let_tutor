import 'package:json_annotation/json_annotation.dart';

part 'book_info.g.dart';

@JsonSerializable()
class BookingInfo {
  int createdAtTimeStamp;
  int updatedAtTimeStamp;
  String id;
  bool isDeleted;
  String createdAt;
  String scheduleDetailId;
  String updatedAt;
  int? cancelReasonId;
  String userId;

  BookingInfo(this.createdAtTimeStamp,
    this.updatedAtTimeStamp,
    this.id,
    this.isDeleted,
    this.createdAt,
    this.scheduleDetailId,
    this.updatedAt,
    this.cancelReasonId,
    this.userId);

  factory BookingInfo.fromJson(Map<String, dynamic> json) => _$BookingInfoFromJson(json);
  Map<String, dynamic> toJson() => _$BookingInfoToJson(this);
}
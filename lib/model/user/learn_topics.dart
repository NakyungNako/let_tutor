import 'package:json_annotation/json_annotation.dart';

part 'learn_topics.g.dart';

@JsonSerializable()
class LearnTopics {
  late int id;
  late String key;
  late String name;

  LearnTopics(this.id, this.key, this.name);

  factory LearnTopics.fromJson(Map<String, dynamic> json) => _$LearnTopicsFromJson(json);
  Map<String, dynamic> toJson() => _$LearnTopicsToJson(this);
}
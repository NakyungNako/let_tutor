import 'package:json_annotation/json_annotation.dart';
import 'package:let_tutor/model/user/token.dart';

part 'tokens.g.dart';

@JsonSerializable()
class Tokens {
  Token access;
  Token refresh;

  Tokens(this.access, this.refresh);

  factory Tokens.fromJson(Map<String, dynamic> json) => _$TokensFromJson(json);
  Map<String, dynamic> toJson() => _$TokensToJson(this);
}
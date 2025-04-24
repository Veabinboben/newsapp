import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'source.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class Source {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;

  Source(this.id, this.name);

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);

  Map<String, dynamic> toJson() => _$SourceToJson(this);
}

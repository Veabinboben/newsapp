import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:newsapp/domain/models/article.dart';

part 'cachedArticleList.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
class ArticleList {
  @HiveField(0)
  String? theme;
  @HiveField(1)
  List<Article>? articles;

  ArticleList(this.theme, this.articles);

  factory ArticleList.fromJson(Map<String, dynamic> json) =>
      _$ArticleListFromJson(json);

  // A method that converts a User instance into a map.
  Map<String, dynamic> toJson() => _$ArticleListToJson(this);
}

import 'package:json_annotation/json_annotation.dart';
import 'package:newsapp/domain/models/source.dart';
import 'package:newsapp/domain/models/article.dart';

part 'articleResponseDTO.g.dart';

@JsonSerializable()
class ArticleResponseDTO{
  String status;
  int totalResults;
  List<Article> articles;


  ArticleResponseDTO(this.status, this.totalResults, this.articles);

  factory ArticleResponseDTO.fromJson(Map<String, dynamic> json) => _$ArticleResponseDTOFromJson(json);

  // A method that converts a User instance into a map.
  Map<String, dynamic> toJson() => _$ArticleResponseDTOToJson(this);
}
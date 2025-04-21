// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articleResponseDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleResponseDTO _$ArticleResponseDTOFromJson(Map<String, dynamic> json) =>
    ArticleResponseDTO(
      json['status'] as String,
      (json['totalResults'] as num).toInt(),
      (json['articles'] as List<dynamic>)
          .map((e) => Article.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArticleResponseDTOToJson(ArticleResponseDTO instance) =>
    <String, dynamic>{
      'status': instance.status,
      'totalResults': instance.totalResults,
      'articles': instance.articles,
    };

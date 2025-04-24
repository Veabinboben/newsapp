// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cachedArticleList.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArticleListAdapter extends TypeAdapter<ArticleList> {
  @override
  final int typeId = 2;

  @override
  ArticleList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ArticleList(
      fields[0] as String?,
      (fields[1] as List?)?.cast<Article>(),
    );
  }

  @override
  void write(BinaryWriter writer, ArticleList obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.theme)
      ..writeByte(1)
      ..write(obj.articles);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArticleListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleList _$ArticleListFromJson(Map<String, dynamic> json) => ArticleList(
      json['theme'] as String?,
      (json['articles'] as List<dynamic>?)
          ?.map((e) => Article.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArticleListToJson(ArticleList instance) =>
    <String, dynamic>{
      'theme': instance.theme,
      'articles': instance.articles,
    };

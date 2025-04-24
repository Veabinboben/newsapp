import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:newsapp/domain/models/article.dart';
import 'package:newsapp/data/models/cachedArticleList.dart';

class ArticleListDb
{
  static const articleListBox = '_articleListBox';
  late final ValueListenable<Box<dynamic>> box = ValueNotifier(Hive.box(articleListBox));

  late final Box<dynamic> _box = box.value;

  ArticleListDb();

  Future<ArticleList?> getValue<T>(String theme) async =>  await _box.get(theme);
  Future<void> setValue<T>(ArticleList value) async => await _box.put(value.theme,value);
  Future<void> deleteValue<T> (String theme) async => await _box.delete(theme);
  Future<void> clearAll() async => await _box.clear();

}
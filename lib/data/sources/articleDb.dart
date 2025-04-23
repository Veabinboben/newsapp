import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:newsapp/domain/models/article.dart';

class ArticleDb
{
  static const articleBox = '_articleBox';
  late final ValueListenable<Box<dynamic>> box = ValueNotifier(Hive.box(articleBox));

  late final Box<dynamic> _box = box.value;

  ArticleDb();


  //TODO implementation is not correct redo
  Future<Article> getValue<T>(String url, {Article? defaultvalue}) async =>  await _box.get(url,defaultValue: defaultvalue,);
  Future<void> setValue<T>(Article value) async => await _box.put(value.url,value);
  Future<void> deleteValue<T> (String url) async => await _box.delete(url);
  Future<void> clearAll() async => await _box.clear();
  Future<List<Article>> getAll() async => await (_box.values.cast<Article>().toList());



}
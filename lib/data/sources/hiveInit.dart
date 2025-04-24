import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:newsapp/data/models/cachedArticleList.dart';
import 'package:newsapp/data/sources/articleDb.dart';
import 'package:newsapp/data/sources/articleListDb.dart';
import 'package:newsapp/domain/models/source.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:newsapp/domain/models/article.dart';

class HiveInjector {
  static Future<void> setup() async {
    await Hive.initFlutter();
    Directory directory = await pathProvider.getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    _registerAdapters();
    await Hive.openBox(ArticleDb.articleBox);
    await Hive.openBox(ArticleListDb.articleListBox);
  }

  static void _registerAdapters() {
    Hive.registerAdapter(ArticleAdapter());
    Hive.registerAdapter(SourceAdapter());
    Hive.registerAdapter(ArticleListAdapter());
  }
}

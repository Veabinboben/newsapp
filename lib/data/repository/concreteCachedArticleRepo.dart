import 'package:newsapp/data/models/cachedArticleList.dart';
import 'package:newsapp/data/sources/articleListDb.dart';
import 'package:newsapp/domain/models/article.dart';
import 'package:logger/logger.dart';
import 'package:newsapp/domain/repository/abstractCachedArticleRepo.dart';

final logger = Logger();

class ArticleCacheRepo implements AbstractCachedArticlesRepo {
  late final ArticleListDb _database;

  ArticleCacheRepo() {
    _database = ArticleListDb();
  }

  @override
  Future<List<Article>> getCachedArticles(String theme) async {
    try {
      final res = await _database.getValue(theme);
      if (res == null) return [];
      return res.articles!;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> saveCachedArticles(List<Article> articles, String theme) async {
    try {
      final articleList = ArticleList(theme, articles);
      await _database.setValue(articleList);
    } catch (e) {
      throw Exception(e);
    }
  }
}

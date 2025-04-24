import 'package:newsapp/domain/models/article.dart';

abstract class AbstractCachedArticlesRepo {
  Future<List<Article>> getCachedArticles(String theme);
  Future<void> saveCachedArticles(List<Article> articles, String theme);
}

import 'package:newsapp/domain/models/article.dart';

abstract class AbstractBookmarkRepo{
  Future<List<Article>> getSavedArticles();
  Future<void> saveArticle(Article article);
}

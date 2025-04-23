import 'package:newsapp/domain/models/article.dart';

abstract class AbstractBookmarkRepo{
  Future<List<Article>> getSavedArticles();
  Future<Article?> getSavedArticle(Article article);
  Future<void> saveArticle(Article article);
  Future<void> deleteArticle(Article article);
}

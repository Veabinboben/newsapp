import 'package:newsapp/domain/models/article.dart';

abstract class AbstractArticlesRepo{
    Future<List<Article>> getArticles(Map<String, dynamic>? queries);
}
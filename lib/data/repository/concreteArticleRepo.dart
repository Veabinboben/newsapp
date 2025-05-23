import 'package:newsapp/data/sources/articleApi.dart';
import 'package:newsapp/domain/models/article.dart';
import 'package:newsapp/domain/repository/abstractArticlesRepo.dart';
import 'package:dio/dio.dart';

class ArticlesRepo implements AbstractArticlesRepo {
  ArticlesRepo() {
    final Dio dio = Dio();
    _client = ArticleHttpClient(dio);
  }
  late final ArticleHttpClient _client;
  /*
      Better idea to move apiKey to config file, but it is good for now
   */
  final String _apiKey = 'aad8508f58de4356bf1981eef4fd06b4';

  @override
  Future<List<Article>> getArticles(Map<String, dynamic>? queries) async {
    queries ??= Map<String, dynamic>();
    // Default querries
    queries["apiKey"] = _apiKey;
    // queries["q"] = "apple";
    queries["sortBy"] = "relevancy";
    queries["language"] = "en";
    try {
      final res = await _client.getArticles(queries);
      return res.articles;
    } catch (e) {
      rethrow;
    }
  }
}

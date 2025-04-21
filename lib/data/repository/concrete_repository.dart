import 'package:newsapp/data/sources/articleApi.dart';
import 'package:newsapp/domain/models/article.dart';
import 'package:newsapp/domain/repository/abstract_articles_repo.dart';
import 'package:dio/dio.dart';

class ArticlesRepo implements AbstractArticlesRepo{
  late final ArticleHttpClient _client;
  /*
      Better idea to move apiKey to config file, but it is god for now
   */
  final _apiKey = "aad8508f58de4356bf1981eef4fd06b4";

  ArticlesRepo(){
    Dio dio = Dio();
    _client = ArticleHttpClient(dio);
  }

  @override
  Future<List<Article>> getArticles(Map<String, dynamic>? queries) async {
    queries ??= Map<String, dynamic>();
    queries["apiKey"] = _apiKey;
    queries["q"] = "apple";
    try {
      final res = await _client.getArticles(queries);
      return res.articles;
    }
    catch(e){
      //FIXME
      print(e);
      rethrow;
    }
  }

}
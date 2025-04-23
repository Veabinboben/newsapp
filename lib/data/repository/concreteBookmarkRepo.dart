import 'package:newsapp/data/sources/articleApi.dart';
import 'package:newsapp/data/sources/articleDb.dart';
import 'package:newsapp/domain/models/article.dart';
import 'package:newsapp/domain/repository/abstractBookmarkRepo.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class BookmarkRepo implements AbstractBookmarkRepo{
  late final ArticleDb _database;

  BookmarkRepo(){
    _database = ArticleDb();
  }

  @override
  Future<List<Article>> getSavedArticles() async {
    try {
      final res = await _database.getAll();
      return res ?? [];
    }
    catch (e){
      logger.i(e.toString());
      // FIXME not so great;
      return [];
    }

  }

  @override
  Future<void> saveArticle(Article article) async  {
    // TODO: implement saveArticle
    await _database.setValue(article);
  }



}
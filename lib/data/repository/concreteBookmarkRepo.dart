import 'package:newsapp/data/sources/articleDb.dart';
import 'package:newsapp/domain/models/article.dart';
import 'package:newsapp/domain/repository/abstractBookmarkRepo.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class BookmarkRepo implements AbstractBookmarkRepo {
  late final ArticleDb _database;

  BookmarkRepo() {
    _database = ArticleDb();
  }

  @override
  Future<List<Article>> getSavedArticles() async {
    try {
      final res = await _database.getAll();
      return res;
    } catch (e) {
      logger.i(e.toString());
      return [];
    }
  }

  @override
  Future<void> saveArticle(Article article) async {
    await _database.setValue(article);
  }

  @override
  Future<void> deleteArticle(Article article) async {
    if (article.url == null) return;
    await _database.deleteValue(article.url!);
  }

  @override
  Future<Article?> getSavedArticle(Article article) async {
    return await _database.getValue(article.url ?? "NULL URL",
        defaultvalue: null);
  }
}

part of 'articleBloc.dart';


abstract class ArticleState {
  List<Article>? articles;
  int page ;
  int pageSize ;
  String theme;

  ArticleState(this.articles, {this.pageSize = 50, this.page = 1, this.theme = "any"} );
}

class InitialState extends ArticleState {
  InitialState() : super(null);
}

class LoadingGetArticleState extends ArticleState {
  LoadingGetArticleState() : super(null);
}

class ErrorGetArticleState extends ArticleState {
  final String errorMsg;
  ErrorGetArticleState(this.errorMsg) : super(null);
}

class SuccessGetArticleState extends ArticleState {
  SuccessGetArticleState(List<Article> super.articles, {super.pageSize = 50, super.page = 1, super.theme = "any"});
}

class SuccessGetCachedArticleState extends ArticleState {
  SuccessGetCachedArticleState(List<Article> super.articles, {super.pageSize = 50, super.page = 1, super.theme = "any"});
}
part of 'articleBloc.dart';

abstract class ArticleEvent {
  const ArticleEvent();
}

class OnGettingArticleEvent extends ArticleEvent {
  final String theme;
  final int page ;
  final int pageSize ;

  OnGettingArticleEvent(this.theme,{this.page = 1, this.pageSize = 50});
}

class OnGettingCachedArticleEvent extends ArticleEvent {
  final String theme;

  OnGettingCachedArticleEvent(this.theme);
}

class OnAppendArticleEvent extends ArticleEvent {
  OnAppendArticleEvent();
}


class TryGetArticleEvent extends ArticleEvent {}
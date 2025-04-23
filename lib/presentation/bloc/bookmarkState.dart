part of 'bookmarkBloc.dart';


abstract class BookmarkState {
  const BookmarkState();
}

class InitialState extends BookmarkState {}

class LoadingGetBookmarkState extends BookmarkState {}

class ErrorGetBookmarkState extends BookmarkState {
  final String errorMsg;
  ErrorGetBookmarkState(this.errorMsg);
}

class SucsessGetBookmarkState extends BookmarkState {
  final List<Article> articles;
  SucsessGetBookmarkState(this.articles);
}

class SucsessSaveBookmarkState extends BookmarkState {
  SucsessSaveBookmarkState();
}

class SucsessDeleteBookmarkState extends BookmarkState {
  SucsessDeleteBookmarkState();
}



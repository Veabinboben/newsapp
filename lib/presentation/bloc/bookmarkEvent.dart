part of 'bookmarkBloc.dart';

abstract class BookmarkEvent {
  const BookmarkEvent();
}

class OnGettingBookmarkEvent extends BookmarkEvent {
}

class SaveBookmarkEvent extends BookmarkEvent{
  final Article article;

  SaveBookmarkEvent(this.article);
}
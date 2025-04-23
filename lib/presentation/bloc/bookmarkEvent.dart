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

class DeleteBookmarkEvent extends BookmarkEvent{
  final Article article;

  DeleteBookmarkEvent(this.article);
}

import 'package:newsapp/domain/models/article.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/domain/repository/abstractBookmarkRepo.dart';
import 'package:logger/logger.dart';

part 'bookmarkEvent.dart';
part 'bookmarkState.dart';

final logger = Logger();

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final AbstractBookmarkRepo repo;

  BookmarkBloc({required this.repo}) : super(LoadingGetBookmarkState()) {
    on<OnGettingBookmarkEvent>(_onGettingBookmarkEvent);
    on<SaveBookmarkEvent>(_saveBookmarkEvent);
    on<DeleteBookmarkEvent>(_deleteBookmarkEvent);
  }

  _onGettingBookmarkEvent(
      OnGettingBookmarkEvent event, Emitter<BookmarkState> emitter) async {
    try {
      final res = await repo.getSavedArticles();
      logger.i(res);
      emitter(SucsessGetBookmarkState(res));
    } catch (e) {
      emitter(ErrorGetBookmarkState(e.toString()));
    }
  }

  _saveBookmarkEvent(
      SaveBookmarkEvent event, Emitter<BookmarkState> emitter) async {
    try {
      await repo.saveArticle(event.article);
      logger.i('added');
      final res = await repo.getSavedArticles();
      logger.i(res);
      emitter(SucsessGetBookmarkState(res));
    } catch (e) {
      logger.i('error adding ${e.toString()}');
      emitter(ErrorGetBookmarkState(e.toString()));
    }
  }

  _deleteBookmarkEvent(
      DeleteBookmarkEvent event, Emitter<BookmarkState> emitter) async {
    try {
      await repo.deleteArticle(event.article);
      logger.i('deleted');
      final res = await repo.getSavedArticles();
      logger.i(res);
      emitter(SucsessGetBookmarkState(res));
    } catch (e) {
      logger.i('error adding ${e.toString()}');
      emitter(ErrorGetBookmarkState(e.toString()));
    }
  }
}

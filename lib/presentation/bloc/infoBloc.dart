import 'package:newsapp/domain/models/article.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/domain/repository/abstractBookmarkRepo.dart';
import 'package:logger/logger.dart';

part 'infoEvent.dart';
part 'infoState.dart';

final logger = Logger();

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  final AbstractBookmarkRepo repo;

  InfoBloc({required this.repo}) : super(DefaultInfoState()) {
    on<CheckExistenceEvent>(_checkExistenceEvent);
  }

  _checkExistenceEvent(
      CheckExistenceEvent event, Emitter<InfoState> emitter) async {
    try {
      final res = await repo.getSavedArticle(event.article);
      emitter(CheckedExistenceState(res != null));
    } catch (e) {
      logger.i("error checking ${e.toString()}");
      emitter(CheckedExistenceState(false));
    }
  }
}

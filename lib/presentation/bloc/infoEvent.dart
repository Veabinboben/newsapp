part of 'infoBloc.dart';

abstract class InfoEvent {
  const InfoEvent();
}

class CheckExistenceEvent extends InfoEvent{
  final Article article;

  CheckExistenceEvent(this.article);
}
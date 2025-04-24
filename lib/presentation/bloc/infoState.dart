part of 'infoBloc.dart';

abstract class InfoState {
  InfoState();
}

class DefaultInfoState extends InfoState {}

class CheckedExistenceState extends InfoState {
  bool present;

  CheckedExistenceState(this.present);
}

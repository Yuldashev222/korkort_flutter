part of 'level_bloc.dart';

@immutable
abstract class LevelState {
  final List<LevelResponse>? levelList;
  LevelState({this.levelList});
}

class LevelInitial extends LevelState {}
class LevelLoaded extends LevelState {
  final List<LevelResponse>? levelList;
LevelLoaded({this.levelList}):super(levelList: levelList);
}
class LevelLoading extends LevelState {}
class LevelError extends LevelState {}

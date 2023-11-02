part of 'lesson_bloc.dart';

@immutable
abstract class LessonState {
  final LessonResponse? lessonResponse;
  final List<StatisticsResponse>? statisticsList;

  LessonState({this.lessonResponse, this.statisticsList});
}

class LessonInitial extends LessonState {}

class LessonLoaded extends LessonState {
  final LessonResponse? lessonResponse;

  LessonLoaded({this.lessonResponse}) : super(lessonResponse: lessonResponse);
}

class LessonNextError403 extends LessonState {}

class LessonLoading extends LessonState {}

class LessonError extends LessonState {}

class ChartLoaded extends LessonState {
  final List<StatisticsResponse>? statisticsList;
  final LessonResponse? lessonResponse;

  ChartLoaded({this.statisticsList,this.lessonResponse}) : super(statisticsList: statisticsList,lessonResponse: lessonResponse);
}

class ChartLoading extends LessonState {}

class ChartError extends LessonState {}

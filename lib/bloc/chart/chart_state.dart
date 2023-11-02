part of 'chart_bloc.dart';

@immutable
abstract class ChartState {
  final LessonResponse? lessonResponse;
  final List<StatisticsResponse>? statisticsList;
  ChartState({this.lessonResponse,this.statisticsList});
}

class ChartInitial extends ChartState {}
class ChartStateLoaded extends ChartState {
  final List<StatisticsResponse>? statisticsList;
  final LessonResponse? lessonResponse;

  ChartStateLoaded({this.statisticsList,this.lessonResponse}) : super(statisticsList: statisticsList,lessonResponse: lessonResponse);
}

class ChartLoading extends ChartState {}

class ChartError extends ChartState {}
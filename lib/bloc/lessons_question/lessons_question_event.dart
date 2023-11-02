part of 'lessons_question_bloc.dart';

@immutable
abstract class LessonsQuestionEvent {
  final int?id;

  LessonsQuestionEvent({this.id});
}

class LessonsQuestionIdEvent extends LessonsQuestionEvent {
  final int?id;

  LessonsQuestionIdEvent({this.id}) :super(id: id);
}
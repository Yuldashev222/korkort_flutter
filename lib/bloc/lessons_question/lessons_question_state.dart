part of 'lessons_question_bloc.dart';

@immutable
abstract class LessonsQuestionState {
  final List<QuestionResponse>? questionResponseList;

  LessonsQuestionState({this.questionResponseList});
}

class LessonsQuestionInitial extends LessonsQuestionState {}

class LessonsQuestionLoaded extends LessonsQuestionState {
  final List<QuestionResponse>? questionResponseList;
  LessonsQuestionLoaded({this.questionResponseList}):super(questionResponseList: questionResponseList);
}

class LessonsQuestionError extends LessonsQuestionState {}

class LessonsQuestionLoading extends LessonsQuestionState {}

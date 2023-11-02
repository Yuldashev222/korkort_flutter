part of 'categories_filter_bloc.dart';

@immutable
abstract class CategoriesFilterState {
  final ExamQuestionResponse? examsQuestionResponse;
  final List<MixQuestionsResponse>? mixQuestionsResponseList;

  CategoriesFilterState({this.examsQuestionResponse,this.mixQuestionsResponseList});
}

class CategoriesFilterInitial extends CategoriesFilterState {}

class CategoriesFilterLoading extends CategoriesFilterState {}

class CategoriesFilterLoaded extends CategoriesFilterState {
  final ExamQuestionResponse? examsQuestionResponse;

  CategoriesFilterLoaded({this.examsQuestionResponse}) : super(examsQuestionResponse: examsQuestionResponse);
}class CategoriesMixFilterLoaded extends CategoriesFilterState {
  final List<MixQuestionsResponse>? mixQuestionsResponseList;

  CategoriesMixFilterLoaded({this.mixQuestionsResponseList}) : super(mixQuestionsResponseList: mixQuestionsResponseList);
}

class CategoriesFilterError extends CategoriesFilterState {}

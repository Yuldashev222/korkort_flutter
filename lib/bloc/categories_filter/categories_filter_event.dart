part of 'categories_filter_bloc.dart';

@immutable
abstract class CategoriesFilterEvent extends Emittable {
  final int? categoryId;
  final int? questions;
  final int? difficultyLevel;
  final List? wrongQuestions;
  final List? correctQuestions;
  final List? categoryIds;
  final int? examId;
  final int? count;
  final bool? myQuestions;

  CategoriesFilterEvent({this.categoryId, this.questions, this.difficultyLevel, this.correctQuestions, this.wrongQuestions,this.examId,this.myQuestions,this.count,this.categoryIds});
}

class CategoriesFilterGetEvent extends CategoriesFilterEvent {
  final int? categoryId;
  final int? questions;
  final int? difficultyLevel;

  CategoriesFilterGetEvent({this.difficultyLevel, this.questions, this.categoryId}) : super(difficultyLevel: difficultyLevel, questions: questions, categoryId: categoryId);

  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}

class CategoriesMixFilterGetEvent extends CategoriesFilterEvent {
  final int? questions;
  final int? difficultyLevel;
  final List? categoryIds;

  CategoriesMixFilterGetEvent({
    this.difficultyLevel,
    this.questions,
    this.categoryIds,
  }) : super(
          difficultyLevel: difficultyLevel,
          questions: questions,
      categoryIds:categoryIds
        );

  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}

class CategoriesWrongFilterGetEvent extends CategoriesFilterEvent {
  final int? questions;
  final int? difficultyLevel;
  final bool? myQuestions;

  CategoriesWrongFilterGetEvent({
    this.difficultyLevel,
    this.questions,
    this.myQuestions,
  }) : super(
          difficultyLevel: difficultyLevel,
          questions: questions,
    myQuestions: myQuestions,
        );

  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}
class CategoriesSavedFilterGetEvent extends CategoriesFilterEvent {
  final int? questions;
  final int? difficultyLevel;
  final bool? myQuestions;

  CategoriesSavedFilterGetEvent({
    this.difficultyLevel,
    this.questions,
    this.myQuestions,
  }) : super(
          difficultyLevel: difficultyLevel,
          questions: questions,
          myQuestions: myQuestions,
        );

  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}

class CategoriesFinalFilterGetEvent extends CategoriesFilterEvent {
  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}

class CategoriesAnswerPostEvent extends CategoriesFilterEvent {
  final List? wrongQuestions;
  final List? correctQuestions;
final int? examId;
  CategoriesAnswerPostEvent({
    this.wrongQuestions,
    this.correctQuestions,
    this.examId,
  }) : super(wrongQuestions: wrongQuestions, correctQuestions: correctQuestions,examId: examId);

  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}
class WrongAnswersPostEvent extends CategoriesFilterEvent {
  final List? wrongQuestions;
  final List? correctQuestions;
  final int?count;
  WrongAnswersPostEvent({
    this.wrongQuestions,
    this.correctQuestions,
    this.count
  }) : super(wrongQuestions: wrongQuestions, correctQuestions: correctQuestions,count:count);

  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}
class SavedAnswersPostEvent extends CategoriesFilterEvent {
  final List? wrongQuestions;
  final List? correctQuestions;
  SavedAnswersPostEvent({
    this.wrongQuestions,
    this.correctQuestions,
  }) : super(wrongQuestions: wrongQuestions, correctQuestions: correctQuestions);

  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}
class MixAnswersPostEvent extends CategoriesFilterEvent {
  final List? wrongQuestions;
  final List? correctQuestions;
  MixAnswersPostEvent({
    this.wrongQuestions,
    this.correctQuestions,
  }) : super(wrongQuestions: wrongQuestions, correctQuestions: correctQuestions);

  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}

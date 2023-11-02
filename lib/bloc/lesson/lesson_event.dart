part of 'lesson_bloc.dart';

@immutable
abstract class LessonEvent extends Emittable {
  final int? id;
  final int? testId;
  final List? answerTrue;
  final int? chapterId;

  LessonEvent({this.id, this.answerTrue, this.chapterId,this.testId});
}

class LessonIdEvent extends LessonEvent {
  final int? id;

  LessonIdEvent({this.id});

  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}
class LessonIdForChaptersEvent extends LessonEvent {
  final int? id;

  LessonIdForChaptersEvent({this.id});

  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}
class LessonAnswerTrueEvent extends LessonEvent {
  final List? answerTrue;
  final int? id;
  final int? chapterId;

  LessonAnswerTrueEvent({this.answerTrue, this.id, this.chapterId}) : super(id: id, answerTrue: answerTrue, chapterId: chapterId);

  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}
class LessonStatisticsEvent extends LessonEvent {
  final int? id;
  LessonStatisticsEvent({this.id}):super(id: id);
  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}class LessonTestEvent extends LessonEvent {
  final int? testId;
  LessonTestEvent({this.testId}):super(testId: testId);
  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}

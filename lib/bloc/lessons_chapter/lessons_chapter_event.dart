part of 'lessons_chapter_bloc.dart';

@immutable
abstract class LessonsChapterEvent extends Emittable{
  final int? lessonsChapterId;
  LessonsChapterEvent({this.lessonsChapterId});
}
class LessonsChapterIdEvent extends LessonsChapterEvent{
  final int? lessonsChapterId;
LessonsChapterIdEvent({this.lessonsChapterId}):super(lessonsChapterId: lessonsChapterId);

  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}
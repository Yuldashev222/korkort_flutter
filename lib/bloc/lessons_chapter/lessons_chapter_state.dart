part of 'lessons_chapter_bloc.dart';

@immutable
abstract class LessonsChapterState {
  final List<LessonChapterResponse>? lessonChapterResponseList;
  final ProfileResponse? profileResponse;
final int?isOpenCount;
  LessonsChapterState({this.lessonChapterResponseList,this.profileResponse,this.isOpenCount});
}

class LessonsChapterInitial extends LessonsChapterState {}

class LessonsChapterLoading extends LessonsChapterState {}

class LessonsChapterLoaded extends LessonsChapterState {
  final List<LessonChapterResponse>? lessonChapterResponseList;
  final ProfileResponse? profileResponse;
  final int? isOpenCount;

  LessonsChapterLoaded({this.lessonChapterResponseList,this.profileResponse,this.isOpenCount}) : super(lessonChapterResponseList: lessonChapterResponseList,profileResponse: profileResponse,
      isOpenCount: isOpenCount);
}

class LessonsChapterError extends LessonsChapterState {}

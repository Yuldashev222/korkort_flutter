part of 'book_bloc.dart';

@immutable
abstract class BookEvent {
  final int? page;
  final bool? isCompleted;
  final int? chapter;
  final int? id;

  BookEvent({this.page, this.isCompleted, this.chapter,this.id});
}

class BookGetEvent extends BookEvent {}

class BookChaptersUpdateEvent extends BookEvent {
  final bool? isCompleted;
  final int? chapter;

  BookChaptersUpdateEvent({this.chapter, this.isCompleted}) : super(chapter: chapter, isCompleted: isCompleted);
}

class BookAddEvent extends BookEvent {
  final int page;

  BookAddEvent({required this.page}) : super(page: page);
}class BookGetIdEvent extends BookEvent {
  final int id;

  BookGetIdEvent({required this.id}) : super(id: id);
}

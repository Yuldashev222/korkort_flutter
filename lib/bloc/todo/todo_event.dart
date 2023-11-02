part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {
  final int? todo;
  final int? page;
  final bool? isCompleted;

  TodoEvent({this.todo, this.isCompleted,this.page});
}

class TodoGetEvent extends TodoEvent {}
class TodoAddEvent extends TodoEvent {
  final int? page;
  TodoAddEvent({this.page}):super(page:page);
}


class TodoUpdateEvent extends TodoEvent {
  final int? todo;
  final bool? isCompleted;

  TodoUpdateEvent({this.todo, this.isCompleted}):super(todo: todo,isCompleted: isCompleted);
}

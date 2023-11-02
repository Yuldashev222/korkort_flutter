part of 'todo_bloc.dart';

@immutable
abstract class TodoState {
  final TodoResponse?todoResponse;
  TodoState({this.todoResponse});
}

class TodoInitial extends TodoState {}
class TodoError extends TodoState {}
class TodoLoading extends TodoState {}
class TodoLoaded extends TodoState {
  final TodoResponse? todoResponse;
  TodoLoaded({this.todoResponse}):super(todoResponse: todoResponse);
}

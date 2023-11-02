import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:korkort/model/todo_response.dart';
import 'package:korkort/repository/repository.dart';
import 'package:meta/meta.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  Repository repository = Repository();
  GetStorage getStorage = GetStorage();
  TodoBloc() : super(TodoInitial()) {

    on<TodoGetEvent>(_onLoad);
    on<TodoAddEvent>(_addTodo);
    on<TodoUpdateEvent>((event, emit) async {
      await repository.todoUpdate(token: getStorage.read("token"), language: getStorage.read("language"), todo: event.todo,isCompleted: event.isCompleted).then((value)async {
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          emit(TodoError());
          if (value?.statusCode == 401) {
            await getStorage.remove("token");
          }
        } else {
          // emit(TodoLoaded(todoResponse: TodoResponse.fromJson(value?.data)));
        }
      });
    });
  }
  _onLoad(TodoGetEvent event, Emitter<TodoState> emit) async {
    await repository.todoGet(token: getStorage.read("token"), language: getStorage.read("language"), page: 1).then((value) async {
      if (value?.statusCode != null && value?.statusCode as int > 299) {
        emit(TodoError());
        if (value?.statusCode == 401) {
          await getStorage.remove("token");
        }
      } else {
        TodoResponse todoResponse = TodoResponse.fromJson(value?.data);
     emit(TodoLoaded(todoResponse: todoResponse));
      }
    });
  }

  _addTodo(TodoAddEvent event, Emitter<TodoState> emit) async {
    await repository.todoGet(token: getStorage.read("token"), language: getStorage.read("language"), page: event.page).then((value) async {
      if (value?.statusCode != null && value?.statusCode as int > 299) {
        if (value?.statusCode == 404) {
        }else if (value?.statusCode == 401) {
          await getStorage.remove("token");
          emit(TodoError());
        }else{
          emit(TodoError());
        }
      } else {
        TodoResponse todoResultResponse = TodoResponse.fromJson(value?.data);
        List<Results>? todoResultsList = todoResultResponse.results;
        List<Results> todoResults = state.todoResponse?.results ?? [];
        todoResults.addAll(todoResultsList ?? []);
        emit(TodoLoaded(todoResponse: TodoResponse(results:todoResults )));
      }
    });
  }
}

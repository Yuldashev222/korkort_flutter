import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:korkort/model/books_response.dart';
import 'package:korkort/repository/repository.dart';
import 'package:meta/meta.dart';

import '../../model/book_id_response.dart';

part 'book_event.dart';

part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  Repository repository = Repository();
  GetStorage getStorage = GetStorage();
  BooksResponse booksResponse=BooksResponse();

  BookBloc() : super(BookInitial()) {

    on<BookGetEvent>(_onLoad);
    on<BookChaptersUpdateEvent>((event, emit) async {
      await repository.bookUpdateCheck(token: getStorage.read("token"), language: getStorage.read("language"),chapter: event.chapter,isCompleted: event.isCompleted).then((value)async {
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          // emit(BookError());
          if (value?.statusCode == 401) {
            await getStorage.remove("token");
          }
        } else {
          // emit(BookLoaded(booksResponse: BooksResponse.fromJson(value?.data)));
        }
      });
    });
    on<BookAddEvent>(_addBooks);
    on<BookGetIdEvent>((event, emit) async {
      await repository.bookGetId(token: getStorage.read("token"), language: getStorage.read("language"),id: event.id).then((value)async {
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          emit(BookError());
         if (value?.statusCode == 401) {
            await getStorage.remove("token");
            emit(BookError());
          }
        } else {
          emit(BookLoaded(booksIdResponse: BooksIdResponse.fromJson(value?.data),booksResponse: booksResponse));
        }
      });
    });
  }
  _onLoad(BookGetEvent event, Emitter<BookState> emit) async {
    await repository.bookGet(token: getStorage.read("token"), language: getStorage.read("language"), page: 1).then((value) async {
      if (value?.statusCode != null && value?.statusCode as int > 299) {
        emit(BookError());
        if (value?.statusCode == 401) {
          await getStorage.remove("token");
        }
      } else {
        booksResponse = BooksResponse.fromJson(value?.data);
        emit(BookLoaded(booksResponse: booksResponse));
      }
    });
  }

  _addBooks(BookAddEvent event, Emitter<BookState> emit) async {
    await repository.bookGet(token: getStorage.read("token"), language: getStorage.read("language"), page: event.page).then((value) async {
      if (value?.statusCode != null && value?.statusCode as int > 299) {
        if (value?.statusCode == 404) {
        }else if (value?.statusCode == 401) {
          await getStorage.remove("token");
          emit(BookError());
        }else{
          emit(BookError());
        }
      } else {
        BooksResponse todoResultResponse = BooksResponse.fromJson(value?.data);
        List<Results>? todoResultsList = todoResultResponse.results;
        List<Results> todoResults = state.booksResponse?.results ?? [];
        todoResults.addAll(todoResultsList ?? []);
        emit(BookLoaded(booksResponse: BooksResponse(results:todoResults )));
      }
    });
  }
}

part of 'book_bloc.dart';

@immutable
abstract class BookState {
  final BooksResponse? booksResponse;
  final BooksIdResponse? booksIdResponse;

  BookState({this.booksResponse,this.booksIdResponse});
}

class BookInitial extends BookState {}

class BookError extends BookState {}

class BookLoading extends BookState {}

class BookLoaded extends BookState {
  final BooksResponse? booksResponse;
  final BooksIdResponse? booksIdResponse;

  BookLoaded({this.booksResponse,this.booksIdResponse}) : super(booksResponse: booksResponse,booksIdResponse: booksIdResponse);
}

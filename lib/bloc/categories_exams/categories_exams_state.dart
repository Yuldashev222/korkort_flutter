part of 'categories_exams_bloc.dart';

@immutable
abstract class CategoriesExamsState {
  final CategoriesExamsResponse? categoriesExamsResponse;
  final ProfileResponse? profileResponse;

  CategoriesExamsState({this.categoriesExamsResponse,this.profileResponse});
}

class CategoriesExamsInitial extends CategoriesExamsState {}
class CategoriesExamsLoaded extends CategoriesExamsState {
  final CategoriesExamsResponse? categoriesExamsResponse;
  final ProfileResponse? profileResponse;

  CategoriesExamsLoaded({this.categoriesExamsResponse,this.profileResponse}):super(categoriesExamsResponse: categoriesExamsResponse,profileResponse: profileResponse);
}
class CategoriesExamsError extends CategoriesExamsState {}
class CategoriesExamsLoading extends CategoriesExamsState {}

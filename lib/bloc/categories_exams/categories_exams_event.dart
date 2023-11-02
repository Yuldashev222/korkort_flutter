part of 'categories_exams_bloc.dart';

@immutable
abstract class CategoriesExamsEvent extends Emittable {}

class CategoriesExamsGetEvent extends CategoriesExamsEvent {
  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}

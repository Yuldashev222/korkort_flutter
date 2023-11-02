import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:korkort/model/categories_exams_response.dart';
import 'package:korkort/repository/repository.dart';
import 'package:meta/meta.dart';

import '../../model/profile_response.dart';

part 'categories_exams_event.dart';

part 'categories_exams_state.dart';

class CategoriesExamsBloc extends Bloc<CategoriesExamsEvent, CategoriesExamsState> {
  CategoriesExamsBloc() : super(CategoriesExamsInitial()) {
    Repository repository = Repository();
    GetStorage getStorage = GetStorage();
    on<CategoriesExamsGetEvent>((event, emit) async {
      await repository.categoriesExamsGet(token: getStorage.read("token"), language: getStorage.read("language")).then((value) async {
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          emit(CategoriesExamsError());
          if (value?.statusCode == 401) {
            await getStorage.remove("token");
          }
        } else {
          CategoriesExamsResponse categoriesExamsResponse =CategoriesExamsResponse.fromJson(value?.data);
          await repository.profileGet(token: getStorage.read("token"),language: getStorage.read("language")).then((value) async{
            if (value?.statusCode != null && value?.statusCode as int > 299) {
              emit(CategoriesExamsError());
              if (value?.statusCode == 401) {
                await getStorage.remove("token");
              }
            } else{
              emit(CategoriesExamsLoaded(categoriesExamsResponse: categoriesExamsResponse,profileResponse: ProfileResponse.fromJson(value?.data)));
            }
          });
        }
      });
    });
  }
}

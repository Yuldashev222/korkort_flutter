import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:korkort/model/language_response.dart';
import 'package:korkort/repository/repository.dart';
import 'package:meta/meta.dart';

part 'language_event.dart';

part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial()) {
    GetStorage getStorage = GetStorage();
    Repository repository = Repository();
    on<LanguageGetEvent>((event, emit) async {
      await repository.language().then((value) {
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          emit(LanguageError());
        } else {
          List<LanguageResponse> languageResponseList = (value?.data as List).map((e) => LanguageResponse.fromJson(e)).toList();
          emit(LanguageLoaded(languageResponse: languageResponseList));
        }
      });
    });
  }
}

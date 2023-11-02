import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:korkort/model/question_mix_response.dart';
import 'package:korkort/repository/repository.dart';
import 'package:meta/meta.dart';

import '../../model/exam_question_response.dart';

part 'categories_filter_event.dart';

part 'categories_filter_state.dart';

class CategoriesFilterBloc extends Bloc<CategoriesFilterEvent, CategoriesFilterState> {
  CategoriesFilterBloc() : super(CategoriesFilterInitial()) {
    Repository repository = Repository();
    GetStorage getStorage = GetStorage();
    on<CategoriesFilterGetEvent>((event, emit) async {
      emit(CategoriesFilterInitial());
      await repository
          .categoriesFilterGet(token: getStorage.read("token"), language: getStorage.read("language"), questions: event.questions, categoryId: event.categoryId, difficultyLevel: event.difficultyLevel)
          .then((value) async {
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          emit(CategoriesFilterError());
          if (value?.statusCode == 401) {
            await getStorage.remove("token");
          }
        } else {
          emit(CategoriesFilterLoaded(examsQuestionResponse: ExamQuestionResponse.fromJson(value?.data)));
        }
      });
    });
    on<CategoriesMixFilterGetEvent>((event, emit) async {
      emit(CategoriesFilterInitial());
      await repository
          .categoriesMixFilterGet(token: getStorage.read("token"), language:
      getStorage.read("language")
          , questions: event.questions, difficultyLevel: event.difficultyLevel,categoryIds:event.categoryIds )
          .then((value) async {
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          emit(CategoriesFilterError());
          if (value?.statusCode == 401) {
             await getStorage.remove("token");
          }
        } else {
          List<MixQuestionsResponse> mixQuestionsResponseList = (value?.data as List).map((e) => MixQuestionsResponse.fromJson(e)).toList();
          emit(CategoriesMixFilterLoaded(mixQuestionsResponseList: mixQuestionsResponseList));
        }
      });
    });
    on<CategoriesWrongFilterGetEvent>((event, emit) async {
      emit(CategoriesFilterInitial());
      await repository
          .categoriesWrongFilterGet(token: getStorage.read("token"), language: getStorage.read("language"), questions: event.questions, difficultyLevel: event.difficultyLevel,myQuestions:event.myQuestions )
          .then((value) async {
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          emit(CategoriesFilterError());
          if (value?.statusCode == 401) {
            await getStorage.remove("token");
          }
        } else {
          List<MixQuestionsResponse> mixQuestionsResponseList = (value?.data as List).map((e) => MixQuestionsResponse.fromJson(e)).toList();
          emit(CategoriesMixFilterLoaded(mixQuestionsResponseList: mixQuestionsResponseList));
        }
      });
    });
    on<CategoriesSavedFilterGetEvent>((event, emit) async {
      emit(CategoriesFilterInitial());
      await repository
          .categoriesSavedFilterGet(token: getStorage.read("token"), language: getStorage.read("language"), questions: event.questions, difficultyLevel: event.difficultyLevel,myQuestions:event
          .myQuestions )
          .then((value) async {
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          emit(CategoriesFilterError());
          if (value?.statusCode == 401) {
            await getStorage.remove("token");
          }
        } else {
          List<MixQuestionsResponse> mixQuestionsResponseList = (value?.data as List).map((e) => MixQuestionsResponse.fromJson(e)).toList();
          emit(CategoriesMixFilterLoaded(mixQuestionsResponseList: mixQuestionsResponseList));
        }
      });
    });
    on<CategoriesFinalFilterGetEvent>((event, emit) async {
      emit(CategoriesFilterInitial());
      await repository
          .categoriesFinalFilterGet(token: getStorage.read("token"), language: getStorage.read("language"))
          .then((value) async {
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          emit(CategoriesFilterError());
          if (value?.statusCode == 401) {
            await getStorage.remove("token");
          }
        } else {
          List<MixQuestionsResponse> mixQuestionsResponseList = (value?.data as List).map((e) => MixQuestionsResponse.fromJson(e)).toList();
          emit(CategoriesMixFilterLoaded(mixQuestionsResponseList: mixQuestionsResponseList));
        }
      });
    });
    on<CategoriesAnswerPostEvent>((event, emit) async {
      // emit(CategoriesFilterInitial());
      await repository
          .categoriesAnswersPost(token: getStorage.read("token"), language: getStorage.read("language"), wrongQuestions: event.wrongQuestions, correctQuestions: event.correctQuestions,examId: event.examId)
          .then((value) async {
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          // emit(CategoriesFilterError());
          if (value?.statusCode == 401) {
            await getStorage.remove("token");
          }
        } else {
          // List<MixQuestionsResponse> mixQuestionsResponseList = (value?.data as List).map((e) => MixQuestionsResponse.fromJson(e)).toList();
          // emit(CategoriesMixFilterLoaded(mixQuestionsResponseList: mixQuestionsResponseList));
        }
      });
    });
    on<WrongAnswersPostEvent>((event, emit) async {
      // emit(CategoriesFilterInitial());
      await repository
          .wrongAnswersPost(token: getStorage.read("token"), language: getStorage.read("language"), wrongQuestions: event.wrongQuestions, correctQuestions: event.correctQuestions)
          .then((value) async {
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          if (value?.statusCode == 401) {
            await getStorage.remove("token");
          }
        } else {
        }
      });
    });
    on<SavedAnswersPostEvent>((event, emit) async {
      await repository
          .savedAnswersPost(token: getStorage.read("token"), language: getStorage.read("language"), wrongQuestions: event.wrongQuestions, correctQuestions: event.correctQuestions,)
          .then((value) async {
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          // emit(CategoriesFilterError());
          if (value?.statusCode == 401) {
            await getStorage.remove("token");
          }
        } else {
          // List<MixQuestionsResponse> mixQuestionsResponseList = (value?.data as List).map((e) => MixQuestionsResponse.fromJson(e)).toList();
          // emit(CategoriesMixFilterLoaded(mixQuestionsResponseList: mixQuestionsResponseList));
        }
      });
    });
    on<MixAnswersPostEvent>((event, emit) async {
      await repository
          .mixAnswersPost(token: getStorage.read("token"), language: getStorage.read("language"), wrongQuestions: event.wrongQuestions, correctQuestions: event.correctQuestions,)
          .then((value) async {
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          if (value?.statusCode == 401) {
            await getStorage.remove("token");
          }
        } else {
        }
      });
    });
  }
}

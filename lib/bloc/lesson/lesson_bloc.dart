import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:korkort/model/lesson_response.dart';
import 'package:korkort/model/statistics_response.dart';
import 'package:korkort/repository/repository.dart';
import 'package:meta/meta.dart';

part 'lesson_event.dart';
part 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  LessonBloc() : super(LessonInitial()) {
    Repository repository = Repository();
    GetStorage getStorage = GetStorage();
    on<LessonIdEvent>((event, emit) async {
      emit(LessonInitial());
      await repository.lessons(token: getStorage.read("token"), id: event.id,language: getStorage.read("language")).then((value)async {
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          emit(LessonError());
          if(value?.statusCode==401){
            await getStorage.remove("token");
          }
        } else {
          // List<LessonChapterResponse> lessonChapterList=(value?.data as List).map((e) => LessonChapterResponse.fromJson(e)).toList();
          emit(LessonLoaded(lessonResponse: LessonResponse.fromJson(value?.data)));
        }
      });
      // TODO: implement event handler
    });
    on<LessonIdForChaptersEvent>((event, emit) async {
      emit(LessonInitial());
      await repository.lessonsForChapter(token: getStorage.read("token"), id: event.id,language: getStorage.read("language")).then((value)async {
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          emit(LessonError());
          if(value?.statusCode==401){
            await getStorage.remove("token");
          }
        } else {
          // List<LessonChapterResponse> lessonChapterList=(value?.data as List).map((e) => LessonChapterResponse.fromJson(e)).toList();
          emit(LessonLoaded(lessonResponse: LessonResponse.fromJson(value?.data)));
        }
      });
      // TODO: implement event handler
    });
    on<LessonAnswerTrueEvent>((event, emit) async {
      await repository.lessonTestAnswer(token: getStorage.read("token"), lessonId: event.id, answersTrue: event.answerTrue, language: getStorage.read("language")).then((value)async {
        emit(LessonInitial());
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          emit(LessonError());
          if(value?.statusCode==401){
            await getStorage.remove("token");
          }
        }
        else{
          await repository.lessonsForChapter(token: getStorage.read("token"), id: event.chapterId,language: getStorage.read("language")).then((value)async {
            if (value?.statusCode != null && value?.statusCode as int > 299) {
              emit(LessonError());
              if(value?.statusCode==401){
                await getStorage.remove("token");
              }
              if(value?.statusCode==403){
                emit(LessonNextError403());
              }
            } else {
              // emit(LessonNextError403());
              emit(LessonLoaded(lessonResponse: LessonResponse.fromJson(value?.data)));
            }
          });
        }
      });
    });
    on<LessonStatisticsEvent>((event, emit) async {
      await repository.statisticsGet(token: getStorage.read("token"), language: getStorage.read("language")).then((value) async {
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          emit(ChartError());
        } else {
          List<StatisticsResponse> statisticsList = (value?.data as List).map((e) => StatisticsResponse.fromJson(e)).toList();
          emit(ChartLoaded(statisticsList: statisticsList));
          // await repository.lessons(token: getStorage.read("token"), id: event.id,language: getStorage.read("language")).then((value)async {
          //   if (value?.statusCode != null && value?.statusCode as int > 299) {
          //     emit(ChartError());
          //   } else {
          //     List<StatisticsResponse> statisticsList = (value?.data as List).map((e) => StatisticsResponse.fromJson(e)).toList();
          //     emit(ChartLoaded(statisticsList: statisticsList,lessonResponse: LessonResponse.fromJson(value?.data)));
          //   }
          // });
        }
      });
    });
    on<LessonTestEvent>((event, emit) async {
      await repository.testSaved(token: getStorage.read("token"), language: getStorage.read("language"),id: event.testId).then((value) async {
        if (value?.statusCode != null && value?.statusCode as int > 299) {
        } else {
        }
      });
    });
  }
}

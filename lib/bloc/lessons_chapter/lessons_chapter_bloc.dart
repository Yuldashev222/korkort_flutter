import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:korkort/model/profile_response.dart';
import 'package:korkort/repository/repository.dart';
import 'package:meta/meta.dart';

import '../../model/lessonse_chapter_response.dart';

part 'lessons_chapter_event.dart';

part 'lessons_chapter_state.dart';

class LessonsChapterBloc extends Bloc<LessonsChapterEvent, LessonsChapterState> {
  LessonsChapterBloc() : super(LessonsChapterInitial()) {
    Repository repository = Repository();
    GetStorage getStorage = GetStorage();
    on<LessonsChapterIdEvent>((event, emit) async {
      await repository.profileGet(token: getStorage.read("token"),language: getStorage.read("language")).then((value) async{
        if(value?.statusCode==401){
          await getStorage.remove("token");
        }
        ProfileResponse profileResponse=ProfileResponse.fromJson(value?.data);
        await repository.lessonsChapter(token: getStorage.read("token"), language: getStorage.read("language")).then((value) async{
          if (value?.statusCode != null && value?.statusCode as int > 299) {
            emit(LessonsChapterError());
            if(value?.statusCode==401){
              await getStorage.remove("token");
            }
          } else {
            List<LessonChapterResponse> lessonChapterList=(value?.data as List).map((e) => LessonChapterResponse.fromJson(e)).toList();
            int countIsOpen=0;
            for (int i = 0; i < (lessonChapterList.length ); i++){
              if (lessonChapterList[i].isOpen != 3 && lessonChapterList[i].isOpen != 4) {
                  countIsOpen++;
              }
            }
            emit(LessonsChapterLoaded(lessonChapterResponseList: lessonChapterList,profileResponse: profileResponse,isOpenCount: countIsOpen));
          }
        });
      });
    });
  }
}

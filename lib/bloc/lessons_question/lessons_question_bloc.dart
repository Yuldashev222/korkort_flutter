import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:korkort/model/question_response.dart';
import 'package:korkort/repository/repository.dart';
import 'package:meta/meta.dart';

part 'lessons_question_event.dart';

part 'lessons_question_state.dart';

class LessonsQuestionBloc extends Bloc<LessonsQuestionEvent, LessonsQuestionState> {
  LessonsQuestionBloc() : super(LessonsQuestionInitial()) {
    Repository repository = Repository();
    GetStorage getStorage = GetStorage();
    on<LessonsQuestionEvent>((event, emit) async{
      await repository.lessonsQuestion(token: getStorage.read("token"),language: getStorage.read("language"),id: event.id).then((value) async{
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          emit(LessonsQuestionError());
          if(value?.statusCode==401){
            await getStorage.remove("token");
          }
        } else {
          List<QuestionResponse> questionList=(value?.data as List).map((e) => QuestionResponse.fromJson(e)).toList();
          emit(LessonsQuestionLoaded(questionResponseList: questionList));
        }
      });
    });
  }
}

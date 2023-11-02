import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:korkort/model/level_response.dart';
import 'package:korkort/repository/repository.dart';
import 'package:meta/meta.dart';

import '../lessons_chapter/lessons_chapter_bloc.dart';

part 'level_event.dart';
part 'level_state.dart';

class LevelBloc extends Bloc<LevelEvent, LevelState> {
  LevelBloc() : super(LevelInitial()) {
    GetStorage getStorage =GetStorage();
    Repository repository=Repository();
    on<LevelGetEvent>((event, emit) async{
      await repository.levelGet(token: getStorage.read("token"),language: getStorage.read("language")).then((value) async{
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          emit(LevelError());
          if(value?.statusCode==401){
            await getStorage.remove("token");
          }
        }else{
          List<LevelResponse> levelList=(value?.data as List).map((e) =>LevelResponse.fromJson(e)).toList();
          print('LevelBloc.LevelBloc $levelList');
          emit(LevelLoaded(levelList: levelList));
        }
      });
    });
  }
}

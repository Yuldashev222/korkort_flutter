import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:korkort/repository/repository.dart';
import 'package:meta/meta.dart';

part 'swish_event.dart';
part 'swish_state.dart';

class SwishBloc extends Bloc<SwishEvent, SwishState> {
  SwishBloc() : super(SwishInitial()) {
    Repository repository=Repository();
    GetStorage getStorage=GetStorage();
    on<SwishPostEvent>((event, emit) async{
      await repository.swish(token: getStorage.read("token"),language: getStorage.read("language"),number: event.number).then((value)async {
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          emit(SwishError());
          if (value?.statusCode == 401) {
            await getStorage.remove("token");
          }
        } else {
          emit(SwishLoaded());
        }
      });
    });
  }
}

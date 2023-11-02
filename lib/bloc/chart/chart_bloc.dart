import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:korkort/repository/repository.dart';
import 'package:meta/meta.dart';

import '../../model/lesson_response.dart';
import '../../model/statistics_response.dart';

part 'chart_event.dart';
part 'chart_state.dart';

class ChartBloc extends Bloc<ChartEvent, ChartState> {
  ChartBloc() : super(ChartInitial()) {
    Repository repository =Repository();
    GetStorage getStorage=GetStorage();
    on<ChartStatisticsEvent>((event, emit) async {
      await repository.statisticsGet(token: getStorage.read("token"), language: getStorage.read("language")).then((value) async {
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          emit(ChartError());
        } else {
          List<StatisticsResponse> statisticsList = (value?.data as List).map((e) => StatisticsResponse.fromJson(e)).toList();

          emit(ChartStateLoaded(statisticsList: statisticsList));

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
  }
}

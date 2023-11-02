import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:korkort/model/order_response.dart';
import 'package:korkort/repository/repository.dart';
import 'package:meta/meta.dart';

part 'order_check_event.dart';

part 'order_check_state.dart';

class OrderCheckBloc extends Bloc<OrderCheckEvent, OrderCheckState> {
  OrderCheckBloc() : super(OrderCheckInitial()) {
    Repository repository = Repository();
    GetStorage getStorage = GetStorage();
    on<OrderCheckEvent>((event, emit) async {
      await repository.ordersGetId(token: getStorage.read("token"), language: getStorage.read("language"), id: event.id).then((value) async {
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          emit(OrderCheckError());
          if (value?.statusCode == 401) {
            await getStorage.remove("token");
          }
        } else {
          emit(OrderCheckLoaded(results: Results.fromJson(value?.data)));
        }
      });
    });
  }
}

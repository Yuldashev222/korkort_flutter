import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_storage/get_storage.dart';
import 'package:korkort/model/order_response.dart';
import 'package:korkort/model/profile_response.dart';
import 'package:korkort/repository/repository.dart';
import 'package:meta/meta.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  Repository repository = Repository();
  GetStorage getStorage = GetStorage();

  OrderBloc() : super(OrderInitial()) {
    on<OrderGetEvent>(_onLoad);
    on<OrderAddEvent>(_addOrder);
  }

  _onLoad(OrderGetEvent event, Emitter<OrderState> emit) async {
    await repository.ordersGet(token: getStorage.read("token"), language: getStorage.read("language"), page: 1).then((value) async {
      if (value?.statusCode != null && value?.statusCode as int > 299) {
        emit(OrderError());
        if (value?.statusCode == 401) {
          await getStorage.remove("token");
        }
      } else {
        OrderResponse orderResponse = OrderResponse.fromJson(value?.data);
        List<Results>? ordersList = orderResponse.results;
        await repository.profileGet(token: getStorage.read("token"), language: getStorage.read("language")).then((value) async {
          if (value?.statusCode != null && value?.statusCode as int > 299) {
            emit(OrderError());
            if (value?.statusCode == 401) {
              await getStorage.remove("token");
            }
          } else {
            ProfileResponse profileResponse = ProfileResponse.fromJson(value?.data);
            DateTime tempDate = DateFormat("yyyy-MM-dd hh:mm").parse(profileResponse.tariffExpireDate ?? "");
            int days = tempDate.difference(DateTime.now()).inDays;
            emit(OrderLoaded(ordersResponseList: ordersList, day: days > 0 ? days : 0));
          }
        });
      }
    });
  }

  _addOrder(OrderAddEvent event, Emitter<OrderState> emit) async {
    await repository.ordersGet(token: getStorage.read("token"), language: getStorage.read("language"), page: event.page).then((value) async {
      if (value?.statusCode != null && value?.statusCode as int > 299) {
        if (value?.statusCode == 404) {
        }else if (value?.statusCode == 401) {
          await getStorage.remove("token");
          emit(OrderError());
        }else{
          emit(OrderError());
        }
      } else {
        OrderResponse orderResponse = OrderResponse.fromJson(value?.data);
        List<Results>? ordersList = orderResponse.results;
        List<Results> orders = state.ordersResponseList ?? [];
        orders.addAll(ordersList ?? []);
        emit(OrderLoaded(ordersResponseList: orders, day: (state.day ?? 0) > 0 ? state.day : 0));
      }
    });
  }
}

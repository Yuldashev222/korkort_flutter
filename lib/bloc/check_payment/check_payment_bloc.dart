import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:korkort/model/check_order_response.dart';
import 'package:korkort/repository/repository.dart';
import 'package:meta/meta.dart';

part 'check_payment_event.dart';

part 'check_payment_state.dart';

class CheckPaymentBloc extends Bloc<CheckPaymentEvent, CheckPaymentState> {
  CheckPaymentBloc() : super(CheckPaymentInitial()) {
    Repository repository = Repository();
    GetStorage getStorage = GetStorage();
    on<CheckPaymentEvent>((event, emit) async {
      emit(CheckPaymentLoading());
     await repository.checkPayment(token: getStorage.read("token"),id: event.id,language: getStorage.read("language")).then((value)async {
       if (value?.statusCode != null && value?.statusCode as int > 299) {
         emit(CheckPaymentError());
         if(value?.statusCode==401){
           await getStorage.remove("token");
         }
       } else {
         emit(CheckPaymentLoaded(checkOrderResponse: CheckOrderResponse.fromJson(value?.data)));
       }
     });
    });
  }
}

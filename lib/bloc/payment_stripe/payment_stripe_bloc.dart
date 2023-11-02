import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:korkort/repository/repository.dart';
import 'package:meta/meta.dart';

import '../../model/payment_repsonse.dart';

part 'payment_stripe_event.dart';

part 'payment_stripe_state.dart';

class PaymentStripeBloc extends Bloc<PaymentStripeEvent, PaymentStripeState> {
  PaymentStripeBloc() : super(PaymentStripeInitial()) {
    Repository repository = Repository();
    GetStorage getStorage = GetStorage();
    on<PaymentStripeCreateEvent>((event, emit) async {
      String token = await getStorage.read("token");
      emit(PaymentStripeLoading());
      await repository.postCreateStripe(token: token, tariffId: event.tariffId, useBonusMoney: event.useBonusMoney, userCode: event.userCode,language: getStorage.read("language")).then((value)async {
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          // emit(PaymentStripeError());
          if(value?.statusCode==401){
            await getStorage.remove("token");
          }
        } else {
          emit(PaymentStripeLoaded(paymentCreateResponse: PaymentCreateResponse.fromJson(value?.data)));
        }
      });
      // TODO: implement event handler
    });
  }
}

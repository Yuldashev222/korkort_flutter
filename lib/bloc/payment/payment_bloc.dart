import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:korkort/model/tariff_response.dart';
import 'package:korkort/repository/repository.dart';
import 'package:meta/meta.dart';

part 'payment_event.dart';

part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    Repository repository = Repository();
    GetStorage getStorage = GetStorage();
    on<TariffsEvent>((event, emit) async {
      String token = await getStorage.read("token");
      await repository.getTariff(token: token,language: getStorage.read("language")).then((value) async{
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          emit(TariffError(data: value?.data));
          if(value?.statusCode==401){
            await getStorage.remove("token");
          }        } else {
          emit(TariffLoaded(tariffResponse: TariffResponse.fromJson(value?.data)));
        }
      });
    });
    // on<TariffsEvent>((event, emit) async {
    //   await repository.getTariff().then((value) {
    //     print('PaymentBloc.PaymentBloc $value');
    //     if (value?.statusCode != null && value?.statusCode as int > 299) {
    //       emit(TariffError(data: value?.data));
    //     } else {
    //       emit(TariffLoaded(tariffResponse: TariffResponse.fromJson(value?.data)));
    //     }
    //   });
    // });
  }
}

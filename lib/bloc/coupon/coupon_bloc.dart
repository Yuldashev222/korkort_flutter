import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:korkort/repository/repository.dart';
import 'package:meta/meta.dart';

part 'coupon_event.dart';
part 'coupon_state.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  CouponBloc() : super(CouponInitial()) {
    Repository repository = Repository();
    GetStorage getStorage = GetStorage();
    on<CouponCreateEvent>((event, emit) async {
      emit(CouponLoading());
      String token = await getStorage.read("token");
      await repository.postCoupon(token: token, coupon: event.coupon, language: getStorage.read("language")).then((value) async{
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          if (value?.statusCode == 400) {
            emit(CouponError(typeError: 1));
          } else if (value?.statusCode == 403) {
            emit(CouponError(typeError: 2));
          }
          if(value?.statusCode==401){
            await getStorage.remove("token");
          }
        } else {
          emit(CouponLoaded(coupon: value?.data["user_code"]));
        }
      });
      // TODO: implement event handler
    });
  }
}

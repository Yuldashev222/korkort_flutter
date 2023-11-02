part of 'coupon_bloc.dart';

@immutable
abstract class CouponEvent extends Emittable {
  final String? coupon;
CouponEvent({this.coupon});
}

class CouponCreateEvent extends CouponEvent {
 final String? coupon;
 CouponCreateEvent({this.coupon}):super(coupon: coupon);
  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}

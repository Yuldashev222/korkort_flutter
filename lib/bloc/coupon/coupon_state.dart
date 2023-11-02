part of 'coupon_bloc.dart';

@immutable
abstract class CouponState {
  final String? coupon;
final int? typeError;
  CouponState({this.coupon,this.typeError});
}

class CouponInitial extends CouponState {}

class CouponLoaded extends CouponState {
  final String? coupon;

  CouponLoaded({this.coupon}) : super(coupon: coupon);
}

class CouponLoading extends CouponState {}

class CouponError extends CouponState {
  final int? typeError;
  CouponError({this.typeError}):super(typeError: typeError);

}

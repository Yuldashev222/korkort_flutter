part of 'payment_stripe_bloc.dart';

@immutable
abstract class PaymentStripeEvent extends Emittable {
  final int? tariffId;
  final bool? useBonusMoney;
  final String? userCode;

  PaymentStripeEvent({this.useBonusMoney, this.tariffId, this.userCode});
}

class PaymentStripeCreateEvent extends PaymentStripeEvent {
  final int? tariffId;
  final bool? useBonusMoney;
  final String? userCode;

  PaymentStripeCreateEvent({this.userCode, this.tariffId, this.useBonusMoney}) : super(userCode: userCode, tariffId: tariffId, useBonusMoney: useBonusMoney);

  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}

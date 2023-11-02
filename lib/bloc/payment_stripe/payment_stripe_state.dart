part of 'payment_stripe_bloc.dart';

@immutable
abstract class PaymentStripeState {
  final PaymentCreateResponse? paymentCreateResponse;
  PaymentStripeState({this.paymentCreateResponse});
}

class PaymentStripeInitial extends PaymentStripeState {}
class PaymentStripeLoading extends PaymentStripeState {}
class PaymentStripeLoaded extends PaymentStripeState {
  final PaymentCreateResponse? paymentCreateResponse;
  PaymentStripeLoaded({this.paymentCreateResponse}):super(paymentCreateResponse: paymentCreateResponse);
}
class PaymentStripeError extends PaymentStripeState {}

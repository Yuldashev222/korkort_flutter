part of 'check_payment_bloc.dart';

@immutable
abstract class CheckPaymentState {
  final CheckOrderResponse? checkOrderResponse;

  const CheckPaymentState({this.checkOrderResponse});
}

class CheckPaymentInitial extends CheckPaymentState {}

class CheckPaymentLoaded extends CheckPaymentState {
  final CheckOrderResponse? checkOrderResponse;

  const CheckPaymentLoaded({this.checkOrderResponse}) : super(checkOrderResponse: checkOrderResponse);
}

class CheckPaymentLoading extends CheckPaymentState {}

class CheckPaymentError extends CheckPaymentState {}

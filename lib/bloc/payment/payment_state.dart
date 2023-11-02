part of 'payment_bloc.dart';

@immutable
abstract class PaymentState {
  final TariffResponse? tariffResponse;
  final dynamic data;

  const PaymentState({this.tariffResponse, this.data});

  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class TariffLoading extends PaymentState {}

class TariffLoaded extends PaymentState {
  @override
  final TariffResponse? tariffResponse;

  const TariffLoaded({this.tariffResponse}) : super(tariffResponse: tariffResponse);
}

class TariffError extends PaymentState {
  final dynamic data;

  TariffError({this.data}) : super(data: data);
}

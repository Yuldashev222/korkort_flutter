part of 'payment_bloc.dart';

@immutable
abstract class PaymentEvent  extends Emittable{}
class TariffsEvent extends PaymentEvent {

  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}
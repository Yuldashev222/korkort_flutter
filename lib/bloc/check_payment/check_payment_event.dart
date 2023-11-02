part of 'check_payment_bloc.dart';

@immutable
abstract class CheckPaymentEvent extends Emittable {
  final int? id;

  CheckPaymentEvent({this.id});
}

class CheckGetCreateEvent extends CheckPaymentEvent {
  final int? id;

  CheckGetCreateEvent({this.id}) : super(id: id);

  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}

part of 'order_bloc.dart';

@immutable
abstract class OrderEvent extends Emittable{}
class OrderGetEvent extends OrderEvent{
  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}

class OrderAddEvent extends OrderEvent{

  int page;

  OrderAddEvent({required this.page});

  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}
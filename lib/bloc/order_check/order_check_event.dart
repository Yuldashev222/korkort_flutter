part of 'order_check_bloc.dart';

@immutable
abstract class OrderCheckEvent {
  final num? id;

  OrderCheckEvent({this.id});
}

class OrderCheckGetEvent extends OrderCheckEvent {
  final num? id;

  OrderCheckGetEvent({this.id}) : super(id: id);
}

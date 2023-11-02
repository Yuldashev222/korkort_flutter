part of 'order_bloc.dart';

@immutable
abstract class OrderState {
  final List<Results>? ordersResponseList;
final num? day;
  OrderState({this.ordersResponseList,this.day});
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<Results>? ordersResponseList;
  final num? day;

  OrderLoaded({this.ordersResponseList,this.day}) : super(ordersResponseList: ordersResponseList,day: day);
}

class OrderError extends OrderState {}

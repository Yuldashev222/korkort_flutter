part of 'order_check_bloc.dart';

@immutable
abstract class OrderCheckState {
  final Results? results;
  OrderCheckState({this.results});
}

class OrderCheckInitial extends OrderCheckState {}
class OrderCheckLoaded extends OrderCheckState {
  final Results? results;
OrderCheckLoaded({this.results}):super(results: results);
}
class OrderCheckLoading extends OrderCheckState {}
class OrderCheckError extends OrderCheckState {}

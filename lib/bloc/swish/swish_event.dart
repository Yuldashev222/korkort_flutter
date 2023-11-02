part of 'swish_bloc.dart';

@immutable
abstract class SwishEvent extends Emittable {
  int? number;

  SwishEvent({this.number});
}

class SwishPostEvent extends SwishEvent {
  int? number;

  SwishPostEvent({this.number}) : super(number: number);

  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}

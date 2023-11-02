part of 'chart_bloc.dart';

@immutable
abstract class ChartEvent extends Emittable{
  final int? id;
ChartEvent({this.id});
}
class ChartStatisticsEvent extends ChartEvent {
  final int? id;
  ChartStatisticsEvent({this.id}):super(id: id);

  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}
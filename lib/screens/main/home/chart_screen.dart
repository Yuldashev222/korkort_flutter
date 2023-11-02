import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:korkort/style/app_colors.dart';
import 'package:korkort/style/app_style.dart';
import 'package:korkort/widgets/button_login.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../bloc/chart/chart_bloc.dart';
import '../../../bloc/lesson/lesson_bloc.dart';

class ChartScreen extends StatefulWidget {
  final int? id;
final Function? onTapNext;
final Function? onTapReplay;
  const ChartScreen({Key? key, this.id,this.onTapNext,this.onTapReplay}) : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> with TickerProviderStateMixin {


  @override
  void initState() {
    context.read<ChartBloc>().add(ChartStatisticsEvent(id: widget.id));
    super.initState();
  }

  List weekDays = ["Mon", "Tue", "Wed", "Tho", "Fri", "Sat", "Sun"];
  List<int> numbers = [];
// List aaa=[{"Mon",}]
  final List<ChartData>? chartData = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChartBloc, ChartState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ChartStateLoaded) {
          chartData?.clear();
          numbers.clear();
          for (int i = 0; i < (state.statisticsList?.length ?? 0); i++) {
            chartData?.add(ChartData(weekDays[state.statisticsList?[i].weekday ?? 0], (state.statisticsList?[i].count ?? 0)));
            numbers.add(state.statisticsList?[i].count ?? 0);
          }
          return   Container(
              padding: const EdgeInsets.only(top: 16),
              margin: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColors.white),
              child: SfCartesianChart(
                plotAreaBorderWidth: 0,
                primaryXAxis: CategoryAxis(
                  majorGridLines: const MajorGridLines(width: 0),
                  axisLine: const AxisLine(width: 0),
                  majorTickLines: const MajorTickLines(width: 0),
                  minorGridLines: const MinorGridLines(width: 0),
                  minorTickLines: const MinorTickLines(width: 0),
                ),
                primaryYAxis: NumericAxis(
                  maximum: numbers.reduce((value, element) => (value > element ? value : element)).toDouble() + 1,
                  minimum: -1,
                  interval: 1,
                  // visibleMinimum: -1,
                  majorGridLines: const MajorGridLines(width: 1),
                  axisLine: const AxisLine(width: 1),
                  majorTickLines: const MajorTickLines(width: 0),
                  minorTicksPerInterval: 1,
                  // plotOffset: 3
                ),
                series: <ChartSeries<ChartData, String>>[
                  SplineSeries<ChartData, String>(
                    color: AppColors.lineOrange,
                    cardinalSplineTension: 0.1,
                    dataSource: chartData!,
                    width: 5,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                  ),
                ],
              )
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            color: AppColors.green,
          ),
        );
      },
    );
  }
}


class ChartData {
  ChartData(this.x,
      this.y,);

  final String x;
  final int y;
}
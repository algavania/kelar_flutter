import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:kelar_flutter/core/styles.dart';
import 'package:kelar_flutter/features/dashboard/data/sensor/sensor_model.dart';
import 'package:kelar_flutter/features/dashboard/view/bloc/dashboard_bloc.dart';
import 'package:kelar_flutter/injector/injector.dart';
import 'package:kelar_flutter/l10n/l10n.dart';
import 'package:kelar_flutter/utils/extensions.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

@RoutePage()
class StatisticPage extends StatefulWidget {
  const StatisticPage({super.key});

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  final _bloc = Injector.instance<DashboardBloc>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<SensorModel>>(
      stream: _bloc.sensorStream,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text(context.l10n.statistic),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(Styles.defaultPadding),
              child: Column(
                children: [
                  _buildChart(
                    snapshot.data ??
                        List.generate(5, (_) => generateMockSensorModel()),
                    snapshot.data == null,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildChart(List<SensorModel> data, bool isLoading) {
    return Skeletonizer(
      enabled: isLoading,
      child: Column(
        children: [
          SfCartesianChart(
            title: ChartTitle(
              text: context.l10n.humidity,
              textStyle: context.textTheme.titleMedium,
            ),
            primaryXAxis: const DateTimeAxis(),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CartesianSeries<SensorModel, DateTime>>[
              // Renders line chart
              LineSeries<SensorModel, DateTime>(
                name: context.l10n.humidity,
                dataSource: data,
                xValueMapper: (SensorModel data, _) => data.date,
                yValueMapper: (SensorModel data, _) => data.humidity,
              ),
            ],
          ),
          SfCartesianChart(
            title: ChartTitle(
              text: context.l10n.temperature,
              textStyle: context.textTheme.titleMedium,
            ),
            primaryXAxis: const DateTimeAxis(),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CartesianSeries<SensorModel, DateTime>>[
              // Renders line chart
              LineSeries<SensorModel, DateTime>(
                name: context.l10n.temperature,
                color: Colors.green,
                dataSource: data,
                xValueMapper: (SensorModel data, _) => data.date,
                yValueMapper: (SensorModel data, _) => data.temperature,
              ),
            ],
          ),
          SfCartesianChart(
            title: ChartTitle(
              text: context.l10n.co,
              textStyle: context.textTheme.titleMedium,
            ),
            primaryXAxis: const DateTimeAxis(),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CartesianSeries<SensorModel, DateTime>>[
              // Renders line chart
              LineSeries<SensorModel, DateTime>(
                name: context.l10n.co,
                color: Colors.orange,
                dataSource: data,
                xValueMapper: (SensorModel data, _) => data.date,
                yValueMapper: (SensorModel data, _) => data.co,
              ),
            ],
          ),
          SfCartesianChart(
            title: ChartTitle(
              text: context.l10n.co2,
              textStyle: context.textTheme.titleMedium,
            ),
            primaryXAxis: const DateTimeAxis(),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CartesianSeries<SensorModel, DateTime>>[
              // Renders line chart
              LineSeries<SensorModel, DateTime>(
                name: context.l10n.co2,
                color: Colors.purple,
                dataSource: data,
                xValueMapper: (SensorModel data, _) => data.date,
                yValueMapper: (SensorModel data, _) => data.co2,
              ),
            ],
          ),
          SfCartesianChart(
            title: ChartTitle(
              text: context.l10n.pm25,
              textStyle: context.textTheme.titleMedium,
            ),
            primaryXAxis: const DateTimeAxis(),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CartesianSeries<SensorModel, DateTime>>[
              // Renders line chart
              LineSeries<SensorModel, DateTime>(
                name: context.l10n.pm25,
                color: Colors.teal,
                dataSource: data,
                xValueMapper: (SensorModel data, _) => data.date,
                yValueMapper: (SensorModel data, _) => data.pm25,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

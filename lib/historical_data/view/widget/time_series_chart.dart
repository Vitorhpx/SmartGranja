/// Timeseries chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:smart_granja/shared/model/monitoring_data.dart';
import 'package:flutter/material.dart';

class SimpleTimeSeriesChart extends StatelessWidget {
  final List<MonitoringData> monitoringDataList;
  final bool animate;

  SimpleTimeSeriesChart(this.monitoringDataList, {required this.animate});

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      [
        new charts.Series<MonitoringData, DateTime>(
          id: 'Data',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (MonitoringData data, _) => data.sampleTime,
          measureFn: (MonitoringData data, _) => data.temperature,
          data: monitoringDataList,
        )
      ],
      animate: animate,
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }
}
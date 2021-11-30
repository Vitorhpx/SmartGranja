/// Timeseries chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:smart_granja/shared/model/charts_data.dart';
import 'package:flutter/material.dart';

class SimpleTimeSeriesChart extends StatelessWidget {
  final List<ChartsData> data;
  final bool animate;
  final charts.Color color;
  final List<double> minMax;

  SimpleTimeSeriesChart(this.data, {required this.animate, required this.color, required this.minMax});

  @override
  Widget build(BuildContext context) {

    var series =  new charts.Series<ChartsData, DateTime>(
      id: 'Data',
      colorFn: (_, __) => color,
      domainFn: (ChartsData data, _) => data.time,
      measureFn: (ChartsData data, _) => data.value,
      data: data,
    );

    return new charts.TimeSeriesChart(
      [series],
      animate: animate,
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      defaultRenderer: new charts.LineRendererConfig(includePoints: true, radiusPx: 2),
        behaviors: [
          new charts.RangeAnnotation([
            new charts.RangeAnnotationSegment(
                minMax[0], minMax[1], charts.RangeAnnotationAxisType.measure,
                startLabel: 'Mínimo',
                endLabel: 'Máximo',
                color: charts.MaterialPalette.green.shadeDefault.lighter),
            // new charts.RangeAnnotationSegment(
            //     35, 65, charts.RangeAnnotationAxisType.measure,
            //     startLabel: 'Measure 2 Start',
            //     endLabel: 'Measure 2 End',
            //     color: charts.MaterialPalette.gray.shade400),
          ]),
        ]
    );
  }
}
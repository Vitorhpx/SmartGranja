import 'package:flutter/material.dart';
import 'package:smart_granja/historical_data/view_model/historical_data.dart';
import 'package:smart_granja/historical_data/view/widget/time_series_chart.dart';
import 'package:smart_granja/historical_data/view/widget/data_card.dart';
import 'package:smart_granja/shared/model/charts_data.dart';
import 'package:smart_granja/shared/model/monitoring_data.dart';
import 'package:smart_granja/shared/model/monitoring_data_model.dart';
import 'package:provider/provider.dart';
import 'package:smart_granja/shared/view/widgets/blank-spacer.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class HistoricalDataScreen extends StatelessWidget {
  const HistoricalDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProxyProvider<MonitoringDataModel, HistoricalDataViewModel>(
      create: (context) =>
          HistoricalDataViewModel(context.read<MonitoringDataModel>()),
      update: (context, monitoringDataModel, notifier) =>
          HistoricalDataViewModel(context.read<MonitoringDataModel>()),
      child: HistoricalDataWidget(),
    );
  }
}

class HistoricalDataWidget extends StatelessWidget {
  const HistoricalDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.select(
      (HistoricalDataViewModel viewModel) => viewModel,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('SmartGranja'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewModel.getAllMonitoringData(true);
        },
        child: const Icon(Icons.refresh),
        backgroundColor: Colors.blue,
      ),
      body: Center(
          child: Container(
        padding: EdgeInsets.all(16.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            OutlinedButton(
                onPressed: () => {
                      showDateRangePicker(
                        context: context,
                        firstDate: viewModel.dateRange.start
                            .subtract(Duration(days: 365)),
                        lastDate: viewModel.dateRange.end,
                        initialDateRange: viewModel.dateRange,
                      ).then((value) => {
                            if (value != null)
                              {
                                viewModel.setDateRange(DateTimeRange(
                                    start: value.start,
                                    end: value.end.add(Duration(hours: 23, minutes: 59, seconds: 59, microseconds: 59))))
                              }
                          })
                    },
                child: new Text(
                    "${DateFormat('dd-MM-yyyy').format(viewModel.dateRange.start)} até ${DateFormat('dd-MM-yyyy').format(viewModel.dateRange.end)}")),
            FutureBuilder(
                future: viewModel.getAllMonitoringData(false),
                builder: (context,
                    AsyncSnapshot<List<MonitoringData>> allMonitoringData) {
                  if (allMonitoringData.hasData) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Temperatura',
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: SimpleTimeSeriesChart(
                            allMonitoringData.data!
                                .map((e) =>
                                    new ChartsData(e.temperature, e.sampleTime))
                                .toList(),
                            animate: false,
                            color: charts.MaterialPalette.red.shadeDefault,
                            minMax: [18, 28],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Umidade:',
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: SimpleTimeSeriesChart(
                            allMonitoringData.data!
                                .map((e) =>
                                    new ChartsData(e.humidity, e.sampleTime))
                                .toList(),
                            animate: false,
                            color: charts.MaterialPalette.blue.shadeDefault,
                            minMax: [50, 70],
                          ),
                        ),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      BlankSpacer(SpacerSize.large),
                      SizedBox(
                        child: CircularProgressIndicator(),
                        width: 60,
                        height: 60,
                      ),
                    ],
                  );
                }),
            if (viewModel.latestMonitoringData != null)
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Última atualização: ${viewModel.latestMonitoringData!.sampleTime.toString()}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: DataCard(
                            icon: Icons.thermostat,
                            dataValue:
                                viewModel.latestMonitoringData!.temperature,
                            dataUnit: '\u{00B0}C',
                            dataCategory: 'Temperatura',
                          ),
                        ),
                        Expanded(
                          child: DataCard(
                            icon: Icons.cloud_queue_rounded,
                            dataValue: viewModel.latestMonitoringData!.humidity,
                            dataUnit: '%',
                            dataCategory: 'Umidade',
                          ),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ],
                ),
                constraints: BoxConstraints(maxWidth: 320),
              )
          ],
        ),
      )), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

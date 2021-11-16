import 'package:flutter/material.dart';
import 'package:smart_granja/historical_data/view_model/historical_data.dart';
import 'package:smart_granja/historical_data/view/widget/time_series_chart.dart';
import 'package:smart_granja/historical_data/view/widget/data_card.dart';
import 'package:smart_granja/shared/model/monitoring_data.dart';
import 'package:smart_granja/shared/model/monitoring_data_model.dart';
import 'package:provider/provider.dart';
import 'package:smart_granja/shared/view/widgets/blank-spacer.dart';

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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('SmartGranja'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Temperatura:',
                style: const TextStyle(fontSize: 24),
              ),
              Text(
                'Sensor 1:',
                style: const TextStyle(fontSize: 16),
              ),
              FutureBuilder(
                future: viewModel.allMonitoringData,
                builder: (context, AsyncSnapshot<List<MonitoringData>> allMonitoringData) {
                  if (allMonitoringData.hasData) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: SimpleTimeSeriesChart(allMonitoringData.data!, animate: false),
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
                }
              ),
              FutureBuilder(
                future: viewModel.latestMonitoringData,
                builder: (context, AsyncSnapshot<MonitoringData> latestMonitoringData) {
                  if (latestMonitoringData.hasData) {
                    return DataCard(
                      icon: Icons.thermostat,
                      dataValue: latestMonitoringData.data!.temperature,
                      dataUnit: '\u{00B0}C',
                      dataCategory: 'Temperatura',
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
                }
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

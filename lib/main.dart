import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_granja/historical_data/view/screen/historical_data.dart';
import 'package:smart_granja/shared/model/monitoring_data_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MonitoringDataModel()
        )
      ],
      child: MaterialApp(
        title: 'SmartGranja',
        home: HistoricalDataScreen(),
      )
    );
  }
}

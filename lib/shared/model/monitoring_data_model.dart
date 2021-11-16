import 'package:smart_granja/shared/model/monitoring_data.dart';
import 'package:flutter/material.dart';

class MonitoringDataModel extends ChangeNotifier {
  late MonitoringData _latestMonitoringData;
  List<MonitoringData> _allMonitoringData = [];

  Future<List<MonitoringData>> get allMonitoringData async {
    _allMonitoringData = [
      new MonitoringData(new DateTime(2021, 11, 15), 23, 5),
      new MonitoringData(new DateTime(2021, 11, 14), 25, 5),
      new MonitoringData(new DateTime(2021, 11, 13), 30, 5),
      new MonitoringData(new DateTime(2021, 11, 12), 26, 5),
    ];
    return _allMonitoringData;
  }

  Future<MonitoringData> get latestMonitoringData async {
    _latestMonitoringData = new MonitoringData(new DateTime(2021, 11, 15), 23, 5);
    notifyListeners();
    return _latestMonitoringData;
  }
}
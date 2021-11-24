
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_granja/shared/model/monitoring_data.dart';
import 'package:smart_granja/shared/rest/monitoring_data_rest_service.dart';

final MonitoringDataRestService monitoringDataRestService = GetIt.I<MonitoringDataRestService>();

class MonitoringDataModel extends ChangeNotifier {
  List<MonitoringData> _allMonitoringData = [];
  late DateTime _lastFetch;
  static Duration _debounceTime = Duration(seconds: 10);

  Future<List<MonitoringData>> get allMonitoringData async {
    if (_allMonitoringData.isEmpty ||
        DateTime.now().subtract(_debounceTime).isAfter(_lastFetch)) {
      _allMonitoringData =
          await monitoringDataRestService.fetchAllMonitoringData();
      _lastFetch = DateTime.now();
      _allMonitoringData.sort((a, b) => a.sampleTime.compareTo(b.sampleTime));
      notifyListeners();
    }
    return _allMonitoringData;
  }

  MonitoringData? get latestMonitoringData {
    return _allMonitoringData.isNotEmpty ? _allMonitoringData.last : null;
  }
}

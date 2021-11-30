
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_granja/shared/model/monitoring_data.dart';
import 'package:smart_granja/shared/rest/monitoring_data_rest_service.dart';
import 'dart:developer';


final MonitoringDataRestService monitoringDataRestService = GetIt.I<MonitoringDataRestService>();

class MonitoringDataModel extends ChangeNotifier {
  List<MonitoringData> _allMonitoringData = [];
  DateTimeRange dateTimeRange = DateTimeRange(start: DateTime.now().subtract(const Duration(days: 3)), end: DateTime.now());

  Future<List<MonitoringData>> getAllMonitoringData(bool forceRefresh) async {
    if (_allMonitoringData.isEmpty || forceRefresh) {
      _allMonitoringData =
          await monitoringDataRestService.fetchAllMonitoringData(dateTimeRange.start, dateTimeRange.end);
      _allMonitoringData.sort((a, b) => a.sampleTime.compareTo(b.sampleTime));
      log('data:');
      notifyListeners();
    }
    return _allMonitoringData;
  }

  MonitoringData? get latestMonitoringData {
    return _allMonitoringData.isNotEmpty ? _allMonitoringData.last : null;
  }

  set dateRange(DateTimeRange range) {
    dateTimeRange = range;
    getAllMonitoringData(true);
  }
}

import 'package:smart_granja/shared/rest/monitoring_data_rest_service.dart';
import 'package:smart_granja/shared/model/monitoring_data.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'dart:developer';

final MonitoringDataRestService monitoringDataRestService = GetIt.I<MonitoringDataRestService>();

class MonitoringDataModel extends ChangeNotifier {
  late MonitoringData _latestMonitoringData;
  List<MonitoringData> _allMonitoringData = [];

  Future<List<MonitoringData>> get allMonitoringData async {
    log('MonitoringDataModel: getting data');
    _allMonitoringData = await monitoringDataRestService.fetchAllMonitoringData();
    _allMonitoringData.sort((a,b) => a.sampleTime.compareTo(b.sampleTime));
    log('MonitoringDataModel: got data: ' + _allMonitoringData.toString());
    return _allMonitoringData;
  }

  Future<MonitoringData> get latestMonitoringData async {
    _latestMonitoringData = _allMonitoringData.last;
    return _latestMonitoringData;
  }
}

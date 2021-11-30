import 'package:flutter/material.dart';
import 'package:smart_granja/shared/model/monitoring_data.dart';
import 'package:smart_granja/shared/model/monitoring_data_model.dart';

class HistoricalDataViewModel {
  final MonitoringDataModel _monitoringDataModel;

  HistoricalDataViewModel(this._monitoringDataModel);

  Future<List<MonitoringData>> getAllMonitoringData(bool forceRefresh) => _monitoringDataModel.getAllMonitoringData(forceRefresh);

  MonitoringData? get latestMonitoringData => _monitoringDataModel.latestMonitoringData;

  DateTimeRange get dateRange => _monitoringDataModel.dateTimeRange;

  setDateRange(DateTimeRange range) => {
    _monitoringDataModel.dateRange = range
  };

}
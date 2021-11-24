import 'package:smart_granja/shared/model/monitoring_data.dart';
import 'package:smart_granja/shared/model/monitoring_data_model.dart';

class HistoricalDataViewModel {
  final MonitoringDataModel _monitoringDataModel;

  HistoricalDataViewModel(this._monitoringDataModel);

  Future<List<MonitoringData>> get allMonitoringData => _monitoringDataModel.allMonitoringData;

  MonitoringData? get latestMonitoringData => _monitoringDataModel.latestMonitoringData;
}
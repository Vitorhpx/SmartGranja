import 'dart:developer';

class MonitoringData {
  final int deviceId;
  final double temperature;
  final double humidity;
  final DateTime sampleTime;

  MonitoringData(this.deviceId, this.temperature, this.humidity, this.sampleTime);

  static MonitoringData fromJsonTest(Map<String, dynamic> json) {
    log(json.toString());
    return MonitoringData(1, 1, 1, DateTime.now());
  }

  MonitoringData.fromJson(Map<String, dynamic> json)
      : deviceId = int.parse(json['device_id'].toString()),
        sampleTime = DateTime.fromMillisecondsSinceEpoch(int.parse(json['sample_time'].toString())),
        humidity = double.parse(json['device_data']['humidity'].toString()),
        temperature = double.parse(json['device_data']['temperature'].toString());

  @override
  String toString() {
    return sampleTime.toString();
  }
}
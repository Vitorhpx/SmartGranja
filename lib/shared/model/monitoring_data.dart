/// Sample time series data type.
class MonitoringData {
  final DateTime timestamp;
  final double temperature;
  final double humidity;

  MonitoringData(this.timestamp, this.temperature, this.humidity);

  MonitoringData.fromJson(Map<String, dynamic> json)
      : timestamp = json['timestamp'],
        temperature = double.parse(json['temperature'].toString()),
        humidity = double.parse(json['humidity'].toString());
}
import 'dart:convert';
import 'package:smart_granja/shared/model/monitoring_data.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:developer';

class MonitoringDataRestService {
  static const String base_url = 'https://k8qkg6hx0i.execute-api.us-east-2.amazonaws.com/get-sample-data';
  final _client = http.Client();

  Future<List<MonitoringData>> fetchAllMonitoringData() async {
    log('MonitoringDataRestService: fetching monitoring data!');
    int since = DateTime.now().subtract(const Duration(days: 1)).millisecondsSinceEpoch;
    Response response = await _client.get(
      Uri.parse(base_url + '?since=$since'),
      // Uri.parse(base_url),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load monitoring data');
    }
    else {
      return List<MonitoringData>.from(jsonDecode(response.body)['Items'].map<MonitoringData>((json) => MonitoringData.fromJson(json)));
    }
  }
}
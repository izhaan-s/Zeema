import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:eczema_health/data/models/analysis_models.dart';

class AnalysisRepository {
  final String baseUrl = 'http://10.0.2.2:8000'; // change for production

  Future<List<FlareCluster>> getFlareClusters(
      List<Map<String, dynamic>> symptomEntries) async {
    final response = await http.post(
      Uri.parse('$baseUrl/flare/clusters'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(symptomEntries),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((e) => FlareCluster.fromJson(e)).toList();
    } else {
      throw Exception('Failed to get flare clusters');
    }
  }
}

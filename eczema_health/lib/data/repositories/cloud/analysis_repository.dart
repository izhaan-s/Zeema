import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:eczema_health/data/models/analysis_models.dart';

class Tuple<T1, T2, T3, T4> {
  final T1 item1;
  final T2 item2;
  final T3 item3;
  final T4 item4;

  Tuple(this.item1, this.item2, this.item3, this.item4);
}

class AnalysisRepository {
  final String baseUrl =
      'http://10.0.2.2:8000'; // change when I host to render!!!

  // flare/gaps endpoint
  Future<List<FlareCluster>> getFlareClusters(
      List<Map<String, dynamic>> symptomEntries) async {
    final body = jsonEncode(symptomEntries);
    print('Request body: $body'); // Debug print

    final response = await http.post(
      Uri.parse('$baseUrl/flare/clusters'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((e) => FlareCluster.fromJson(e)).toList();
    } else {
      print('Error response: ${response.body}'); // Debug print
      throw Exception('Failed to get flare clusters: ${response.body}');
    }
  }

  // flare/gaps endpoint
  Future<Tuple<List<int>, List<String>, double, double>> getFlareGaps(
      List<Map<String, dynamic>> symptomEntries) async {
    final body = jsonEncode(symptomEntries);

    final response = await http.post(
      Uri.parse('$baseUrl/flare/gaps'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return Tuple(jsonList[0], jsonList[1], jsonList[2], jsonList[3]);
    } else {
      print('Error response: ${response.body}'); // Debug print
      throw Exception('Failed to get flare clusters: ${response.body}');
    }
  }
}

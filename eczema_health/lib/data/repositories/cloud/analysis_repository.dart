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
      'https://fastapiserver-84fe9d858a05.herokuapp.com'; // change when I host to render!!!

  // flare/gaps endpoint
  Future<List<FlareCluster>> getFlareClusters(
      List<Map<String, dynamic>> symptomEntries) async {
    final body = jsonEncode(symptomEntries);

    final response = await http.post(
      Uri.parse('$baseUrl/flare/clusters'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((e) => FlareCluster.fromJson(e)).toList();
    } else {
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
      throw Exception('Failed to get flare clusters: ${response.body}');
    }
  }

  // flare/preflare endpoint
  Future<Map<String, int>> getFlarePreflare(
      List<Map<String, dynamic>> symptomEntries) async {
    final body = jsonEncode(symptomEntries);

    final response = await http.post(
      Uri.parse('$baseUrl/flare/preflare'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = jsonDecode(response.body);
      return jsonMap.map((key, value) => MapEntry(key, value as int));
    } else {
      throw Exception('Failed to get flare preflare: ${response.body}');
    }
  }

  // symptom/matrix endpoint
  Future<List<Map<String, double>>> getSymptomMatrix(
      List<Map<String, dynamic>> symptomEntries) async {
    final body = jsonEncode(symptomEntries);

    final response = await http.post(
      Uri.parse('$baseUrl/symptom/matrix'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((e) => Map<String, double>.from(e)).toList();
    } else {
      throw Exception('Failed to get symptom matrix: ${response.body}');
    }
  }

  // symptom/impact endpoint
  Future<Map<int, double>> getSymptomImpact(
      List<Map<String, dynamic>> symptomEntries, String medication) async {
    final body = jsonEncode({
      'entries': symptomEntries,
      'medication': medication,
    });

    final response = await http.post(
      Uri.parse('$baseUrl/symptom/impact'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = jsonDecode(response.body);
      return jsonMap
          .map((key, value) => MapEntry(int.parse(key), value as double));
    } else {
      throw Exception('Failed to get symptom impact: ${response.body}');
    }
  }
}

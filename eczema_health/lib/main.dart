import 'package:flutter/material.dart';
import 'package:eczema_health/data/local/app_database.dart';
import 'package:eczema_health/data/repositories/local_storage/symptom_repository.dart';
import 'package:eczema_health/data/repositories/cloud/analysis_repository.dart';
import 'package:eczema_health/data/models/analysis_models.dart';

void main() {
  runApp(MaterialApp(home: FlareClusterTestScreen()));
}

class FlareClusterTestScreen extends StatefulWidget {
  @override
  _FlareClusterTestScreenState createState() => _FlareClusterTestScreenState();
}

class _FlareClusterTestScreenState extends State<FlareClusterTestScreen> {
  final repo = AnalysisRepository();
  final db = AppDatabase();
  late final LocalSymptomRepository localRepo;
  List<FlareCluster> clusters = [];
  bool loading = false;
  String? error;

  @override
  void initState() {
    super.initState();
    localRepo = LocalSymptomRepository(db);
    fetchRealSymptomData();
  }

  Future<void> fetchRealSymptomData() async {
    setState(() => loading = true);

    try {
      final entries = await localRepo.getSymptomEntries('1');

      final formatted = entries
          .map((entry) => {
                'id': entry.id,
                'user_id': entry.userId,
                'date': entry.date.toIso8601String(),
                'is_flareup': entry.isFlareup,
                'severity': entry.severity,
                'affected_areas': entry.affectedAreas,
                'symptoms': entry.symptoms ?? [],
                'medications': entry.medications ?? [],
                'notes': entry.notes ?? [],
                'created_at': entry.createdAt.toIso8601String(),
                'updated_at': entry.updatedAt.toIso8601String(),
              })
          .toList();

      // Debug prints
      print('Number of entries: ${formatted.length}');
      if (formatted.isNotEmpty) {
        print('First entry keys: ${formatted.first.keys.toList()}');
        print('First entry date: ${formatted.first['date']}');
      }

      final result = await repo.getFlareClusters(formatted);
      setState(() {
        clusters = result;
        loading = false;
      });
    } catch (e) {
      print('Error details: $e'); // Debug print
      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(title: Text("Flare Cluster Results")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (error != null) {
      return Scaffold(
        appBar: AppBar(title: Text("Flare Cluster Results")),
        body: Center(child: Text("Error: $error")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Flare Cluster Results")),
      body: clusters.isEmpty
          ? Center(child: Text("No clusters found"))
          : ListView.builder(
              itemCount: clusters.length,
              itemBuilder: (context, index) {
                final c = clusters[index];
                return ListTile(
                  title: Text(
                      "From ${c.start.toIso8601String()} to ${c.end.toIso8601String()}"),
                  subtitle: Text("Duration: ${c.duration} days"),
                );
              },
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:eczema_health/data/repositories/cloud/analysis_repository.dart';
import 'package:eczema_health/data/services/analysis_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eczema Health',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AnalysisRepository _repository = AnalysisRepository();
  late final AnalysisService _analysisService;
  List<Map<String, dynamic>> _symptomEntries = [];
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _analysisService = AnalysisService(_repository);
    _fetchSymptomData();
  }

  Future<void> _fetchSymptomData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // Replace 'user123' with actual user ID
      final entries = await _analysisService.getSymptomEntries('user123');
      setState(() {
        _symptomEntries = entries;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eczema Health'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : ListView.builder(
                  itemCount: _symptomEntries.length,
                  itemBuilder: (context, index) {
                    final entry = _symptomEntries[index];
                    return ListTile(
                      title: Text('Date: ${entry['date']}'),
                      subtitle: Text('Severity: ${entry['severity']}'),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchSymptomData,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

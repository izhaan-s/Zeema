import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eczema_health/data/local/app_database.dart';
import 'package:eczema_health/data/repositories/cloud/analysis_repository.dart';
import 'package:eczema_health/data/repositories/local_storage/symptom_repository.dart';
import 'package:eczema_health/features/dashboard/providers/dashboard_provider.dart';
import 'package:eczema_health/features/dashboard/services/dashboard_service.dart';
import 'package:eczema_health/features/dashboard/widgets/flare_cluster_chart.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final DashboardProvider _provider;

  @override
  void initState() {
    super.initState();

    // Set up the dependencies
    final cloudRepo = AnalysisRepository();
    final localRepo = LocalSymptomRepository(AppDatabase());
    final service =
        DashboardService(cloudRepo: cloudRepo, localRepo: localRepo);

    // Create the provider
    _provider = DashboardProvider(service: service);

    // Load initial data
    _fetchData();
  }

  Future<void> _fetchData() async {
    // Use a fixed user ID for now - this would come from authentication in a real app
    await _provider.loadDashboardData('1');
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () =>
                  _provider.loadDashboardData('1', forceRefresh: true),
            ),
          ],
        ),
        body: Consumer<DashboardProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.error != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${provider.error}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _fetchData,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            final dashboardData = provider.dashboardData;
            if (dashboardData == null) {
              return const Center(child: Text('No data available'));
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 350,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: FlareClusterChart(
                      severityData: dashboardData.severityData,
                      flares: dashboardData.flares,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eczema_health/data/local/app_database.dart';
import 'package:eczema_health/data/repositories/cloud/analysis_repository.dart';
import 'package:eczema_health/data/repositories/local_storage/symptom_repository.dart';
import 'package:eczema_health/features/dashboard/providers/dashboard_provider.dart';
import 'package:eczema_health/features/dashboard/services/dashboard_service.dart';
import 'package:eczema_health/features/dashboard/widgets/flare_cluster_chart.dart';
import 'package:eczema_health/features/dashboard/widgets/symptom_matrix_chart.dart';

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
          title: const Text(
            'Dashboard',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
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

            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 250,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: FlareClusterChart(
                        severityData: dashboardData.severityData,
                        flares: dashboardData.flares,
                      ),
                    ),
                    Container(
                      height: 250,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: SymptomMatrixChart(
                        matrixData: dashboardData.symptomMatrix,
                      ),
                    ),
                    _buildQuickActions(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildActionListItem(
            icon: Icons.calendar_today,
            backgroundColor: const Color(0xFFE1F5FE),
            iconColor: const Color(0xFF039BE5),
            title: 'Flare Cycle Analysis',
            subtitle: 'Learn more',
            onTap: () {
              // Navigate to flare analysis
            },
          ),
          const Divider(height: 1, indent: 70),
          _buildActionListItem(
            icon: Icons.grid_4x4,
            backgroundColor: const Color(0xFFFFF8E1),
            iconColor: const Color(0xFFFFB300),
            title: 'Symptom Heatmap',
            subtitle: 'Track patterns',
            onTap: () {
              // Navigate to symptom heatmap
            },
          ),
          const Divider(height: 1, indent: 70),
          _buildActionListItem(
            icon: Icons.medication_outlined,
            backgroundColor: const Color(0xFFE0F2F1),
            iconColor: const Color(0xFF00897B),
            title: 'Medication Tracking',
            subtitle: 'Manage treatments',
            onTap: () {
              // Navigate to medication tracking
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionListItem({
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2E3E5C),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}

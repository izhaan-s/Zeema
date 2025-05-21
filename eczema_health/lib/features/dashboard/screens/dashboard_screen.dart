import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eczema_health/data/local/app_database.dart';
import 'package:eczema_health/data/repositories/cloud/analysis_repository.dart';
import 'package:eczema_health/data/repositories/local_storage/symptom_repository.dart';
import 'package:eczema_health/data/repositories/local_storage/dashboard_cache_repository.dart';
import 'package:eczema_health/features/dashboard/providers/dashboard_provider.dart';
import 'package:eczema_health/features/dashboard/services/dashboard_service.dart';
import 'package:eczema_health/features/dashboard/widgets/flare_cluster_chart.dart';
import 'package:eczema_health/features/dashboard/widgets/symptom_matrix_chart.dart';
import 'package:eczema_health/features/symptom_tracking/widgets/flare_up_card.dart';
import 'package:eczema_health/data/models/analysis_models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final DashboardProvider _provider;
  int _currentChartIndex = 0;
  final PageController _chartPageController = PageController();
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initDependencies();
  }

  @override
  void dispose() {
    _chartPageController.dispose();
    super.dispose();
  }

  Future<void> _initDependencies() async {
    // Set up the dependencies
    final cloudRepo = AnalysisRepository();
    final db = await DBProvider.instance.database;
    final localRepo = LocalSymptomRepository(db);
    final cacheRepo = DashboardCacheRepository(db);
    final service = DashboardService(
      cloudRepo: cloudRepo,
      localRepo: localRepo,
      cacheRepo: cacheRepo,
    );

    // Create the provider
    _provider = DashboardProvider(service: service);

    // Load initial data
    await _fetchData();
    setState(() {
      _isInitialized = true;
    });
  }

  Future<void> _fetchData() async {
    // Use a fixed user ID for now - this would come from authentication in a real app
    await _provider
        .loadDashboardData(Supabase.instance.client.auth.currentUser?.id ?? "");
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return ChangeNotifierProvider.value(
      value: _provider,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Dashboard',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
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
                    _buildFlareUpStatus(dashboardData.flares),
                    _buildChartCarousel(dashboardData),
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

  Widget _buildFlareUpStatus(List<FlareCluster> flares) {
    // If no flare data is available
    if (flares.isEmpty) {
      return FlareUpCard();
    }

    // Sort flares by start date (newest first)
    final sortedFlares = List<FlareCluster>.from(flares)
      ..sort((a, b) => b.start.compareTo(a.start));

    // Get the most recent flare
    final mostRecentFlare = sortedFlares.first;

    // Check if this is an active flare (end date is today or in the future)
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final isActive = mostRecentFlare.end.isAfter(today) ||
        mostRecentFlare.end.isAtSameMomentAs(today);

    if (isActive) {
      return FlareUpCard(
        currentFlare: mostRecentFlare,
        isActiveFlare: true,
      );
    } else {
      return FlareUpCard(
        lastFlare: mostRecentFlare,
        isActiveFlare: false,
      );
    }
  }

  Widget _buildChartCarousel(dashboardData) {
    return Column(
      children: [
        Container(
          height: 270,
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
          child: PageView(
            controller: _chartPageController,
            onPageChanged: (index) {
              setState(() {
                _currentChartIndex = index;
              });
            },
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Symptom Severity & Flares',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E3E5C),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: dashboardData.severityData.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.bar_chart,
                                      size: 50, color: Colors.grey[300]),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No symptom data yet',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Add your first symptom entry to see your data',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[500],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )
                          : FlareClusterChart(
                              severityData: dashboardData.severityData,
                              flares: dashboardData.flares,
                            ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Symptom Correlation Matrix',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E3E5C),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: dashboardData.symptomMatrix.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.bubble_chart,
                                      size: 50, color: Colors.grey[300]),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No correlation data yet',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Add multiple symptom entries to see correlations',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[500],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )
                          : SymptomMatrixChart(
                              matrixData: (dashboardData.symptomMatrix as List)
                                  .map((e) => Map<String, double>.from(e))
                                  .toList(),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIndicator(0),
            const SizedBox(width: 8),
            _buildIndicator(1),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildIndicator(int index) {
    return GestureDetector(
      onTap: () {
        _chartPageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: _currentChartIndex == index
              ? Theme.of(context).primaryColor
              : Colors.grey.withOpacity(0.3),
          shape: BoxShape.circle,
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
          const Divider(height: 1, indent: 70),
          _buildActionListItem(
            icon: Icons.notifications_active,
            backgroundColor: const Color(0xFFF3E5F5),
            iconColor: const Color(0xFF9C27B0),
            title: 'Notification Settings',
            subtitle: 'Manage alerts',
            onTap: () {
              // Navigate to notification settings
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

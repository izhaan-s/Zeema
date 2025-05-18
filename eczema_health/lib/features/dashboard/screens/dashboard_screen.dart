import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eczema_health/data/local/app_database.dart';
import 'package:eczema_health/data/repositories/cloud/analysis_repository.dart';
import 'package:eczema_health/data/repositories/local_storage/symptom_repository.dart';
import 'package:eczema_health/features/dashboard/providers/dashboard_provider.dart';
import 'package:eczema_health/features/dashboard/services/dashboard_service.dart';
import 'package:eczema_health/features/dashboard/widgets/flare_cluster_chart.dart';
import 'package:eczema_health/features/dashboard/widgets/symptom_matrix_chart.dart';
import 'package:eczema_health/data/models/analysis_models.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final DashboardProvider _provider;
  int _currentChartIndex = 0;
  final PageController _chartPageController = PageController();
  bool _showGridView = false; // Toggle between list and grid view

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

  @override
  void dispose() {
    _chartPageController.dispose();
    super.dispose();
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
              icon: Icon(_showGridView ? Icons.view_list : Icons.grid_view),
              onPressed: () {
                setState(() {
                  _showGridView = !_showGridView;
                });
              },
            ),
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
                    _buildChartCarousel(dashboardData),
                    _buildInsightsSummary(dashboardData),
                    _showGridView
                        ? _buildQuickActionsGrid()
                        : _buildQuickActions(),
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
    // Get quick actions from provider
    final quickActions = _provider.getQuickActions(context);

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
          // Display all actions from provider
          for (int i = 0; i < quickActions.length; i++)
            Column(
              children: [
                if (i > 0) const Divider(height: 1, indent: 70),
                _buildActionListItem(
                  icon: quickActions[i].icon,
                  backgroundColor: quickActions[i].backgroundColor,
                  iconColor: quickActions[i].iconColor,
                  title: quickActions[i].title,
                  subtitle: quickActions[i].subtitle,
                  onTap: quickActions[i].onTap,
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsGrid() {
    // Get quick actions from provider
    final quickActions = _provider.getQuickActions(context);

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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: quickActions.length,
          itemBuilder: (context, index) {
            final action = quickActions[index];
            return _buildGridItem(
              icon: action.icon,
              backgroundColor: action.backgroundColor,
              iconColor: action.iconColor,
              title: action.title,
              onTap: action.onTap,
            );
          },
        ),
      ),
    );
  }

  Widget _buildGridItem({
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 30,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2E3E5C),
              ),
            ),
          ],
        ),
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
                      child: FlareClusterChart(
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
                      child: SymptomMatrixChart(
                        matrixData: dashboardData.symptomMatrix,
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

  Widget _buildInsightsSummary(dashboardData) {
    // Extract data for insights
    final flares = dashboardData.flares;
    final severityData = dashboardData.severityData;

    // Calculate days since last flare
    final daysSinceLastFlare = flares.isNotEmpty
        ? DateTime.now().difference(flares.last.start).inDays
        : 0;

    // Calculate current severity
    final currentSeverity =
        severityData.isNotEmpty ? severityData.last.severity : 0;

    // Calculate severity trend (last 7 days or less)
    String trend = 'Stable';
    Color trendColor = Colors.blue;
    IconData trendIcon = Icons.trending_flat;

    if (severityData.length > 1) {
      // Get data points from last 7 days
      final now = DateTime.now();
      final lastWeekData = severityData.where((point) {
        return now.difference(point.date).inDays <= 7;
      }).toList();

      if (lastWeekData.length > 1) {
        // Sort by date with explicit typing
        lastWeekData.sort(
            (SeverityPoint a, SeverityPoint b) => a.date.compareTo(b.date));

        // Calculate trend
        final oldestSeverity = lastWeekData.first.severity;
        final newestSeverity = lastWeekData.last.severity;
        final difference = newestSeverity - oldestSeverity;

        if (difference < 0) {
          trend = 'Improving';
          trendColor = Colors.green;
          trendIcon = Icons.trending_down;
        } else if (difference > 0) {
          trend = 'Worsening';
          trendColor = Colors.red;
          trendIcon = Icons.trending_up;
        }
      }
    }

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                const Icon(Icons.insights, size: 20, color: Color(0xFF1A3A6D)),
                const SizedBox(width: 8),
                const Text(
                  'Insights Summary',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A3A6D),
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: trendColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(trendIcon, size: 16, color: trendColor),
                      const SizedBox(width: 4),
                      Text(
                        trend,
                        style: TextStyle(
                          fontSize: 12,
                          color: trendColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInsightItem(
                  value: '$daysSinceLastFlare',
                  label: 'Days since\nlast flare',
                  icon: Icons.calendar_today,
                ),
                _buildInsightItem(
                  value: '$currentSeverity',
                  label: 'Current\nseverity',
                  icon: Icons.show_chart,
                ),
                _buildInsightItem(
                  value: '${flares.length}',
                  label: 'Flares\nrecorded',
                  icon: Icons.event_busy,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem({
    required String value,
    required String label,
    required IconData icon,
  }) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF4A8AF4), size: 22),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A3A6D),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

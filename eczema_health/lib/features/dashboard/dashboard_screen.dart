import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eczema_health/data/app_database.dart';
import 'package:eczema_health/data/repositories/cloud/analysis_repository.dart';
import 'package:eczema_health/data/repositories/local/symptom_repository.dart';
import 'package:eczema_health/data/repositories/local/dashboard_cache_repository.dart';
import 'package:eczema_health/features/dashboard/dashboard_provider.dart';
import 'package:eczema_health/features/dashboard/dashboard_service.dart';
import 'package:eczema_health/features/dashboard/widgets/flare_cluster_chart.dart';
import 'package:eczema_health/features/dashboard/widgets/symptom_matrix_chart.dart';
import 'package:eczema_health/features/symptom_tracking/widgets/flare_up_card.dart';
import 'package:eczema_health/data/models/analysis_models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../profile/screens/settings_screen.dart';
import '../auth/tutorial_manager.dart';
import '../symptom_tracking/symptom_tracking_screen.dart';
import '../photo_tracking/photo_gallery_screen.dart';
import '../reminders/reminders_screen.dart';
import '../lifestyle_tracking/screens/lifestyle_log_screen.dart';
import '../../main.dart';
import '../profile/screens/profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String userId = Supabase.instance.client.auth.currentUser?.id ?? "";
  late final DashboardProvider _provider;
  int _currentChartIndex = 0;
  final PageController _chartPageController = PageController();
  bool _isInitialized = false;
  String? _userAvatarUrl;
  String? _userDisplayName;

  @override
  void initState() {
    super.initState();
    _initDependencies();
    _loadUserProfile();
  }

  @override
  void dispose() {
    _chartPageController.dispose();
    super.dispose();
  }

  Future<void> _initDependencies() async {
    // Set up the dependencies using Provider injection
    final cloudRepo = AnalysisRepository();
    final localRepo =
        Provider.of<LocalSymptomRepository>(context, listen: false);
    final cacheRepo =
        Provider.of<DashboardCacheRepository>(context, listen: false);
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

  Future<void> _fetchData({bool forceRefresh = false}) async {
    // Use a fixed user ID for now - this would come from authentication in a real app
    await _provider.loadDashboardData(
      Supabase.instance.client.auth.currentUser?.id ?? "",
      forceRefresh: forceRefresh,
    );
  }

  Future<void> _loadUserProfile() async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId != null) {
        final response = await Supabase.instance.client
            .from('profiles')
            .select('avatar_url, first_name, last_name, display_name')
            .eq('id', userId)
            .single();

        if (mounted) {
          setState(() {
            _userAvatarUrl = response['avatar_url'];
            final firstName = response['first_name'];
            final lastName = response['last_name'];
            final displayName = response['display_name'];

            if (displayName != null && displayName.isNotEmpty) {
              _userDisplayName = displayName;
            } else if (firstName != null && firstName.isNotEmpty) {
              _userDisplayName = firstName;
              if (lastName != null && lastName.isNotEmpty) {
                _userDisplayName = '$firstName $lastName';
              }
            }
          });
        }
      }
    } catch (e) {
      print('Error loading user profile: $e');
    }
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
            // Profile Avatar Button
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ProfileScreen()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor:
                        Theme.of(context).primaryColor.withOpacity(0.1),
                    backgroundImage: _userAvatarUrl != null
                        ? NetworkImage(_userAvatarUrl!)
                        : null,
                    child: _userAvatarUrl == null
                        ? Text(
                            _userDisplayName?.substring(0, 1).toUpperCase() ??
                                Supabase.instance.client.auth.currentUser?.email
                                    ?.substring(0, 1)
                                    .toUpperCase() ??
                                'U',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        : null,
                  ),
                ),
              ),
            ),
            // Debug button for tutorial (remove in production)
            IconButton(
              icon: const Icon(Icons.help_outline),
              onPressed: () async {
                await TutorialManager.restartTutorial(context);
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                );
              },
            ),
          ],
        ),
        body: Consumer<DashboardProvider>(
          builder: (context, provider, child) {
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
                    _buildChartCarousel(dashboardData, provider),
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

  Widget _buildChartCarousel(dashboardData, DashboardProvider provider) {
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
              // First page - Flare Cluster Chart
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Flare Clusters',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        if (provider.isLoading)
                          const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: dashboardData.severityData.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.show_chart,
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
                                    'Add symptom entries to see trends',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : FlareClusterChart(
                              severityData: dashboardData.severityData,
                              flares: dashboardData
                                  .flares, // Can be empty, chart still renders
                            ),
                    ),
                  ],
                ),
              ),
              // Second page - Symptom Matrix Chart
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Symptom Correlations',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        if (provider.isLoading)
                          const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                      ],
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
            icon: Icons.edit_note,
            backgroundColor: const Color(0xFFE3F2FD),
            iconColor: const Color(0xFF1976D2),
            title: 'Log Symptoms',
            subtitle: 'Track today\'s symptoms',
            onTap: () {
              // Navigate to Symptoms tab (index 2)
              mainScreenKey.currentState?.navigateToTab(2);
            },
          ),
          const Divider(height: 1, indent: 70),
          _buildActionListItem(
            icon: Icons.camera_alt,
            backgroundColor: const Color(0xFFF3E5F5),
            iconColor: const Color(0xFF7B1FA2),
            title: 'Photo Gallery',
            subtitle: 'Visual progress tracking',
            onTap: () {
              // Navigate to Photos tab (index 1)
              mainScreenKey.currentState?.navigateToTab(1);
            },
          ),
          const Divider(height: 1, indent: 70),
          _buildActionListItem(
            icon: Icons.notifications_active,
            backgroundColor: const Color(0xFFE8F5E8),
            iconColor: const Color(0xFF2E7D32),
            title: 'Reminders',
            subtitle: 'Medication schedules',
            onTap: () {
              // Navigate to Reminders tab (index 4)
              mainScreenKey.currentState?.navigateToTab(4);
            },
          ),
          const Divider(height: 1, indent: 70),
          _buildActionListItem(
            icon: Icons.fitness_center,
            backgroundColor: const Color(0xFFFFF3E0),
            iconColor: const Color(0xFFEF6C00),
            title: 'Lifestyle Tracking',
            subtitle: 'Diet, sleep & triggers',
            onTap: () {
              // Navigate to Lifestyle tab (index 3)
              mainScreenKey.currentState?.navigateToTab(3);
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

import 'package:flutter/foundation.dart';
import 'package:eczema_health/features/dashboard/models/dashboard_data.dart';
import 'package:eczema_health/features/dashboard/services/dashboard_service.dart';
import 'package:flutter/material.dart';

/// Quick action item for the dashboard
class QuickActionItem {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback onTap;

  QuickActionItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.onTap,
  });
}

/// Provider to manage dashboard state
class DashboardProvider extends ChangeNotifier {
  final DashboardService _service;

  DashboardData? _dashboardData;
  bool _isLoading = false;
  String? _error;

  DashboardProvider({
    required DashboardService service,
  }) : _service = service;

  // Getters
  DashboardData? get dashboardData => _dashboardData;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Load dashboard data
  Future<void> loadDashboardData(String userId,
      {bool forceRefresh = false}) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _dashboardData =
          await _service.getDashboardData(userId, forceRefresh: forceRefresh);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  // Call this when a new symptom is added
  void symptomAdded() {
    _service.invalidateCache();
  }

  // Get all quick action items dynamically
  List<QuickActionItem> getQuickActions(BuildContext context) {
    // These should ideally be based on user preferences or most used features
    // For now, we'll return a fixed set, but this could be expanded to be more dynamic
    return [
      QuickActionItem(
        id: 'photo_gallery',
        title: 'Photo Gallery',
        subtitle: 'Track visually',
        icon: Icons.photo_library,
        backgroundColor: const Color(0xFFE1F5FE),
        iconColor: const Color(0xFF039BE5),
        onTap: () {
          // Navigate to photo gallery
          Navigator.of(context).pushNamed('/photo_gallery');
        },
      ),
      QuickActionItem(
        id: 'log_symptom',
        title: 'Log Symptom',
        subtitle: 'Record flares',
        icon: Icons.assignment,
        backgroundColor: const Color(0xFFFFF8E1),
        iconColor: const Color(0xFFFFB300),
        onTap: () {
          // Navigate to symptom logging
          Navigator.of(context).pushNamed('/log_symptom');
        },
      ),
      QuickActionItem(
        id: 'medications',
        title: 'Medications',
        subtitle: 'Track treatments',
        icon: Icons.medication_outlined,
        backgroundColor: const Color(0xFFE0F2F1),
        iconColor: const Color(0xFF00897B),
        onTap: () {
          // Navigate to medications
          Navigator.of(context).pushNamed('/medications');
        },
      ),
      QuickActionItem(
        id: 'reminders',
        title: 'Reminders',
        subtitle: 'Set alerts',
        icon: Icons.alarm,
        backgroundColor: const Color(0xFFF3E5F5),
        iconColor: const Color(0xFF9C27B0),
        onTap: () {
          // Navigate to reminders
          Navigator.of(context).pushNamed('/reminders');
        },
      ),
      QuickActionItem(
        id: 'analytics',
        title: 'Analytics',
        subtitle: 'View insights',
        icon: Icons.analytics,
        backgroundColor: const Color(0xFFE8F5E9),
        iconColor: const Color(0xFF43A047),
        onTap: () {
          // Navigate to analytics
          Navigator.of(context).pushNamed('/analytics');
        },
      ),
    ];
  }
}

import 'package:flutter/foundation.dart';
import 'package:eczema_health/features/dashboard/models/dashboard_data.dart';
import 'package:eczema_health/features/dashboard/services/dashboard_service.dart';

/// Provider to manage dashboard state
class DashboardProvider extends ChangeNotifier {
  final DashboardService _service;
  String? _currentUserId;

  DashboardData? _dashboardData;
  bool _isLoading = false;
  bool _isLoadingFlares = false;
  bool _isLoadingMatrix = false;
  String? _error;

  DashboardProvider({
    required DashboardService service,
  }) : _service = service;

  // Getters
  DashboardData? get dashboardData => _dashboardData;
  bool get isLoading => _isLoading;
  bool get isLoadingFlares => _isLoadingFlares;
  bool get isLoadingMatrix => _isLoadingMatrix;
  String? get error => _error;

  // Load dashboard data
  Future<void> loadDashboardData(String userId,
      {bool forceRefresh = false}) async {
    try {
      _isLoading = true;
      _error = null;
      _currentUserId = userId;
      notifyListeners();

      // First try to get cached data
      final cachedData = await _service.getCachedData(userId);
      if (cachedData != null) {
        _dashboardData = cachedData;
        notifyListeners();
      }

      // Then fetch fresh data with timeout
      try {
        _dashboardData = await _service
            .getDashboardData(userId, forceRefresh: forceRefresh)
            .timeout(const Duration(seconds: 5), onTimeout: () {
          // If timeout occurs, keep using cached data
          return _dashboardData ??
              DashboardData(
                severityData: [],
                flares: [],
                symptomMatrix: [],
                lastUpdated: DateTime.now(),
              );
        });
      } catch (e) {
        // If error occurs, keep using cached data
        if (_dashboardData == null) {
          _dashboardData = DashboardData(
            severityData: [],
            flares: [],
            symptomMatrix: [],
            lastUpdated: DateTime.now(),
          );
        }
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  // Call this when a new symptom is added
  Future<void> symptomAdded() async {
    if (_currentUserId != null) {
      await _service.invalidateCache(_currentUserId!);
    }
  }
}

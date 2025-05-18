import 'package:flutter/foundation.dart';
import 'package:eczema_health/features/dashboard/models/dashboard_data.dart';
import 'package:eczema_health/features/dashboard/services/dashboard_service.dart';

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
}

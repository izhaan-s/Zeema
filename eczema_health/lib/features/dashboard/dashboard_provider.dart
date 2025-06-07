import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:eczema_health/features/dashboard/dashboard_data.dart';
import 'package:eczema_health/features/dashboard/dashboard_service.dart';

/// Provider to manage dashboard state
class DashboardProvider extends ChangeNotifier {
  final DashboardService _service;
  String? _currentUserId;

  DashboardData? _dashboardData;
  bool _isLoading = false;
  String? _error;

  /// Network timeout for the dashboard call. Increase this if your backend is far away.
  static const Duration _networkTimeout = Duration(seconds: 15);

  DashboardProvider({required DashboardService service}) : _service = service;

  // Getters
  DashboardData? get dashboardData => _dashboardData;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Loads dashboard data for [userId].
  ///
  /// * Shows cached data immediately if it exists.
  /// * Attempts to fetch fresh data and **does not** overwrite an existing
  ///   dashboard snapshot if the request times out or fails.
  Future<void> loadDashboardData(
    String userId, {
    bool forceRefresh = false,
  }) async {
    _currentUserId = userId;
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // 1. Serve cached data first (if any)

      final cached = await _service.getCachedData(userId);
      print('cached: $cached');
      if (cached != null) {
        _dashboardData = cached;
        notifyListeners();
      }

      // 2. Fetch fresh data with an extended timeout. If the call takes too
      //    long, we keep whatever data we already have and surface an error
      //    message instead of wiping the UI.
      final fresh = await _service
          .getDashboardData(userId, forceRefresh: forceRefresh)
          .timeout(
        _networkTimeout,
        onTimeout: () {
          throw TimeoutException(
            'Dashboard request exceeded ${_networkTimeout.inSeconds}s',
          );
        },
      );

      _dashboardData = fresh;
    } catch (e) {
      // Preserve the last good data; just store the error so the UI can react.
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Call this when a new symptom is added so the next fetch is guaranteed fresh.
  Future<void> symptomAdded() async {
    if (_currentUserId != null) {
      await _service.invalidateCache(_currentUserId!);
    }
  }
}

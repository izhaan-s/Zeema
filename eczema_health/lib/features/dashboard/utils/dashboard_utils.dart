import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eczema_health/features/dashboard/providers/dashboard_provider.dart';

/// Utility methods for dashboard functionality
class DashboardUtils {
  /// Call this when a new symptom is added to invalidate the dashboard cache
  /// Usage: DashboardUtils.notifySymptomAdded(context);
  static void notifySymptomAdded(BuildContext context) {
    // Find the dashboard provider and notify it of the new symptom
    final dashboardProvider = Provider.of<DashboardProvider>(
      context,
      listen: false,
    );
    dashboardProvider.symptomAdded();
  }
}

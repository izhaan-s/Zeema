import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:eczema_health/data/models/analysis_models.dart';

class FlareClusterChart extends StatelessWidget {
  final List<SeverityPoint> severityData;
  final List<FlareCluster> flares;

  const FlareClusterChart({
    super.key,
    required this.severityData,
    required this.flares,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

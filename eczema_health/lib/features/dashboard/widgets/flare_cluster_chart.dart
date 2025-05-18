import 'package:eczema_health/data/models/analysis_models.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    if (severityData.isEmpty) {
      return const Center(child: Text('No data available'));
    }

    // Sort data by date to ensure proper ordering
    final sortedData = List<SeverityPoint>.from(severityData)
      ..sort((a, b) => a.date.compareTo(b.date));

    // Create spots for line chart
    final spots = sortedData.map((e) {
      return FlSpot(
        e.date.millisecondsSinceEpoch.toDouble(),
        e.severity.toDouble(),
      );
    }).toList();

    // Find min and max dates for x-axis range
    final firstDate = sortedData.first.date;
    final lastDate = sortedData.last.date;

    // Calculate min and max x values with padding for better visualization
    final totalDuration = lastDate.difference(firstDate).inMilliseconds;
    final padding = totalDuration * 0.05; // 5% padding on each side

    final minX = (firstDate.millisecondsSinceEpoch - padding).toDouble();
    final maxX = (lastDate.millisecondsSinceEpoch + padding).toDouble();

    // Calculate date difference for proper spacing
    final daysDifference = lastDate.difference(firstDate).inDays;

    // Simpler interval calculation to avoid issues
    final double xInterval = (maxX - minX) / 4; // Just divide into 4 parts

    // Create flare rectangles
    final flareRects = flares.map((flare) {
      return LineChartBarData(
        spots: [
          FlSpot(flare.start.millisecondsSinceEpoch.toDouble(), 0),
          FlSpot(flare.start.millisecondsSinceEpoch.toDouble(), 5.5),
          FlSpot(flare.end.millisecondsSinceEpoch.toDouble(), 5.5),
          FlSpot(flare.end.millisecondsSinceEpoch.toDouble(), 0),
          FlSpot(flare.start.millisecondsSinceEpoch.toDouble(), 0),
        ],
        isCurved: false,
        color: Colors.red.withOpacity(0.4),
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
          show: true,
          color: Colors.red.withOpacity(0.1),
        ),
      );
    }).toList();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Severity Trends',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withOpacity(0.2),
                        strokeWidth: 1,
                      );
                    },
                    getDrawingVerticalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withOpacity(0.2),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: xInterval,
                        getTitlesWidget: (value, _) {
                          final date = DateTime.fromMillisecondsSinceEpoch(
                              value.toInt());
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              DateFormat('MM/dd').format(date),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        reservedSize: 40,
                        getTitlesWidget: (value, _) {
                          if (value % 1 != 0) return const SizedBox.shrink();
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Text(
                              value.toInt().toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  minY: 0,
                  maxY: 5.5,
                  minX: minX,
                  maxX: maxX,
                  lineBarsData: [
                    // Main severity line
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      curveSmoothness: 0.3,
                      color: Colors.blue,
                      barWidth: 2.5,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 3,
                            color: Colors.blue,
                            strokeWidth: 1,
                            strokeColor: Colors.white,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.blue.withOpacity(0.05),
                      ),
                    ),
                    // Add flare rectangles
                    ...flareRects,
                  ],
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.grey.withOpacity(0.3)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Legend
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.2),
                    border: Border.all(color: Colors.red.withOpacity(0.4)),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 4),
                const Text('Flare period'),
                const SizedBox(width: 24),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                const SizedBox(width: 4),
                const Text('Severity'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

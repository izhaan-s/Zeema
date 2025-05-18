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

    // Sort data by date
    final sortedData = List<SeverityPoint>.from(severityData)
      ..sort((a, b) => a.date.compareTo(b.date));

    // Create spots for line chart
    final spots = sortedData
        .map((e) => FlSpot(
            e.date.millisecondsSinceEpoch.toDouble(), e.severity.toDouble()))
        .toList();

    // Min and max dates
    final firstDate = sortedData.first.date;
    final lastDate = sortedData.last.date;
    final minX = firstDate.millisecondsSinceEpoch.toDouble();
    final maxX = lastDate.millisecondsSinceEpoch.toDouble();

    // Calculate date intervals for x-axis labels
    final dateRange = lastDate.difference(firstDate).inDays;
    final interval = (dateRange / 5).ceil();

    // Create flare bars
    final flareBars = <LineChartBarData>[];
    for (final flare in flares) {
      flareBars.add(
        LineChartBarData(
          spots: [
            // Create a vertical rectangle by drawing 4 points for each flare
            FlSpot(flare.start.millisecondsSinceEpoch.toDouble(), 0),
            FlSpot(flare.start.millisecondsSinceEpoch.toDouble(), 5.5),
            FlSpot(flare.end.millisecondsSinceEpoch.toDouble(), 5.5),
            FlSpot(flare.end.millisecondsSinceEpoch.toDouble(), 0),
          ],
          color: Colors.transparent,
          barWidth: 1,
          isCurved: false,
          isStrokeCapRound: false,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            color: Colors.red.withOpacity(0.15),
            applyCutOffY: false,
          ),
        ),
      );
    }

    return Container(
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
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: LineChart(
          LineChartData(
            backgroundColor: const Color(0xFFF8F9FA),
            gridData: FlGridData(
              show: true,
              drawHorizontalLine: true,
              drawVerticalLine: true,
              horizontalInterval: 1,
              verticalInterval: (maxX - minX) / 6,
              getDrawingHorizontalLine: (value) => FlLine(
                color: Colors.grey.withOpacity(0.15),
                strokeWidth: 1,
                dashArray: [5, 5],
              ),
              getDrawingVerticalLine: (value) => FlLine(
                color: Colors.grey.withOpacity(0.15),
                strokeWidth: 1,
                dashArray: [5, 5],
              ),
            ),
            titlesData: FlTitlesData(
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  getTitlesWidget: (value, meta) {
                    // Show dates at regular intervals
                    if (value < minX || value > maxX) {
                      return const SizedBox.shrink();
                    }

                    final date =
                        DateTime.fromMillisecondsSinceEpoch(value.toInt());
                    final format = dateRange > 30 ? 'MMM d' : 'MMM dd';
                    final text = DateFormat(format).format(date);

                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        text,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  },
                  interval: (maxX - minX) / 4,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  reservedSize: 35,
                  getTitlesWidget: (value, meta) {
                    if (value % 1 != 0 || value < 0 || value > 5) {
                      return const SizedBox.shrink();
                    }
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        value.toInt().toString(),
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            minX: minX,
            maxX: maxX,
            minY: 0,
            maxY: 5.5,
            lineTouchData: LineTouchData(
              enabled: true,
              touchTooltipData: LineTouchTooltipData(
                fitInsideHorizontally: true,
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map((LineBarSpot touchedSpot) {
                    final date = DateTime.fromMillisecondsSinceEpoch(
                      touchedSpot.x.toInt(),
                    );
                    return LineTooltipItem(
                      '${DateFormat('MMM d').format(date)}\nSeverity: ${touchedSpot.y.toInt()}',
                      const TextStyle(color: Colors.white, fontSize: 12),
                    );
                  }).toList();
                },
              ),
            ),
            lineBarsData: [
              // Main data line
              LineChartBarData(
                spots: spots,
                isCurved: true,
                curveSmoothness: 0.2,
                color: const Color(0xFF2196F3), // Blue line color
                barWidth: 2.5,
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 4,
                      color: const Color(0xFF2196F3), // Blue dot color
                      strokeWidth: 2,
                      strokeColor: Colors.white,
                    );
                  },
                ),
                belowBarData: BarAreaData(
                  show: false,
                ),
              ),
              // Flare period bars
              ...flareBars,
            ],
          ),
        ),
      ),
    );
  }
}

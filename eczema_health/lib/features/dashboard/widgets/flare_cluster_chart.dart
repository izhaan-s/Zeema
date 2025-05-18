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

    // Only show a few dates (first, last, and middle)
    final middleDate =
        DateTime.fromMillisecondsSinceEpoch(((minX + maxX) / 2).toInt());

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Severity Trends',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 16, 8),
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                    drawVerticalLine: false,
                    horizontalInterval: 1,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: Colors.grey.withOpacity(0.15),
                      strokeWidth: 1,
                    ),
                  ),
                  titlesData: FlTitlesData(
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          // Only show 3 labels: start, middle, end
                          String text = '';
                          if (value.toInt() == minX.toInt()) {
                            text = DateFormat('MM/dd').format(firstDate);
                          } else if (value.toInt() == maxX.toInt()) {
                            text = DateFormat('MM/dd').format(lastDate);
                          } else if ((value - minX).abs() < 86400000 &&
                              (value - maxX).abs() > 86400000 &&
                              (maxX - minX) > 86400000 * 5) {
                            text = DateFormat('MM/dd').format(middleDate);
                          }

                          if (text.isEmpty) {
                            return const SizedBox.shrink();
                          }

                          return Text(
                            text,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
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
                                color: Colors.black87,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.4),
                        width: 1,
                      ),
                      left: BorderSide(
                        color: Colors.grey.withOpacity(0.4),
                        width: 1,
                      ),
                    ),
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
                            '${DateFormat('MM/dd').format(date)}\nSeverity: ${touchedSpot.y.toInt()}',
                            const TextStyle(color: Colors.white),
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
                      curveSmoothness: 0.3,
                      color: Colors.blue,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: Colors.blue,
                            strokeWidth: 1,
                            strokeColor: Colors.white,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.blue.withOpacity(0.1),
                      ),
                    ),
                    // Horizontal bars for flares
                    ...flareBars,
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _legendItem(
                  color: Colors.blue,
                  label: 'Severity',
                  isLine: true,
                ),
                const SizedBox(width: 24),
                _legendItem(
                  color: Colors.red.withOpacity(0.6),
                  label: 'Flare period',
                  isLine: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _legendItem({
    required Color color,
    required String label,
    required bool isLine,
  }) {
    return Row(
      children: [
        isLine
            ? Container(
                width: 14,
                height: 3,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(0),
                ),
              )
            : Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.15),
                  border:
                      Border.all(color: Colors.red.withOpacity(0.3), width: 1),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

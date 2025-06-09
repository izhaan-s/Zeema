import 'package:eczema_health/data/models/analysis_models.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FlareClusterChart extends StatefulWidget {
  final List<SeverityPoint> severityData;
  final List<FlareCluster> flares;

  const FlareClusterChart({
    super.key,
    required this.severityData,
    required this.flares,
  });

  @override
  State<FlareClusterChart> createState() => _FlareClusterChartState();
}

class _FlareClusterChartState extends State<FlareClusterChart> {
  List<Color> gradientColors = [
    const Color(0xFF2196F3), // Main blue
    const Color(0xFF64B5F6), // Lighter blue for gradient
  ];

  bool showFlares = true;

  // Track which dates we've already shown to prevent duplicates
  static final Set<String> _shownDates = <String>{};
  static int _lastDataHash = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.severityData.isEmpty) {
      return const Center(child: Text('No data available'));
    }

    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70, // Maintain aspect ratio
          child: Padding(
            padding: const EdgeInsets.only(
              right: 10, // Reduced
              left: 6, // Reduced
              top: 16, // Reduced (button has its own positioning)
              bottom: 8, // Reduced
            ),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
        if (widget.flares.isNotEmpty)
          Positioned(
            right: 5,
            top: -5,
            child: SizedBox(
              height: 30,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  setState(() {
                    showFlares = !showFlares;
                  });
                },
                child: Text(
                  showFlares ? 'Hide Flares' : 'Show Flares',
                  style: TextStyle(
                    fontSize: 11, // Slightly smaller font for button
                    color: const Color(0xFF2196F3)
                        .withOpacity(showFlares ? 1.0 : 0.7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    if (widget.severityData.isEmpty) return const SizedBox.shrink();

    final sortedData = List<SeverityPoint>.from(widget.severityData)
      ..sort((a, b) => a.date.compareTo(b.date));

    // Create a set of actual data point timestamps
    final dataTimestamps = sortedData
        .map((e) => e.date.millisecondsSinceEpoch.toDouble())
        .toList();

    // Create a hash of the current data to detect when we need to clear
    final currentDataHash =
        dataTimestamps.map((e) => e.toInt()).reduce((a, b) => a ^ b);

    // Clear the set when we detect a new chart render (different data)
    if (currentDataHash != _lastDataHash) {
      _shownDates.clear();
      _lastDataHash = currentDataHash;
    }

    // Find the closest actual data point to this value
    double? closestTimestamp;
    double minDistance = double.infinity;

    for (final timestamp in dataTimestamps) {
      final distance = (value - timestamp).abs();
      if (distance < minDistance) {
        minDistance = distance;
        closestTimestamp = timestamp;
      }
    }

    // Only show label if we're very close to an actual data point (within 6 hours)
    if (closestTimestamp == null ||
        minDistance > const Duration(hours: 6).inMilliseconds) {
      return const SizedBox.shrink();
    }

    final date = DateTime.fromMillisecondsSinceEpoch(closestTimestamp.toInt());
    final dateRangeDays =
        sortedData.last.date.difference(sortedData.first.date).inDays;

    // Create unique date string to prevent duplicates
    final String dateText = DateFormat('d MMM').format(date);

    // If we've already shown this date, don't show again
    if (_shownDates.contains(dateText)) {
      return const SizedBox.shrink();
    }

    // Determine which data points to show labels for based on date range
    final index = dataTimestamps.indexOf(closestTimestamp);
    final totalPoints = dataTimestamps.length;
    bool shouldShowLabel = false;

    if (totalPoints == 1) {
      // Only ONE data point: show it only once (for the first occurrence)
      shouldShowLabel = index == 0 && !_shownDates.contains(dateText);
    } else if (dateRangeDays == 0) {
      // Multiple points same day: show only first one
      shouldShowLabel = index == 0;
    } else if (totalPoints <= 3) {
      // Very few data points: show all of them
      shouldShowLabel = true;
    } else if (dateRangeDays <= 7) {
      // One week: show exactly 3 points (first, middle, last)
      final middleIndex = totalPoints ~/ 2;
      shouldShowLabel =
          index == 0 || index == middleIndex || index == totalPoints - 1;
    } else if (dateRangeDays <= 30) {
      // One month: show every 3rd data point + first and last
      shouldShowLabel = index % 3 == 0 || index == totalPoints - 1;
    } else {
      // Longer periods: show every 5th data point + first and last
      shouldShowLabel = index % 5 == 0 || index == totalPoints - 1;
    }

    if (!shouldShowLabel) {
      return const SizedBox.shrink();
    }

    // Add this date to our shown set to prevent duplicates
    _shownDates.add(dateText);

    const style = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 9.5,
      color: Colors.black87,
    );

    return SideTitleWidget(
      meta: meta,
      space: 4.0,
      child: Text(dateText, style: style),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    if (value % 1 != 0 || value < 0 || value > 5) {
      return Container();
    }

    const style = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 10,
      color: Colors.black87,
    );

    return SideTitleWidget(
      meta: meta,
      space: 5.0, // Adjusted space
      child: Text(value.toInt().toString(),
          style: style, textAlign: TextAlign.center),
    );
  }

  LineChartData mainData() {
    if (widget.severityData.isEmpty) {
      return LineChartData();
    }

    final sortedData = List<SeverityPoint>.from(widget.severityData)
      ..sort((a, b) => a.date.compareTo(b.date));
    final spots = sortedData
        .map((e) => FlSpot(
            e.date.millisecondsSinceEpoch.toDouble(), e.severity.toDouble()))
        .toList();

    final firstDate = sortedData.first.date;
    final lastDate = sortedData.last.date;
    final minX = firstDate.millisecondsSinceEpoch.toDouble();
    final maxX = lastDate.millisecondsSinceEpoch.toDouble();

    final effectiveMaxX = (minX == maxX)
        ? maxX + const Duration(days: 1).inMilliseconds.toDouble()
        : maxX;

    final flareBars = <LineChartBarData>[];
    if (showFlares) {
      for (final flare in widget.flares) {
        flareBars.add(
          LineChartBarData(
            spots: [
              FlSpot(flare.start.millisecondsSinceEpoch.toDouble(), 0),
              FlSpot(flare.start.millisecondsSinceEpoch.toDouble(), 5.5),
              FlSpot(flare.end.millisecondsSinceEpoch.toDouble(), 5.5),
              FlSpot(flare.end.millisecondsSinceEpoch.toDouble(), 0),
            ],
            color: Colors.transparent,
            barWidth: 0,
            isCurved: false,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.red.withOpacity(0.30), // Increased opacity
              applyCutOffY: false,
            ),
            showingIndicators: [],
          ),
        );
      }
    }

    return LineChartData(
      lineTouchData: LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (_) => Colors.blueGrey.withOpacity(0.85),
          getTooltipItems: (touchedSpots) {
            return touchedSpots
                .map((LineBarSpot touchedSpot) {
                  // Ensure tooltips are only for the main data line (index 0)
                  if (touchedSpot.barIndex == 0) {
                    final date = DateTime.fromMillisecondsSinceEpoch(
                      touchedSpot.x.toInt(),
                    );
                    return LineTooltipItem(
                      '${DateFormat('MMM d, yyyy').format(date)}\nSeverity: ${touchedSpot.y.toStringAsFixed(1)}',
                      const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold),
                    );
                  }
                  return null;
                })
                .whereType<LineTooltipItem>()
                .toList();
          },
        ),
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: true,
        horizontalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey.withOpacity(0.25),
            strokeWidth: 0.8, // Thinner grid lines
            dashArray: [4, 4],
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 22, // Adjusted for smaller font & tighter packing
            getTitlesWidget: bottomTitleWidgets,
            interval:
                null, // Let the library decide the interval for potentially better spacing
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 24, // Adjusted for smaller font
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
            color: gradientColors[0].withOpacity(0.3),
            width: 1.5, // Thinner border
          ),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      ),
      minX: minX,
      maxX: effectiveMaxX,
      minY: 0,
      maxY: 5.5,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          barWidth: 3, // Slightly thinner line
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) {
              return FlDotCirclePainter(
                radius: 3, // Slightly smaller dots
                color: gradientColors[0],
                strokeWidth: 1.2,
                strokeColor: Colors.white,
              );
            },
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.2))
                  .toList(),
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        ...flareBars,
      ],
    );
  }
}

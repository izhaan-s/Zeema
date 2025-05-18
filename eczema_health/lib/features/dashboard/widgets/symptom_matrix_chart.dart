import 'package:flutter/material.dart';

class SymptomMatrixChart extends StatefulWidget {
  final List<Map<String, double>> matrixData;

  const SymptomMatrixChart({
    Key? key,
    required this.matrixData,
  }) : super(key: key);

  @override
  State<SymptomMatrixChart> createState() => _SymptomMatrixChartState();
}

class _SymptomMatrixChartState extends State<SymptomMatrixChart> {
  late List<String> symptoms;
  List<String> importantSymptoms = [];

  // The key symptoms to focus on
  final Set<String> keySymptoms = {
    'Itching',
    'Redness',
    'Flaking',
    'Dryness',
    'Swelling',
    'Pain',
    'Burning',
  };

  @override
  void initState() {
    super.initState();
    // Extract all symptom names from the matrix data
    symptoms = widget.matrixData.isNotEmpty
        ? widget.matrixData.first.keys.toList()
        : [];

    _filterImportantSymptoms();
  }

  // Filter to only important symptoms based on correlation strength
  // or the predefined key symptoms list
  void _filterImportantSymptoms() {
    try {
      if (symptoms.isEmpty || widget.matrixData.isEmpty) {
        importantSymptoms = [];
        return;
      }

      // First check for our predefined key symptoms
      final keyFound = symptoms.where((s) => keySymptoms.contains(s)).toList();

      if (keyFound.isNotEmpty) {
        // Use our key symptoms that are present in the data
        importantSymptoms = keyFound;
      } else {
        // If no key symptoms match, use the top 5 symptoms with strongest correlations
        final correlationStrengths = <String, double>{};

        // Calculate average correlation strength for each symptom
        for (int i = 0; i < symptoms.length; i++) {
          final symptom = symptoms[i];
          double totalCorrelation = 0;

          // Sum the absolute correlation values for this symptom
          for (int j = 0; j < symptoms.length; j++) {
            if (i != j) {
              final value =
                  (i < widget.matrixData.length && j < symptoms.length)
                      ? widget.matrixData[i][symptoms[j]] ?? 0.0
                      : 0.0;
              totalCorrelation += value.abs();
            }
          }

          // Store the average correlation
          correlationStrengths[symptom] = symptoms.length > 1
              ? totalCorrelation / (symptoms.length - 1)
              : 0.0;
        }

        // Sort symptoms by correlation strength
        final sortedSymptoms = symptoms.toList()
          ..sort((a, b) => (correlationStrengths[b] ?? 0.0)
              .compareTo(correlationStrengths[a] ?? 0.0));

        // Take the top 5 or fewer if there are less
        importantSymptoms = sortedSymptoms.take(5).toList();
      }
    } catch (e) {
      // If any errors occur, fallback to showing all symptoms
      importantSymptoms = symptoms;
      print('Error filtering symptoms: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.matrixData.isEmpty || importantSymptoms.isEmpty) {
      return const Center(child: Text('No correlation data available'));
    }

    return Container(
      padding: const EdgeInsets.all(16),
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
          Expanded(
            child: _buildMatrixGrid(),
          ),
          const SizedBox(height: 8),
          _buildLegend(),
        ],
      ),
    );
  }

  Widget _buildMatrixGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cellSize = (constraints.maxWidth - 50) / importantSymptoms.length;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row with symptom names
                Row(
                  children: [
                    SizedBox(width: 50), // Empty corner
                    ...importantSymptoms
                        .map((symptom) => _buildHeaderCell(symptom, cellSize)),
                  ],
                ),
                // Matrix rows
                ...List.generate(importantSymptoms.length, (rowIndex) {
                  final rowSymptom = importantSymptoms[rowIndex];
                  final rowIdx = symptoms.indexOf(rowSymptom);

                  return Row(
                    children: [
                      // Row header (symptom name)
                      Container(
                        width: 50,
                        height: cellSize,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(
                          importantSymptoms[rowIndex],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Correlation cells
                      ...List.generate(importantSymptoms.length, (colIndex) {
                        final colSymptom = importantSymptoms[colIndex];
                        final colIdx = symptoms.indexOf(colSymptom);

                        final value = rowIdx >= 0 && colIdx >= 0
                            ? widget.matrixData[rowIdx][colSymptom] ?? 0.0
                            : 0.0;

                        return _buildMatrixCell(value, cellSize);
                      }),
                    ],
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeaderCell(String text, double size) {
    return Container(
      width: size,
      height: 50,
      padding: const EdgeInsets.all(4),
      alignment: Alignment.bottomCenter,
      child: RotatedBox(
        quarterTurns: 3,
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildMatrixCell(double value, double size) {
    // Color gradient from white (0) to blue (1) for positive
    // Or white (0) to red (1) for negative
    final color = value > 0
        ? Color.lerp(Colors.white, Colors.blue, value.abs().clamp(0.0, 1.0))!
        : Color.lerp(Colors.white, Colors.red, value.abs().clamp(0.0, 1.0))!;

    return Container(
      width: size,
      height: size,
      margin: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
      alignment: Alignment.center,
      child: Text(
        value.toStringAsFixed(2),
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w500,
          color: value.abs() > 0.5 ? Colors.white : Colors.black87,
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.blue],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        const Text('Positive correlation', style: TextStyle(fontSize: 10)),
        const SizedBox(width: 16),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.red],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        const Text('Negative correlation', style: TextStyle(fontSize: 10)),
      ],
    );
  }
}

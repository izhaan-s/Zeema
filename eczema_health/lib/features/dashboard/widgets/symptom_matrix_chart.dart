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

  @override
  void initState() {
    super.initState();
    // Extract the symptom names from the matrix data
    symptoms = widget.matrixData.isNotEmpty
        ? widget.matrixData.first.keys.toList()
        : [];
  }

  @override
  Widget build(BuildContext context) {
    if (widget.matrixData.isEmpty || symptoms.isEmpty) {
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
          Text(
            'Symptom Correlation Matrix',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
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
        final cellSize = (constraints.maxWidth - 50) / symptoms.length;

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
                    ...symptoms
                        .map((symptom) => _buildHeaderCell(symptom, cellSize)),
                  ],
                ),
                // Matrix rows
                ...List.generate(symptoms.length, (rowIndex) {
                  return Row(
                    children: [
                      // Row header (symptom name)
                      Container(
                        width: 50,
                        height: cellSize,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(
                          symptoms[rowIndex],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Correlation cells
                      ...List.generate(symptoms.length, (colIndex) {
                        final value = widget.matrixData[rowIndex]
                                [symptoms[colIndex]] ??
                            0.0;
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

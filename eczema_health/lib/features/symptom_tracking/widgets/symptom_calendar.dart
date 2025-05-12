import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../data/models/symptom_entry_model.dart';

class SymptomCalendar extends StatefulWidget {
  final List<SymptomEntryModel> symptoms;
  final Function(DateTime) onDateSelected;

  const SymptomCalendar({
    super.key,
    required this.symptoms,
    required this.onDateSelected,
  });

  @override
  State<SymptomCalendar> createState() => _SymptomCalendarState();
}

class _SymptomCalendarState extends State<SymptomCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  List<SymptomEntryModel> _getEventsForDay(DateTime day) {
    return widget.symptoms
        .where((entry) => isSameDay(entry.date, day))
        .toList();
  }

  Color? _getMarkerColor(DateTime day) {
    final events = _getEventsForDay(day);
    if (events.isEmpty) return null;

    final entry = events.first;
    switch (entry.severity) {
      case '5':
        return Colors.red;
      case '4':
      case '3':
        return Colors.orange;
      case '2':
      case '1':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 1,
      color: Colors.white.withOpacity(0.98),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.withOpacity(0.08), width: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                widget.onDateSelected(selectedDay);
              },
              calendarStyle: CalendarStyle(
                outsideDaysVisible: true,
                todayDecoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: const BoxDecoration(
                  color: Color(0xFF2196F3),
                  shape: BoxShape.circle,
                ),
                defaultTextStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF424242),
                ),
                weekendTextStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF424242),
                ),
                outsideTextStyle: const TextStyle(
                  color: Color(0xFFBDBDBD),
                ),
                selectedTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                todayTextStyle: const TextStyle(
                  color: Color(0xFF1976D2),
                  fontWeight: FontWeight.w500,
                ),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF424242),
                ),
                leftChevronIcon: Icon(
                  Icons.chevron_left,
                  color: Color(0xFF2196F3),
                  size: 20,
                ),
                rightChevronIcon: Icon(
                  Icons.chevron_right,
                  color: Color(0xFF2196F3),
                  size: 20,
                ),
                headerPadding: EdgeInsets.symmetric(vertical: 8),
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  final color = _getMarkerColor(date);
                  if (color == null) return null;

                  return Positioned(
                    bottom: 1,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            _buildLegend(),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _LegendItem(color: const Color(0xFF4CAF50), label: 'Mild'),
          const SizedBox(width: 16),
          _LegendItem(color: const Color(0xFFFF9800), label: 'Moderate'),
          const SizedBox(width: 16),
          _LegendItem(color: const Color(0xFFF44336), label: 'Severe'),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF757575),
          ),
        ),
      ],
    );
  }
}

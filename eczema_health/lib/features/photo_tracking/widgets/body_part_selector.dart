import 'package:flutter/material.dart';

class BodyPartSelector extends StatelessWidget {
  final String? selectedBodyPart;
  final ValueChanged<String> onSelected;

  static const Map<String, IconData> _bodyPartIcons = {
    'Face': Icons.face,
    'Neck': Icons.accessibility_new,
    'Chest': Icons.favorite,
    'Back': Icons.airline_seat_recline_extra,
    'Arms': Icons.pan_tool,
    'Legs': Icons.directions_run,
    'Hands': Icons.back_hand,
    'Feet': Icons.directions_walk,
    'Other': Icons.more_horiz,
  };

  const BodyPartSelector({
    Key? key,
    required this.selectedBodyPart,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Body Part",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _bodyPartIcons.entries.map((entry) {
                  final bodyPart = entry.key;
                  final icon = entry.value;
                  final isSelected = selectedBodyPart == bodyPart;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ChoiceChip(
                      avatar: Icon(
                        icon,
                        color: isSelected
                            ? Colors.white
                            : Theme.of(context).colorScheme.primary,
                        size: 22,
                      ),
                      label: Text(bodyPart),
                      selected: isSelected,
                      selectedColor: Theme.of(context).colorScheme.primary,
                      backgroundColor: Colors.grey[200],
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      onSelected: (_) => onSelected(bodyPart),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey.shade400,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      elevation: isSelected ? 4 : 0,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

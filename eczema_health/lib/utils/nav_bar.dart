import 'package:flutter/material.dart';

const Color bottomNavBgColor = Color(0xFF17203A);
List<String> bottomNavItems = [
  'Dashboard',
  'Photos',
  'Symptoms',
  'Lifestyle',
  'Reminders'
];

List<IconData> bottomNavIcons = [
  Icons.home,
  Icons.camera_alt,
  Icons.show_chart_rounded,
  Icons.event,
  Icons.notifications
];

class BottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  const BottomNav(
      {Key? key, required this.selectedIndex, required this.onTabSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 24), // more bottom margin
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surface
            .withValues(alpha: 0.85), // match theme
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color:
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.10),
            offset: const Offset(0, 8),
            blurRadius: 32,
            spreadRadius: 2,
          ),
        ],
        // Optional: add a border for more separation
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.10),
          width: 1.2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          bottomNavItems.length,
          (index) => GestureDetector(
            onTap: () => onTabSelected(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.ease,
                  height: 3,
                  width: selectedIndex == index ? 24 : 0,
                  decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? Color(0xFF3B6FE8)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                SizedBox(height: 2),
                SizedBox(
                  height: 27,
                  width: 27,
                  child: Icon(
                    bottomNavIcons[index],
                    size: 22,
                    color: selectedIndex == index
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

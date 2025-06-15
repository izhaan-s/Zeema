import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import '../features/auth/tutorial_manager.dart';

const Color bottomNavBgColor = Color(0xFF17203A);

const List<String> bottomNavItems = [
  'Dashboard',
  'Photos',
  'Symptoms',
  'Lifestyle',
  'Reminders',
];

const List<IconData> bottomNavIcons = [
  Icons.home,
  Icons.camera_alt,
  Icons.show_chart_rounded,
  Icons.event,
  Icons.notifications,
];

class BottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const BottomNav({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 24),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surface
            .withOpacity(0.85), // match theme
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.10),
            offset: const Offset(0, 8),
            blurRadius: 32,
            spreadRadius: 2,
          ),
        ],
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.10),
          width: 1.2,
        ),
      ),
      child: Row(
        children: List.generate(
          bottomNavItems.length,
          (index) => Expanded(
            // each tab gets an equal-width cell
            child: _buildTabItem(context, index),
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem(BuildContext context, int index) {
    Widget tabContent = GestureDetector(
      behavior: HitTestBehavior.opaque, // whole cell is clickable
      onTap: () => onTabSelected(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
            height: 3,
            width: selectedIndex == index ? 24 : 0,
            decoration: BoxDecoration(
              color: selectedIndex == index
                  ? const Color(0xFF3B6FE8)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 2),
          Icon(
            bottomNavIcons[index],
            size: 22,
            color: selectedIndex == index
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
          const SizedBox(height: 4),
          Text(
            bottomNavItems[index],
            style: TextStyle(
              fontSize: 12,
              fontWeight:
                  selectedIndex == index ? FontWeight.bold : FontWeight.normal,
              color: selectedIndex == index
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );

    // Add showcase widgets for specific tabs
    if (index == 0) {
      // Dashboard tab
      return Showcase(
        key: TutorialManager.dashboardKey,
        description:
            'Welcome to your Dashboard! This is where you\'ll see your progress, flare patterns, and health insights.',
        child: tabContent,
      );
    } else if (index == 2) {
      // Symptoms tab
      return Showcase(
        key: TutorialManager.symptomKey,
        description:
            'Tap here to log your symptoms. Track severity, body locations, and triggers to identify patterns.',
        child: tabContent,
      );
    }

    return tabContent;
  }
}

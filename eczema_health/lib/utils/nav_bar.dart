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

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 56,
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: bottomNavBgColor.withValues(alpha: 0.8),
            borderRadius: BorderRadius.all(Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: bottomNavBgColor.withValues(alpha: 0.3),
                offset: Offset(0, 20),
                blurRadius: 20,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              bottomNavItems.length,
              (index) => SizedBox(
                height: 36,
                width: 36,
                child: Icon(bottomNavIcons[index],
                    color: Color.fromRGBO(240, 240, 240, 1)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

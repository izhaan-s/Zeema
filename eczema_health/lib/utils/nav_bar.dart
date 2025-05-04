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

int _selectedIndex = 0;

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
              (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                      height: 3,
                      width: _selectedIndex == index ? 24 : 0,
                      decoration: BoxDecoration(
                        color: _selectedIndex == index
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
                        color: _selectedIndex == index
                            ? Color.fromRGBO(240, 240, 240, 1)
                            : Color.fromRGBO(240, 240, 240, 0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

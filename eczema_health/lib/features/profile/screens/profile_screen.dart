import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/default_profile.png'),
              // Replace with user image when available
            ),
            const SizedBox(height: 16),

            // User Name
            const Text(
              'John Doe',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Email
            const Text(
              'johndoe@example.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),

            // Profile Options
            ProfileOption(
              icon: Icons.person_outline,
              title: 'Personal Information',
              onTap: () {
                // Navigate to personal info screen
              },
            ),
            ProfileOption(
              icon: Icons.history,
              title: 'Medical History',
              onTap: () {
                // Navigate to medical history screen
              },
            ),
            ProfileOption(
              icon: Icons.health_and_safety_outlined,
              title: 'Eczema Care Plan',
              onTap: () {
                // Navigate to care plan screen
              },
            ),
            ProfileOption(
              icon: Icons.notifications_outlined,
              title: 'Notifications',
              onTap: () {
                // Navigate to notifications settings
              },
            ),
            ProfileOption(
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: () {
                // Navigate to settings
              },
            ),
            ProfileOption(
              icon: Icons.help_outline,
              title: 'Help & Support',
              onTap: () {
                // Navigate to help screen
              },
            ),

            const SizedBox(height: 24),

            // Sign Out Button
            ElevatedButton(
              onPressed: () {
                // Sign out logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade400,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Sign Out',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileOption({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

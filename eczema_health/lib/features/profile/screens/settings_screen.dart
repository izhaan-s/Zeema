import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  void _deleteAccount(BuildContext context) async {
    // Show confirmation dialog requiring user to type "delete"
    final confirmed = await _showDeleteConfirmationDialog(context);

    if (confirmed == true) {
      await _performAccountDeletion(context);
    }
  }

  Future<bool?> _showDeleteConfirmationDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    bool canDelete = false;

    return showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title:
              const Text('Delete Account', style: TextStyle(color: Colors.red)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                  'This action cannot be undone. All your data will be permanently deleted.'),
              const SizedBox(height: 16),
              const Text('Type "delete" to confirm:'),
              const SizedBox(height: 8),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Type delete here...',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    canDelete = value.toLowerCase() == 'delete';
                  });
                },
                onSubmitted: (value) {
                  if (value.toLowerCase() == 'delete') {
                    Navigator.of(context).pop(true);
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed:
                  canDelete ? () => Navigator.of(context).pop(true) : null,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Delete Account',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _performAccountDeletion(BuildContext context) async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    print('🗑️ DEBUG: Starting account deletion process');

    if (user == null) {
      print('❌ DEBUG: No user logged in');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No user logged in.')),
      );
      return;
    }

    print('🗑️ DEBUG: User ID to delete: ${user.id}');
    print('🗑️ DEBUG: User email: ${user.email}');

    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text('Deleting account...'),
          ],
        ),
      ),
    );

    try {
      print('🗑️ DEBUG: Calling edge function to delete user...');

      // Call edge function to delete user (has admin permissions)
      final response = await supabase.functions
          .invoke('delete_user', body: {'user_id': user.id});

      print('🗑️ DEBUG: Edge function response status: ${response.status}');
      print('🗑️ DEBUG: Edge function response data: ${response.data}');

      if (response.status != 200) {
        throw Exception('Failed to delete user: ${response.data}');
      }

      print('✅ DEBUG: User completely deleted via edge function');

      print('🚪 DEBUG: Signing out user...');
      // Sign out
      await supabase.auth.signOut();
      print('✅ DEBUG: User signed out');

      Navigator.of(context).pop(); // Close loading
      Navigator.of(context).popUntil((route) => route.isFirst);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Account deleted successfully'),
            backgroundColor: Colors.green),
      );

      print('✅ DEBUG: Account deletion process completed');
    } catch (e) {
      print('❌ DEBUG: Error during account deletion: $e');
      Navigator.of(context).pop(); // Close loading
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }
  }

  void _logout(BuildContext context) async {
    final supabase = Supabase.instance.client;
    await supabase.auth.signOut();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: const Text('Delete Account',
                style: TextStyle(color: Colors.red)),
            subtitle:
                const Text('Permanently delete your account and all data.'),
            onTap: () => _deleteAccount(context),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log Out'),
            onTap: () => _logout(context),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.support_agent),
            title: const Text('Contact & Support'),
            subtitle: const Text('Email: support@zeema.app'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

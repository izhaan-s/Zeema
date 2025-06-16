import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  void _deleteAccount(BuildContext context) async {
    final supabase = Supabase.instance.client;
    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user logged in.')),
        );
        return;
      }
      // Delete user from Supabase Auth
      final response = await supabase.functions
          .invoke('delete_user', body: {'user_id': user.id});
      if (response.status == 200) {
        await supabase.auth.signOut();
        Navigator.of(context).popUntil((route) => route.isFirst);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to delete account: \\${response.data}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: \\${e.toString()}')),
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
            onTap: () async {
              await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('How to request account deletion'),
                  content: const Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('1. ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Expanded(
                            child: Text(
                                'Email us at support@zeema.app from your registered email address.'),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('2. ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Expanded(
                            child: Text(
                                'Use the subject line: "Account Deletion Request"'),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('3. ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Expanded(
                            child: Text(
                                'We\'ll verify your identity and delete all data within 7 business days.'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Got it'),
                    ),
                  ],
                ),
              );
            },
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

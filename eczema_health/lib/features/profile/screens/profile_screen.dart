import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../data/models/profile_model.dart';
import '../../../data/repositories/cloud/profile_repository.dart';
import '../../../data/repositories/local/profile_repository.dart';
import '../../../data/app_database.dart';
import 'settings_screen.dart';
import 'edit_profile_screen.dart';
import '../widgets/profile_stat_card.dart';
import '../widgets/profile_menu_item.dart';
import '../../../main.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileRepository _profileRepository = ProfileRepository();
  late final LocalProfileRepository _localProfileRepository;
  final ImagePicker _picker = ImagePicker();

  ProfileModel? _profile;
  Map<String, dynamic> _statistics = {};
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _localProfileRepository = LocalProfileRepository(
        Provider.of<AppDatabase>(context, listen: false));
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('No user logged in');
      }

      print('🔍 ProfileScreen: Loading profile for user $userId');

      ProfileModel? profile = await _localProfileRepository.getProfile(userId);

      if (profile == null) {
        print('📡 ProfileScreen: No local profile, fetching from cloud');
        profile = await _profileRepository.getProfile(userId);
      } else {
        print('💾 ProfileScreen: Using cached local profile');
      }

      print('📊 ProfileScreen: Getting statistics from local database');
      final stats = await _localProfileRepository.getProfileStatistics(userId);

      if (mounted) {
        setState(() {
          _profile = profile;
          _statistics = stats;
          _isLoading = false;
        });
        print('✅ ProfileScreen: Profile loaded successfully');
        print('📊 ProfileScreen: Statistics: $stats');
      }
    } catch (e) {
      print('❌ ProfileScreen: Error loading profile: $e');
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to load profile: ${e.toString()}';
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _updateAvatar() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 800,
        maxHeight: 800,
      );

      if (image != null) {
        final userId = Supabase.instance.client.auth.currentUser?.id;
        if (userId == null) return;

        // Show loading indicator
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );

        final avatarUrl =
            await _profileRepository.uploadAvatar(userId, image.path);

        Navigator.of(context).pop(); // Dismiss loading

        if (avatarUrl != null) {
          await _loadProfile(); // Reload profile
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Profile photo updated successfully')),
            );
          }
        }
      }
    } catch (e) {
      Navigator.of(context).pop(); // Dismiss loading if still showing
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update photo: ${e.toString()}')),
      );
    }
  }

  Future<void> _handleSignOut() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await Supabase.instance.client.auth.signOut();
      if (mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline,
                          size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        _errorMessage!,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _loadProfile,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () async {
                          // Debug: Show local statistics even if profile loading fails
                          try {
                            final userId =
                                Supabase.instance.client.auth.currentUser?.id;
                            if (userId != null) {
                              final localStats = await _localProfileRepository
                                  .getProfileStatistics(userId);
                              setState(() {
                                _statistics = localStats;
                                _errorMessage = 'Using offline data only';
                              });
                            }
                          } catch (e) {
                            print('❌ Failed to load local stats: $e');
                          }
                        },
                        child: const Text('Use Offline Data'),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadProfile,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Profile Header
                        _buildProfileHeader(),
                        const SizedBox(height: 24),

                        // Statistics Cards
                        _buildStatisticsSection(),
                        const SizedBox(height: 24),

                        // Menu Items
                        _buildMenuSection(),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor:
                    Theme.of(context).primaryColor.withOpacity(0.1),
                backgroundImage: _profile?.avatarUrl != null
                    ? NetworkImage(_profile!.avatarUrl!)
                    : null,
                child: _profile?.avatarUrl == null
                    ? Text(
                        _profile?.fullName.substring(0, 1).toUpperCase() ?? 'U',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt,
                        color: Colors.white, size: 20),
                    onPressed: _updateAvatar,
                    padding: const EdgeInsets.all(8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            _profile?.fullName ?? 'User',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _profile?.email ?? '',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          if (_profile?.dateOfBirth != null) ...[
            const SizedBox(height: 4),
            Text(
              'Age: ${DateTime.now().year - _profile!.dateOfBirth!.year}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatisticsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Eczema Journey',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.3,
          children: [
            ProfileStatCard(
              title: 'Symptom Entries',
              value: _statistics['totalSymptoms']?.toString() ?? '0',
              icon: Icons.edit_note,
              color: Colors.blue,
            ),
            ProfileStatCard(
              title: 'Flare-ups',
              value: _statistics['flareupCount']?.toString() ?? '0',
              icon: Icons.warning,
              color: Colors.orange,
            ),
            ProfileStatCard(
              title: 'Photos',
              value: _statistics['photoCount']?.toString() ?? '0',
              icon: Icons.camera_alt,
              color: Colors.purple,
            ),
            ProfileStatCard(
              title: 'Avg Severity',
              value: (_statistics['averageSeverity'] as double?)
                      ?.toStringAsFixed(1) ??
                  '0.0',
              icon: Icons.analytics,
              color: Colors.green,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMenuSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          ProfileMenuItem(
            icon: Icons.person_outline,
            title: 'Personal Information',
            subtitle: 'Edit your profile details',
            onTap: () async {
              if (_profile != null) {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProfileScreen(profile: _profile!),
                  ),
                );
                if (result == true) {
                  _loadProfile(); // Reload if profile was updated
                }
              }
            },
          ),
          const Divider(height: 1),
          ProfileMenuItem(
            icon: Icons.medical_information_outlined,
            title: 'Medical Information',
            subtitle: 'Allergies and medical notes',
            onTap: () {
              // Navigate to medical info screen
            },
          ),
          const Divider(height: 1),
          ProfileMenuItem(
            icon: Icons.medication_outlined,
            title: 'Active Medications',
            subtitle: '${_statistics['activeMedications'] ?? 0} medications',
            onTap: () {
              // Navigate to medications
            },
          ),
          const Divider(height: 1),
          ProfileMenuItem(
            icon: Icons.notifications_outlined,
            title: 'Reminders',
            subtitle: '${_statistics['activeReminders'] ?? 0} active',
            onTap: () {
              // Navigate to reminders
              mainScreenKey.currentState?.navigateToTab(4);
            },
          ),
          const Divider(height: 1),
          ProfileMenuItem(
            icon: Icons.help_outline,
            title: 'Help & Support',
            subtitle: 'Get help using the app',
            onTap: () {
              // Navigate to help
            },
          ),
          const Divider(height: 1),
          ProfileMenuItem(
            icon: Icons.logout,
            title: 'Sign Out',
            subtitle: 'Sign out of your account',
            iconColor: Colors.red,
            onTap: _handleSignOut,
          ),
        ],
      ),
    );
  }
}

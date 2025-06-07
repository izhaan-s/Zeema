import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'config/supabase_secrets.dart';
import 'features/auth/screens/login_screen.dart';
import 'navigation/app_router.dart';
import 'features/dashboard/screens/dashboard_screen.dart';
import 'features/photo_tracking/screens/photo_gallery_screen.dart';
import 'features/reminders/screens/reminders_screen.dart';
import 'features/reminders/controllers/reminder_controller.dart';
import 'features/reminders/services/notification_service.dart';
import 'utils/nav_bar.dart';
import 'features/symptom_tracking/screens/symptom_tracking_screen.dart';
import 'features/lifestyle_tracking/screens/lifestyle_log_screen.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'data/app_database.dart';
import 'data/services/sync_service.dart';
import 'features/legal/terms_and_conditions_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

final supabase = Supabase.instance.client;
// Global navigator key to use for navigation from anywhere
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the notification service (now a stub implementation)
  await NotificationService.init();

  AwesomeNotifications().setListeners(
    onActionReceivedMethod: NotificationController.onActionReceivedMethod,
    onNotificationCreatedMethod:
        NotificationController.onNotificationCreatedMethod,
    onNotificationDisplayedMethod:
        NotificationController.onNotificationDisplayedMethod,
    onDismissActionReceivedMethod:
        NotificationController.onDismissActionReceivedMethod,
  );

  await Supabase.initialize(
    url: SupabaseSecrets.supabaseUrl,
    anonKey: SupabaseSecrets.supabaseKey,
  );
  runApp(const EczemaHealthApp());
}

// This class handles notification actions
class NotificationController {
  /// method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // Notification created
  }

  /// method to detect every time a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Notification displayed
  }

  /// method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Notification dismissed
  }

  /// method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Notification action received

    // Navigate to reminders screen when a notification is tapped
    if (navigatorKey.currentContext != null) {
      // Navigate to the reminders screen
      navigatorKey.currentState?.pushNamed(AppRouter.reminder);
    }
  }
}

class EczemaHealthApp extends StatelessWidget {
  const EczemaHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ReminderController()),
      ],
      child: MaterialApp(
        title: 'Eczema Health',
        navigatorKey: navigatorKey,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const TermsOrAuthGate(),
        // Keep onGenerateRoute for auth and deep links
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}

class TermsOrAuthGate extends StatefulWidget {
  const TermsOrAuthGate({Key? key}) : super(key: key);

  @override
  State<TermsOrAuthGate> createState() => _TermsOrAuthGateState();
}

class _TermsOrAuthGateState extends State<TermsOrAuthGate> {
  bool? _accepted;

  @override
  void initState() {
    super.initState();
    _checkAccepted();
  }

  Future<void> _checkAccepted() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _accepted = prefs.getBool('terms_accepted') ?? false;
    });
  }

  void _onAccepted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('terms_accepted', true);
    setState(() {
      _accepted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_accepted == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_accepted == true) {
      return AuthGate();
    }
    return TermsAndConditionsScreen(onAccepted: _onAccepted);
  }
}

class AuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = Supabase.instance.client.auth.currentSession;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (session != null && session.user != null) {
          return const MainScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = [
    DashboardScreen(),
    PhotoGalleryScreen(),
    SymptomTrackingScreen(),
    LifestyleLogScreen(),
    RemindersScreen(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _runAutoSync();
  }

  Future<void> _runAutoSync() async {
    final db = await DBProvider.instance.database;
    final syncService = SyncService(db);
    try {
      await syncService.syncData();
      print('Auto sync complete!');
    } catch (e) {
      print('Auto sync failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNav(
        selectedIndex: _selectedIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}

// Can ignore class below
class AuthRedirect extends StatefulWidget {
  const AuthRedirect({super.key});

  @override
  State<AuthRedirect> createState() => _AuthRedirectState();
}

class _AuthRedirectState extends State<AuthRedirect> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Always redirects to login for now adjust later
    return const LoginScreen();
  }
}

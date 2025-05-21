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
    debugPrint('Notification created: ${receivedNotification.id}');
  }

  /// method to detect every time a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('Notification displayed: ${receivedNotification.id}');
  }

  /// method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('Notification dismissed: ${receivedAction.id}');
  }

  /// method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('Notification action received: ${receivedAction.id}');

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
        home: const MainScreen(),
        // Keep onGenerateRoute for auth and deep links
        onGenerateRoute: AppRouter.generateRoute,
      ),
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

import 'package:flutter/material.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/signup_screen.dart';
import '../features/auth/screens/verification_screen.dart';
import '../features/dashboard/screens/dashboard_screen.dart';

// Class for passing email to verification screen
class VerificationScreenArguments {
  final String email;
  
  VerificationScreenArguments(this.email);
}

class AppRouter {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String verification = '/verification';
  static const String dashboard = '/dashboard';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name) {
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          maintainState: false,
        );
      case signup:
        return MaterialPageRoute(
          builder: (_) => const SignupScreen(),
        );
      case verification:
        final args = settings.arguments as VerificationScreenArguments;
        return MaterialPageRoute(
          builder: (_) => VerificationScreen(email: args.email),
          maintainState: false,
        );
      case dashboard:
        return MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
    }
  }

  // Navigation methods that prevent going back
  static void navigateToLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, login);
  }

  // Allow back navigation only for signup (from login)
  static void navigateToSignup(BuildContext context) {
    Navigator.pushNamed(context, signup);
  }

  static void navigateToVerification(BuildContext context, String email) {
    Navigator.pushReplacementNamed(
      context, 
      verification,
      arguments: VerificationScreenArguments(email),
    );
  }

  // Use this for logout or session expiration
  static void resetToLogin(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context, 
      login,
      (route) => false, // Remove all previous routes
    );
  }
}
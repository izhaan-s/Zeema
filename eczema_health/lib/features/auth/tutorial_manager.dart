import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'tutorial_service.dart';
import '../../main.dart';

class TutorialManager {
  static final GlobalKey _symptomKey = GlobalKey();
  static final GlobalKey _reminderKey = GlobalKey();
  static final GlobalKey _dashboardKey = GlobalKey();

  static List<GlobalKey> get keys => [_dashboardKey, _symptomKey, _reminderKey];

  // Getter methods for individual keys
  static GlobalKey get symptomKey => _symptomKey;
  static GlobalKey get reminderKey => _reminderKey;
  static GlobalKey get dashboardKey => _dashboardKey;

  // Current tutorial state
  static int _currentStep = 0;
  static BuildContext? _tutorialContext;

  static Future<void> startTutorial(BuildContext context) async {
    print("DEBUG TutorialManager: startTutorial called");
    final tutorialService = TutorialService();
    final hasSeenTutorial = await tutorialService.hasSeenTutorial();
    print("DEBUG TutorialManager: hasSeenTutorial = $hasSeenTutorial");

    if (hasSeenTutorial) {
      print("DEBUG TutorialManager: Tutorial already seen, returning early");
      return;
    }

    _tutorialContext = context;
    _currentStep = 0;

    print("DEBUG TutorialManager: Starting step-by-step tutorial");

    // Ensure we start on the Dashboard tab
    if (mainScreenKey.currentState != null) {
      mainScreenKey.currentState!.navigateToTab(0);
    }

    // Wait for widgets to be fully built and attached
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Add additional delay to ensure all widgets are rendered
      Future.delayed(const Duration(milliseconds: 1000), () {
        _showNextStep();
      });
    });
  }

  static void _showNextStep() {
    final context = _getCurrentContext();
    print(
        "DEBUG TutorialManager: _showNextStep called, current context is null: ${context == null}");

    if (context == null) {
      print(
          "DEBUG TutorialManager: No valid context available, returning early");
      return;
    }

    print("DEBUG TutorialManager: Showing step $_currentStep");

    switch (_currentStep) {
      case 0:
        // Show Dashboard tab tooltip
        print(
            "DEBUG TutorialManager: Dashboard key attached: ${_dashboardKey.currentWidget != null}");
        print(
            "DEBUG TutorialManager: Dashboard key context: ${_dashboardKey.currentContext != null}");

        if (_dashboardKey.currentContext != null) {
          ShowCaseWidget.of(context).startShowCase([_dashboardKey]);
        } else {
          print(
              "DEBUG TutorialManager: Dashboard key not ready, retrying in 500ms");
          Future.delayed(const Duration(milliseconds: 500), () {
            _showNextStep();
          });
        }
        break;

      case 1:
        // Navigate to Symptoms tab first, then show tooltip
        _navigateToSymptomsAndShowcase(context);
        break;

      case 2:
        // Navigate to Reminders tab and show showcase
        _navigateToRemindersAndShowcase(context);
        break;

      default:
        completeTutorial();
        break;
    }
  }

  static void _navigateToSymptomsAndShowcase(BuildContext context) {
    print("DEBUG TutorialManager: Navigating to Symptoms screen");

    if (mainScreenKey.currentState != null) {
      print(
          "DEBUG TutorialManager: MainScreen found, navigating to Symptoms tab");

      // Navigate to the Symptoms tab (index 2)
      mainScreenKey.currentState!.navigateToTab(2);

      // Wait for navigation and widget rebuild, then show the showcase
      Future.delayed(const Duration(milliseconds: 1000), () {
        // Get fresh context after navigation
        final currentContext = navigatorKey.currentContext;
        if (currentContext != null && _symptomKey.currentContext != null) {
          print("DEBUG TutorialManager: Symptoms key ready after navigation");
          ShowCaseWidget.of(currentContext).startShowCase([_symptomKey]);
        } else {
          print("DEBUG TutorialManager: Symptoms key not ready, retrying");
          _retrySymptomsShowcase(0);
        }
      });
    } else {
      print("DEBUG TutorialManager: MainScreen not found, completing tutorial");
      completeTutorial();
    }
  }

  static void _retrySymptomsShowcase(int attempt) {
    const maxAttempts = 3;

    if (attempt >= maxAttempts) {
      print(
          "DEBUG TutorialManager: Max attempts reached for symptoms, moving to next step");
      onShowcaseComplete();
      return;
    }

    print(
        "DEBUG TutorialManager: Retry attempt ${attempt + 1} for symptoms showcase");

    Future.delayed(const Duration(milliseconds: 500), () {
      final currentContext = navigatorKey.currentContext;
      if (currentContext != null && _symptomKey.currentContext != null) {
        print(
            "DEBUG TutorialManager: Symptoms key ready on attempt ${attempt + 1}");
        ShowCaseWidget.of(currentContext).startShowCase([_symptomKey]);
      } else {
        _retrySymptomsShowcase(attempt + 1);
      }
    });
  }

  static void _navigateToRemindersAndShowcase(BuildContext context) {
    print("DEBUG TutorialManager: Navigating to Reminders screen");

    if (mainScreenKey.currentState != null) {
      print(
          "DEBUG TutorialManager: MainScreen found, navigating to Reminders tab");

      // Navigate to the Reminders tab (index 4)
      mainScreenKey.currentState!.navigateToTab(4);

      // Wait for navigation and widget rebuild, then show the showcase
      Future.delayed(const Duration(milliseconds: 1000), () {
        // Get fresh context after navigation
        final currentContext = navigatorKey.currentContext;
        if (currentContext != null && _reminderKey.currentContext != null) {
          print("DEBUG TutorialManager: Reminder key ready after navigation");
          ShowCaseWidget.of(currentContext).startShowCase([_reminderKey]);
        } else {
          print("DEBUG TutorialManager: Reminder key not ready, retrying");
          _retryReminderShowcase(0);
        }
      });
    } else {
      print("DEBUG TutorialManager: MainScreen not found, completing tutorial");
      completeTutorial();
    }
  }

  static void _retryReminderShowcase(int attempt) {
    const maxAttempts = 3;

    if (attempt >= maxAttempts) {
      print(
          "DEBUG TutorialManager: Max attempts reached for reminders, completing tutorial");
      completeTutorial();
      return;
    }

    print(
        "DEBUG TutorialManager: Retry attempt ${attempt + 1} for reminder showcase");

    Future.delayed(const Duration(milliseconds: 500), () {
      final currentContext = navigatorKey.currentContext;
      if (currentContext != null && _reminderKey.currentContext != null) {
        print(
            "DEBUG TutorialManager: Reminder key ready on attempt ${attempt + 1}");
        ShowCaseWidget.of(currentContext).startShowCase([_reminderKey]);
      } else {
        _retryReminderShowcase(attempt + 1);
      }
    });
  }

  static void onShowcaseComplete() {
    print(
        "DEBUG TutorialManager: onShowcaseComplete called, _tutorialContext is null: ${_tutorialContext == null}");
    _currentStep++;
    print(
        "DEBUG TutorialManager: Step $_currentStep completed, moving to next");

    // Add delay before showing next step
    Future.delayed(const Duration(milliseconds: 500), () {
      _showNextStep();
    });
  }

  static Future<void> completeTutorial() async {
    print(
        "DEBUG TutorialManager: completeTutorial called, clearing _tutorialContext");
    final tutorialService = TutorialService();
    await tutorialService.setHasSeenTutorial();
    await tutorialService.clearNewUserFlag();
    _tutorialContext = null;
    _currentStep = 0;

    // Navigate back to Dashboard when tutorial is complete
    if (mainScreenKey.currentState != null) {
      mainScreenKey.currentState!.navigateToTab(0);
    }
  }

  // Helper method to get current valid context
  static BuildContext? _getCurrentContext() {
    // Always try to get the most current context from navigator
    final currentContext = navigatorKey.currentContext;
    if (currentContext != null) {
      return currentContext;
    }

    // Fallback to stored context if it's still valid
    if (_tutorialContext != null) {
      try {
        if (_tutorialContext!.mounted) {
          return _tutorialContext;
        }
      } catch (e) {
        print("DEBUG TutorialManager: Stored context is invalid: $e");
      }
    }

    return null;
  }

  // Helper method to check if all keys are ready
  static bool _areKeysReady() {
    final dashboardReady = _dashboardKey.currentContext != null;
    final symptomReady = _symptomKey.currentContext != null;

    print(
        "DEBUG TutorialManager: Dashboard ready: $dashboardReady, Symptom ready: $symptomReady");

    return dashboardReady && symptomReady;
  }

  // Method to force restart tutorial (for debugging)
  static Future<void> restartTutorial(BuildContext context) async {
    print("DEBUG TutorialManager: Restarting tutorial");
    final tutorialService = TutorialService();
    await tutorialService.resetTutorial();
    await startTutorial(context);
  }

  // Method to manually navigate to a specific tab (called from MainScreen)
  static void navigateToTab(int tabIndex) {
    print("DEBUG TutorialManager: navigateToTab called with index $tabIndex");
    if (mainScreenKey.currentState != null) {
      mainScreenKey.currentState!.navigateToTab(tabIndex);
      print(
          "DEBUG TutorialManager: Successfully called navigateToTab($tabIndex)");
    } else {
      print("DEBUG TutorialManager: MainScreen not available for navigation");
    }
  }
}

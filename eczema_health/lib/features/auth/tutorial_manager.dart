import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'tutorial_service.dart';

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
        // Show Dashboard tab
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
        // Show Symptoms tab
        print(
            "DEBUG TutorialManager: Symptoms key attached: ${_symptomKey.currentWidget != null}");
        print(
            "DEBUG TutorialManager: Symptoms key context: ${_symptomKey.currentContext != null}");

        if (_symptomKey.currentContext != null) {
          ShowCaseWidget.of(context).startShowCase([_symptomKey]);
        } else {
          print(
              "DEBUG TutorialManager: Symptoms key not ready, retrying in 500ms");
          Future.delayed(const Duration(milliseconds: 500), () {
            _showNextStep();
          });
        }
        break;

      case 2:
        // Show Reminders tab - need to navigate first
        _navigateToRemindersAndShowcase(context);
        break;

      default:
        completeTutorial();
        break;
    }
  }

  static void _navigateToRemindersAndShowcase(BuildContext context) {
    print("DEBUG TutorialManager: Navigating to Reminders screen");

    // We need to navigate to the reminders tab (index 4) first
    // Since we can't directly access MainScreen's state, we'll use a different approach
    // For now, let's just show the reminder key if it's available

    if (_reminderKey.currentContext != null) {
      ShowCaseWidget.of(context).startShowCase([_reminderKey]);
    } else {
      print(
          "DEBUG TutorialManager: Reminder key not ready, completing tutorial");
      completeTutorial();
    }
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
    _tutorialContext = null;
    _currentStep = 0;
  }

  // Helper method to get current valid context
  static BuildContext? _getCurrentContext() {
    // Check if stored context is still valid
    if (_tutorialContext != null) {
      try {
        // Check if context is still mounted
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
}

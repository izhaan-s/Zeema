import 'package:shared_preferences/shared_preferences.dart';

class TutorialService {
  static const String hasSeenTutorialKey = "has_seen_tutorial";

  Future<bool> hasSeenTutorial() async {
    final prefs = await SharedPreferences.getInstance();
    final result = prefs.getBool(hasSeenTutorialKey) ?? false;
    print("DEBUG TutorialService: hasSeenTutorial() returning $result");
    return result;
  }

  Future<void> setHasSeenTutorial() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(hasSeenTutorialKey, true);
    print(
        "DEBUG TutorialService: setHasSeenTutorial() called - marked as seen");
  }

  // For debugging - reset tutorial state
  Future<void> resetTutorial() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(hasSeenTutorialKey);
    print(
        "DEBUG TutorialService: resetTutorial() called - tutorial state reset");
  }
}

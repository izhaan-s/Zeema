import 'package:shared_preferences/shared_preferences.dart';

class TutorialService {
  static const String hasSeenTutorialKey = "has_seen_tutorial";
  static const String isNewUserKey = "is_new_user";

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

  // New method to mark user as new signup
  Future<void> markAsNewUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isNewUserKey, true);
    print("DEBUG TutorialService: markAsNewUser() called - user marked as new");
  }

  // New method to check if user is new signup
  Future<bool> isNewUser() async {
    final prefs = await SharedPreferences.getInstance();
    final result = prefs.getBool(isNewUserKey) ?? false;
    print("DEBUG TutorialService: isNewUser() returning $result");
    return result;
  }

  // New method to clear new user flag after tutorial
  Future<void> clearNewUserFlag() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(isNewUserKey);
    print("DEBUG TutorialService: clearNewUserFlag() called - flag cleared");
  }

  // For debugging - reset tutorial state
  Future<void> resetTutorial() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(hasSeenTutorialKey);
    await prefs.remove(isNewUserKey);
    print(
        "DEBUG TutorialService: resetTutorial() called - tutorial state reset");
  }
}

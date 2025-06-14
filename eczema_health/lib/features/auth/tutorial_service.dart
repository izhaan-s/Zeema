import 'package:shared_preferences/shared_preferences.dart';

class TutorialService {
  static const String hasSeenTutorialKey = "has_seen_tutorial";

  Future<bool> hasSeenTutorial() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(hasSeenTutorialKey) ?? false;
  }

  Future<void> setHasSeenTutorial() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(hasSeenTutorialKey, true);
  }
}

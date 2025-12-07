import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/constants/constants.dart';

class NotificationController extends GetxController {
  final RxBool workoutReminder = true.obs;
  final RxBool weeklyProgress = true.obs;
  final RxBool pushNotifications = true.obs;
  final RxBool emailNotifications = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotificationPreferences();
  }

  Future<void> loadNotificationPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    workoutReminder.value = prefs.getBool(hasWorkoutReminder) ?? true;
    weeklyProgress.value = prefs.getBool(hasWeeklyProgress) ?? true;
    pushNotifications.value = prefs.getBool(hasPushNotifications) ?? true;
    emailNotifications.value = prefs.getBool(hasEmailNotifications) ?? false;
  }

  Future<void> saveNotificationPreference(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }
}

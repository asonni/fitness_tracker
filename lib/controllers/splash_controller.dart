import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/constants/constants.dart';
import '../config/router-configs/route_names.dart';
import '../services/auth_service.dart';

class SplashController extends GetxController {
  final _authService = Get.put(AuthService());

  @override
  void onInit() async {
    // For testing purposes, mark onboarding as unseen every time app starts
    // await markOnboardingAsUnSeen();
    _screenRedirect();
    super.onInit();
  }

  void _screenRedirect() async {
    // await Future.delayed(Duration(seconds: 3)); // Simulate some loading time

    final hasSeenOnboarding = await _hasSeenOnBoarding();

    if (!hasSeenOnboarding) {
      Get.offNamed(RouteNames.onboarding);
      return;
    }

    final isAuthenticated = await _isAuthenticated();
    if (!isAuthenticated) {
      Get.offNamed(RouteNames.signin);
      return;
    }

    Get.offNamed(RouteNames.workoutList);
  }

  Future<bool> _hasSeenOnBoarding() async {
    final sh = await SharedPreferences.getInstance();
    return sh.getBool(hasOnboardingInitialized) ?? false;
  }

  Future<void> markOnboardingAsUnSeen() async {
    final sh = await SharedPreferences.getInstance();
    sh.setBool(hasOnboardingInitialized, false);
  }

  Future<bool> _isAuthenticated() async {
    final user = await _authService.getSignedInUser();
    return user.id.isNotEmpty;
  }
}

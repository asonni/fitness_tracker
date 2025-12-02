import 'package:get/get.dart';
import 'package:fitness_tracker/config/constants/constants.dart';
import 'package:fitness_tracker/config/router-configs/route_names.dart';
import 'package:fitness_tracker/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  final _authService = Get.put(AuthService());

  @override
  void onInit() async {
    _screenRedirect();
    super.onInit();
  }

  void _screenRedirect() async {
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

  Future<bool> _isAuthenticated() async {
    final user = await _authService.getSignedInUser();
    return user.id.isNotEmpty;
  }
}

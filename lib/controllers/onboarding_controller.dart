import 'package:fitness_tracker/config/constants/constants.dart';
import 'package:fitness_tracker/config/router-configs/route_names.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingController extends GetxController {
  void onDone() async {
    await _changeOnboardingInitialStatus();
    Get.offNamed(RouteNames.signin);
  }

  Future<void> _changeOnboardingInitialStatus() async {
    final sh = await SharedPreferences.getInstance();
    sh.setBool(hasOnboardingInitialized, true);
  }
}

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/constants/constants.dart';
import '../config/router-configs/route_names.dart';

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

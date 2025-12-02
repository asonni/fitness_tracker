import 'package:fitness_tracker/config/router-configs/route_names.dart';
import 'package:fitness_tracker/services/auth_service.dart';
import 'package:fitness_tracker/utils/app_snackbars.dart';
import 'package:get/get.dart';

class WorkoutListController extends GetxController {
  final _authService = Get.find<AuthService>();

  Future<void> signOut() async {
    try {
      await _authService.signOut();
      Get.offAllNamed(RouteNames.signin);
    } catch (e) {
      AppSnackbars.errorSnackbar(
        title: 'Error Signing out',
        message: e.toString(),
      );
    }
  }
}

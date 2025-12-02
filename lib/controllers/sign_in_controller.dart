import 'package:fitness_tracker/config/router-configs/route_names.dart';
import 'package:fitness_tracker/services/auth_service.dart';
import 'package:fitness_tracker/utils/app_snackbars.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SignInController extends GetxController {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final RxBool isLoading = false.obs;
  final _authService = Get.find<AuthService>();

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> onSignIn() async {
    if (formKey.currentState?.validate() != true) return;
    isLoading.value = true;
    try {
      await _authService.signIn(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Get.offAllNamed(RouteNames.workoutList);
    } catch (e) {
      AppSnackbars.errorSnackbar(title: 'Sign In Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

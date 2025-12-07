import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../utils/app_snackbars.dart';
import '../services/auth_service.dart';
import '../config/router-configs/route_names.dart';

class SignInController extends GetxController {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final _authService = Get.put(AuthService());
  final RxBool isLoading = false.obs;

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
      Get.offAllNamed(RouteNames.main);
    } catch (e) {
      // Handle sign-in error
      AppSnackbars.errorSnackbar(title: 'Sign In Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

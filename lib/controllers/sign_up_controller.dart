import 'package:fitness_tracker/models/user_model.dart';
import 'package:fitness_tracker/services/auth_service.dart';
import 'package:fitness_tracker/utils/app_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final _authService = Get.find<AuthService>();
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late final TextEditingController phoneController;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  Future<void> onSignUp() async {
    if (formKey.currentState?.validate() != true) return;

    isLoading.value = true;

    try {
      await _authService.signUp(
        UserModel(
          id: '',
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          phoneNumber: phoneController.text.trim(),
          password: passwordController.text.trim(),
        ),
      );
      Get.back();
      AppSnackbars.successSnackbar(
        title: 'Sign Up Successful',
        message: 'Your account has been created successfully.',
      );
    } catch (e) {
      AppSnackbars.errorSnackbar(title: 'Sign Up Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

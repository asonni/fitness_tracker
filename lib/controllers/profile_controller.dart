import 'package:get/get.dart';
import 'package:flutter/widgets.dart';

import '../models/user_model.dart';
import '../utils/app_snackbars.dart';
import '../services/auth_service.dart';
import '../services/profile_service.dart';
import '../config/router-configs/route_names.dart';

class ProfileController extends GetxController {
  final RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final _profileService = Get.put(ProfileService());
  final Rx<UserModel> currentUser = Rx<UserModel>(UserModel.empty());

  late final TextEditingController nameController;
  late final TextEditingController bioController;
  late final TextEditingController phoneController;

  final _authService = Get.find<AuthService>();

  @override
  void onInit() async {
    super.onInit();
    nameController = TextEditingController();
    bioController = TextEditingController();
    phoneController = TextEditingController();
    getCurrentUser();
  }

  @override
  void onClose() {
    nameController.dispose();
    bioController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  Future<void> updateProfile() async {
    if (formKey.currentState?.validate() != true) return;

    isLoading.value = true;
    try {
      final updatedUser = UserModel(
        id: currentUser.value.id,
        name: nameController.text.trim(),
        bio: bioController.text.trim(),
        phoneNumber: phoneController.text.trim(),
        email: currentUser.value.email,
      );
      // Simulate a network call or database update
      await _profileService.updateProfile(updatedUser);
      // Update profile logic goes here
      currentUser.value = updatedUser;
      Get.back();
      AppSnackbars.successSnackbar(
        title: 'Profile Updated',
        message: 'Your profile has been updated successfully.',
      );
    } catch (e) {
      AppSnackbars.errorSnackbar(
        title: 'Update Failed',
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getCurrentUser() async {
    try {
      final user = await _authService.getSignedInUser();
      nameController.text = user.name;
      bioController.text = user.bio ?? '';
      phoneController.text = user.phoneNumber;
      currentUser.value = user;
    } catch (e) {
      AppSnackbars.errorSnackbar(
        title: 'Error fetching user',
        message: e.toString(),
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _authService.signOut();
      Get.offAllNamed(RouteNames.signin);
    } catch (e) {
      AppSnackbars.errorSnackbar(
        title: 'Error signing out',
        message: e.toString(),
      );
    }
  }
}

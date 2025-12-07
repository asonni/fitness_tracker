import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../utils/validators.dart';
import '../widgets/app_button.dart';
import '../widgets/circular_indicator.dart';
import '../controllers/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          Obx(() {
            return IconButton(
              icon: profileController.isLoading.value
                  ? const CircularIndicator(width: 24, height: 24)
                  : const Icon(Icons.save),
              onPressed: profileController.isLoading.value
                  ? null
                  : profileController.updateProfile,
            );
          }),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: profileController.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: profileController.nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                textInputAction: TextInputAction.next,
                validator: Validators.validateName,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: profileController.phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number',
                  prefixIcon: const Icon(Icons.phone_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  errorMaxLines: 3,
                ),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                validator: Validators.validatePhoneNumber,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: profileController.bioController,
                decoration: const InputDecoration(
                  labelText: 'Bio',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: 24),
              Obx(() {
                return AppButton(
                  text: 'Save Changes',
                  isLoading: profileController.isLoading.value,
                  onPressed: () {
                    if (profileController.isLoading.value) return;
                    profileController.updateProfile();
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

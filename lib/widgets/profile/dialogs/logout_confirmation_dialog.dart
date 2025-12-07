import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../controllers/profile_controller.dart';

Future<void> showLogoutConfirmationDialog(BuildContext context) async {
  Future<void> signOut() async {
    final profileController = Get.find<ProfileController>();
    await profileController.signOut();
  }

  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          CupertinoDialogAction(
            child: const Text("Cancel"),
            onPressed: () => Get.back(),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text("Logout"),
            onPressed: () {
              Get.back();
              signOut();
            },
          ),
        ],
      ),
    );
  }

  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Logout"),
      content: const Text("Are you sure you want to logout?"),
      actions: [
        TextButton(child: const Text("Cancel"), onPressed: () => Get.back()),
        TextButton(
          child: const Text("Logout", style: TextStyle(color: Colors.red)),
          onPressed: () {
            Get.back();
            signOut();
          },
        ),
      ],
    ),
  );
}

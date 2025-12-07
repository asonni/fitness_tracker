import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../enums/workout_type.dart';
import '../utils/app_snackbars.dart';
import 'workout_list_controller.dart';

class WorkoutFormDialogController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final _workoutListController = Get.find<WorkoutListController>();

  late final TextEditingController nameController;
  late final TextEditingController weightController;
  late final TextEditingController repsController;
  late final TextEditingController setsController;

  WorkoutType selectedType = WorkoutType.upperBody;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    weightController = TextEditingController();
    repsController = TextEditingController();
    setsController = TextEditingController();
  }

  @override
  void onClose() {
    nameController.dispose();
    weightController.dispose();
    repsController.dispose();
    setsController.dispose();
    super.onClose();
  }

  Future<void> submitForm() async {
    if (formKey.currentState?.validate() != true) return;
    final name = nameController.text.trim();
    final weight = double.tryParse(weightController.text.trim()) ?? 0.0;
    final reps = int.tryParse(repsController.text.trim()) ?? 0;
    final sets = int.tryParse(setsController.text.trim()) ?? 0;
    final success = await _workoutListController.addWorkout(
      name: name,
      weight: weight,
      reps: reps,
      sets: sets,
      type: selectedType,
    );
    if (!success) return;
    // Close dialog
    Get.back();
    // Show success snackbar
    AppSnackbars.successSnackbar(
      title: 'Workout Added',
      message: 'The workout has been successfully added.',
    );
    // clear form
    nameController.clear();
    weightController.clear();
    repsController.clear();
    setsController.clear();
    selectedType = WorkoutType.upperBody;
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/workout_form_dialog_controller.dart';
import '../enums/workout_type.dart';
import '../utils/validators.dart';

class WorkoutFormDialog extends StatelessWidget {
  const WorkoutFormDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final workoutFormCtl = Get.put(WorkoutFormDialogController());
    return AlertDialog(
      title: const Text('Add Workout'),
      content: Form(
        key: workoutFormCtl.formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: workoutFormCtl.nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) =>
                    Validators.validateEmptyField(value, 'Name'),
              ),
              TextFormField(
                controller: workoutFormCtl.weightController,
                decoration: const InputDecoration(labelText: 'Weight (kg)'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    Validators.validateEmptyField(value, 'Weight'),
              ),
              TextFormField(
                controller: workoutFormCtl.repsController,
                decoration: const InputDecoration(labelText: 'Reps'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    Validators.validateEmptyField(value, 'Reps'),
              ),
              TextFormField(
                controller: workoutFormCtl.setsController,
                decoration: const InputDecoration(labelText: 'Sets'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    Validators.validateEmptyField(value, 'Sets'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<WorkoutType>(
                initialValue: workoutFormCtl.selectedType,
                onChanged: (value) {
                  if (value != null) {
                    workoutFormCtl.selectedType = value;
                  }
                },
                items: const [
                  DropdownMenuItem(
                    value: WorkoutType.upperBody,
                    child: Text('Upper Body'),
                  ),
                  DropdownMenuItem(
                    value: WorkoutType.lowerBody,
                    child: Text('Lower Body'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            workoutFormCtl.submitForm();
            Get.back();
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}

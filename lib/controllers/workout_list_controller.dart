import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../enums/workout_type.dart';
import '../utils/app_snackbars.dart';
import '../models/workout_model.dart';
import '../services/workout_service.dart';

class WorkoutListController extends GetxController {
  static WorkoutListController get instance =>
      Get.find<WorkoutListController>();

  final _workoutService = Get.put(WorkoutService());

  final RxBool isLoading = false.obs;
  final RxBool isAdding = false.obs;
  final RxBool isDeleting = false.obs;
  final RxList<WorkoutModel> workouts = <WorkoutModel>[].obs;
  String selectedWorkoutId = '';

  @override
  void onInit() {
    getWorkouts();
    super.onInit();
  }

  Future<void> getWorkouts() async {
    isLoading.value = true;
    try {
      final fetchedWorkouts = await _workoutService.getWorkouts();
      workouts.assignAll(fetchedWorkouts);
    } catch (e) {
      AppSnackbars.errorSnackbar(
        title: 'Error fetching workouts',
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> addWorkout({
    required String name,
    required double weight,
    required int reps,
    required int sets,
    required WorkoutType type,
  }) async {
    isAdding.value = true;
    final workout = WorkoutModel(
      id: const Uuid().v4(),
      name: name,
      weight: weight,
      reps: reps,
      sets: sets,
      type: type,
      isCompleted: false,
      createdAt: DateTime.now(),
    );
    try {
      await _workoutService.addWorkout(workout);
      workouts.add(workout);
      return true;
    } catch (e) {
      AppSnackbars.errorSnackbar(
        title: 'Error adding workout',
        message: e.toString(),
      );
      return false;
    } finally {
      isAdding.value = false;
    }
  }

  Future<void> deleteWorkout(String workoutId) async {
    selectedWorkoutId = workoutId;
    isDeleting.value = true;
    try {
      await _workoutService.deleteWorkout(workoutId);
      workouts.removeWhere((workout) => workout.id == workoutId);
      AppSnackbars.successSnackbar(
        title: 'Workout Deleted',
        message: 'The workout has been successfully deleted.',
      );
    } catch (e) {
      AppSnackbars.errorSnackbar(
        title: 'Error deleting workout',
        message: e.toString(),
      );
    } finally {
      isDeleting.value = false;
      selectedWorkoutId = '';
    }
  }

  Future<void> toggleWorkout(WorkoutModel workout) async {
    try {
      final updatedWorkout = workout.copyWith(
        isCompleted: !workout.isCompleted,
        completedAt: workout.isCompleted ? null : DateTime.now(),
      );
      await _workoutService.updateWorkout(updatedWorkout);
      final index = workouts.indexWhere((element) => element.id == workout.id);
      if (index != -1) {
        workouts[index] = updatedWorkout;
      }
    } catch (e) {
      AppSnackbars.errorSnackbar(
        title: 'Error updating workout',
        message: e.toString(),
      );
    }
  }
}

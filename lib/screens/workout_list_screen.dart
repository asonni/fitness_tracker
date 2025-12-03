import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/workout_list_controller.dart';
import '../enums/workout_type.dart';
import '../widgets/circular_indicator.dart';
import '../widgets/workout_form_dialog.dart';
import '../widgets/workout_calendar_graph.dart';

class WorkoutListScreen extends StatelessWidget {
  const WorkoutListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final workoutController = Get.put(WorkoutListController());
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const SizedBox.shrink(),
          toolbarHeight: 170,
          flexibleSpace: SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 56.0, left: 16.0, right: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        workoutController.signOut();
                      },
                      icon: Icon(Icons.logout_outlined),
                    ),
                    WorkoutCalendarGraph(),
                  ],
                ),
              ),
            ),
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(48),
            child: TabBar(
              tabs: [
                Tab(text: 'Upper Body'),
                Tab(text: 'Lower Body'),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            _WorkoutList(type: WorkoutType.upperBody),
            _WorkoutList(type: WorkoutType.lowerBody),
          ],
        ),
        floatingActionButton: Obx(() {
          return FloatingActionButton(
            onPressed: () {
              if (workoutController.isAdding.value) return;
              _showAddWorkoutDialog(context);
            },
            child: workoutController.isAdding.value
                ? const CircularIndicator(color: Colors.black)
                : const Icon(Icons.add),
          );
        }),
      ),
    );
  }

  void _showAddWorkoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const WorkoutFormDialog(),
    );
  }
}

class _WorkoutList extends StatelessWidget {
  final WorkoutType type;

  const _WorkoutList({required this.type});

  @override
  Widget build(BuildContext context) {
    final workoutController = Get.find<WorkoutListController>();

    return Obx(() {
      final workouts = workoutController.workouts
          .where((w) => w.type == type)
          .toList();

      if (workoutController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (workouts.isEmpty) {
        return const Center(child: Text("No workout data"));
      }
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          final workout = workouts[index];
          return Card(
            child: ListTile(
              enabled: false,
              title: Text(
                workout.name,
                style: TextStyle(
                  decoration: workout.isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: workout.isCompleted ? Colors.grey : Colors.white,
                ),
              ),
              subtitle: Text(
                '${workout.sets} sets of ${workout.reps} reps at ${workout.weight} kg',
                style: TextStyle(
                  decoration: workout.isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: workout.isCompleted ? Colors.grey : Colors.white,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: workout.isCompleted,
                    onChanged: (_) {
                      workoutController.toggleWorkout(workout);
                    },
                  ),
                  Obx(() {
                    return IconButton(
                      icon:
                          workoutController.isDeleting.value &&
                              workoutController.selectedWorkoutId == workout.id
                          ? const CircularIndicator()
                          : const Icon(Icons.delete),
                      onPressed: () {
                        workoutController.deleteWorkout(workout.id);
                      },
                    );
                  }),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

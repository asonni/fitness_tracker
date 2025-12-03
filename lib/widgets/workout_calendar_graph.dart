import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/workout_list_controller.dart';

class WorkoutCalendarGraph extends StatelessWidget {
  const WorkoutCalendarGraph({super.key});

  String getDateKey(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }

  double getGraphItemOpacity(int count) {
    return switch (count) {
      0 => .1,
      1 => .4,
      2 => .6,
      3 => .8,
      _ => 1.0,
    };
  }

  Map<String, int> getCountsForWorkouts(List workouts) {
    Map<String, int> countsMap = {};
    for (final workout in workouts) {
      // check if workout is completed .
      if (!workout.isCompleted) {
        continue;
      }
      final completedDate = workout.completedAt;
      final dateKey = getDateKey(completedDate!);
      countsMap[dateKey] = (countsMap[dateKey] ?? 0) + 1;
    }
    return countsMap;
  }

  DateTime getStartDate(List workouts) {
    final initialWorkout = workouts.firstOrNull;
    if (initialWorkout == null) {
      return DateTime.now();
    }
    return initialWorkout.createdAt;
  }

  @override
  Widget build(BuildContext context) {
    final workoutListController = Get.find<WorkoutListController>();
    return Obx(() {
      final workouts = workoutListController.workouts;
      final startDate = getStartDate(workouts);
      final counts = getCountsForWorkouts(workouts);
      return Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Activity Graph',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Text(
                  'Last 30 days',
                  style: TextStyle(
                    fontSize: 11,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Expanded(
              child: Row(
                children: List.generate(31, (index) {
                  final date = startDate.add(Duration(days: index));
                  final dateKey = getDateKey(date);
                  final count = counts[dateKey] ?? 0;
                  final opacity = getGraphItemOpacity(count);

                  return Expanded(
                    child: Tooltip(
                      message:
                          '2 workout${2 != 1 ? 's' : ''} on ${index + 1}/${DateTime.now().month}',
                      child: Container(
                        margin: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: opacity),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      );
    });
  }
}

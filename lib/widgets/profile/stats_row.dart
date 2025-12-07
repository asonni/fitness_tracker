import 'package:flutter/material.dart';

import '../../models/workout_model.dart';

class StatsRow extends StatelessWidget {
  final List<WorkoutModel> workouts;

  const StatsRow({super.key, required this.workouts});

  @override
  Widget build(BuildContext context) {
    final completedWorkouts = workouts.where((w) => w.isCompleted).length;
    final inProgressWorkouts = workouts.where((w) => !w.isCompleted).length;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _StatItem(
            value: '${workouts.length}',
            label: 'Workouts',
            icon: Icons.fitness_center,
          ),
          _StatItem(
            value: '$completedWorkouts',
            label: 'Completed',
            icon: Icons.check_circle,
          ),
          _StatItem(
            value: '$inProgressWorkouts',
            label: 'In Progress',
            icon: Icons.pending,
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const _StatItem({
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}

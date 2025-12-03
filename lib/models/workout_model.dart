import 'package:cloud_firestore/cloud_firestore.dart';

import '../enums/workout_type.dart';

class WorkoutModel {
  final String id;
  final String name;
  final double weight;
  final int reps;
  final int sets;
  final bool isCompleted;
  final WorkoutType type;
  final DateTime createdAt;
  DateTime? completedAt;

  WorkoutModel({
    required this.id,
    required this.name,
    required this.weight,
    required this.reps,
    required this.sets,
    required this.isCompleted,
    required this.type,
    required this.createdAt,
    this.completedAt,
  });

  // empty
  static WorkoutModel empty() {
    return WorkoutModel(
      id: '',
      name: '',
      weight: 0.0,
      reps: 0,
      sets: 0,
      isCompleted: false,
      type: WorkoutType.lowerBody,
      createdAt: DateTime.now(),
      completedAt: null,
    );
  }

  Map<String, dynamic> toDoc() {
    return {
      'id': id,
      'name': name,
      'weight': weight,
      'reps': reps,
      'sets': sets,
      'isCompleted': isCompleted,
      'type': type.name,
      'createdAt': createdAt,
      'completedAt': completedAt,
    };
  }

  factory WorkoutModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    return WorkoutModel(
      id: data?['id'] as String? ?? '',
      name: data?['name'] as String? ?? '',
      weight: (data?['weight'] as num?)?.toDouble() ?? 0.0,
      reps: data?['reps'] as int? ?? 0,
      sets: data?['sets'] as int? ?? 0,
      isCompleted: data?['isCompleted'] as bool? ?? false,
      type: WorkoutType.values.firstWhere(
        (e) => e.name == (data?['type'] as String? ?? ''),
        orElse: () => WorkoutType.lowerBody,
      ),
      createdAt: (data?['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      completedAt: (data?['completedAt'] as Timestamp?)?.toDate(),
    );
  }

  WorkoutModel copyWith({required bool isCompleted, DateTime? completedAt}) {
    return WorkoutModel(
      id: id,
      name: name,
      weight: weight,
      reps: reps,
      sets: sets,
      isCompleted: isCompleted,
      type: type,
      createdAt: createdAt,
      completedAt: completedAt,
    );
  }
}

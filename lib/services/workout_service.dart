import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/workout_model.dart';

class WorkoutService extends GetxService {
  static WorkoutService get instance => Get.find<WorkoutService>();

  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseFirestore = FirebaseFirestore.instance;

  String? get _userId => _firebaseAuth.currentUser?.uid;

  Future<List<WorkoutModel>> getWorkouts() async {
    try {
      if (_userId == null) {
        throw Exception('User not authenticated');
      }

      final snapshot = await _firebaseFirestore
          .collection('workouts')
          .where('userId', isEqualTo: _userId)
          .get();

      return snapshot.docs.map((doc) => WorkoutModel.fromDoc(doc)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addWorkout(WorkoutModel workout) async {
    try {
      if (_userId == null) {
        throw Exception('User not authenticated');
      }

      final newWorkout = {...workout.toDoc(), 'userId': _userId};

      await _firebaseFirestore
          .collection('workouts')
          .doc(workout.id)
          .set(newWorkout);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateWorkout(WorkoutModel workout) async {
    try {
      if (_userId == null) {
        throw Exception('User not authenticated');
      }

      final updatedWorkout = {...workout.toDoc(), 'userId': _userId};

      await _firebaseFirestore
          .collection('workouts')
          .doc(workout.id)
          .update(updatedWorkout);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteWorkout(String workoutId) async {
    try {
      if (_userId == null) {
        throw Exception('User not authenticated');
      }

      await _firebaseFirestore.collection('workouts').doc(workoutId).delete();
    } catch (e) {
      rethrow;
    }
  }
}

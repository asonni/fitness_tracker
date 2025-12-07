import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class ProfileService extends GetxService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> updateProfile(UserModel updatedUser) async {
    try {
      final user = _firebaseAuth.currentUser;

      if (user == null) {
        throw Exception('User is not authenticated');
      }

      await _firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .update(updatedUser.toDoc());
    } catch (e) {
      rethrow;
    }
  }
}

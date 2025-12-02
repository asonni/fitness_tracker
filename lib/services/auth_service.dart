import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_tracker/models/user_model.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signUp(UserModel user) async {
    try {
      final firebaseUser = UserModel.fromEntity(user);
      // create a user on firebase-auth.
      final cred = await _firebaseAuth.createUserWithEmailAndPassword(
        email: firebaseUser.email,
        password: firebaseUser.password!,
      );

      print(cred);

      if (cred.user == null) {
        throw Exception('User not created');
      }

      final userId = cred.user?.uid;

      if (userId == null) {
        throw Exception('userId is null');
      }

      final newUser = firebaseUser.copyWith(id: userId);

      // save user to firestore.
      await _firebaseFirestore
          .collection('users')
          .doc(userId)
          .set(newUser.toDoc());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getSignedInUser() async {
    try {
      final user = _firebaseAuth.currentUser;

      if (user == null) {
        return UserModel.empty();
      }

      final userId = user.uid;
      final userDoc = await _firebaseFirestore
          .collection('users')
          .doc(userId)
          .get();

      if (!userDoc.exists) {
        return UserModel.empty();
      }

      return UserModel.fromDoc(userDoc);
    } catch (e) {
      rethrow;
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String? password;
  final String? bio;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.password,
    this.bio,
  });

  // empty
  static UserModel empty() {
    return UserModel(
      id: '',
      name: '',
      email: '',
      phoneNumber: '',
      bio: '',
    );
  }

  Map<String, dynamic> toDoc() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'bio': bio,
    };
  }

  factory UserModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    return UserModel(
      id: data?['id'] as String? ?? '',
      name: data?['name'] as String? ?? '',
      email: data?['email'] as String? ?? '',
      phoneNumber: data?['phoneNumber'] as String? ?? '',
      bio: data?['bio'] as String? ?? '',
    );
  }

  factory UserModel.fromEntity(UserModel entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      phoneNumber: entity.phoneNumber,
      password: entity.password,
      bio: entity.bio,
    );
  }

  UserModel copyWith({required String id}) {
    return UserModel(
      id: id,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      bio: bio,
    );
  }
}

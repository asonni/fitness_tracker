import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_tracker/firebase_options.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() async {
  // Ensure that plugin services are initialized before using them
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await _initializeFirebase();

  // Run the main application
  runApp(const App());
}

Future<void> _initializeFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

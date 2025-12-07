import 'package:get/get.dart';

import '../screens/profile_screen.dart';
import '../screens/workout_list_screen.dart';

class MainController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  final screens = [
    const WorkoutListScreen(),
    const ProfileScreen(),
  ];
}

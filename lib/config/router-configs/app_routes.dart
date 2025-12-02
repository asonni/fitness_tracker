import 'package:get/get.dart';

import '../../screens/onboarding_screen.dart';
import 'route_names.dart';
import '../../screens/sign_in_screen.dart';
import '../../screens/sign_up_screen.dart';
import '../../screens/splash_screen.dart';
import '../../screens/workout_list_screen.dart';

class AppRoutes {
  static final getPages = [
    GetPage(
      name: RouteNames.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: RouteNames.onboarding,
      page: () => const OnboardingScreen(),
    ),
    GetPage(
      name: RouteNames.workoutList,
      page: () => const WorkoutListScreen(),
    ),
    GetPage(
      name: RouteNames.signin,
      page: () => const SignInScreen(),
    ),
    GetPage(
      name: RouteNames.signup,
      page: () => const SignUpScreen(),
    ),
  ];
}

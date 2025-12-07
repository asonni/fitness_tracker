import 'package:get/get.dart';

import 'route_names.dart';
import '../../screens/edit_profile_screen.dart';
import '../../screens/help_support_screen.dart';
import '../../screens/notifications_screen.dart';
import '../../screens/settings_screen.dart';
import '../../screens/main_screen.dart';
import '../../screens/splash_screen.dart';
import '../../screens/profile_screen.dart';
import '../../screens/sign_in_screen.dart';
import '../../screens/sign_up_screen.dart';
import '../../screens/onboarding_screen.dart';
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
    GetPage(
      name: RouteNames.profile,
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: RouteNames.main,
      page: () => const MainScreen(),
    ),
    GetPage(
      name: RouteNames.editProfile,
      page: () => const EditProfileScreen(),
    ),
    GetPage(
      name: RouteNames.settings,
      page: () => const SettingsScreen(),
    ),
    GetPage(
      name: RouteNames.notifications,
      page: () => const NotificationsScreen(),
    ),
    GetPage(
      name: RouteNames.helpSupport,
      page: () => const HelpSupportScreen(),
    ),
  ];
}

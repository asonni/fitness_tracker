import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../controllers/profile_controller.dart';
import '../config/router-configs/route_names.dart';
import '../widgets/profile/profile_components.dart';
import '../controllers/workout_list_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profileController = Get.put(ProfileController());
    final workoutController = Get.find<WorkoutListController>();
    final workouts = workoutController.workouts;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            floating: true,
            pinned: true,
            title: Text('Profile'),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 16),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.colorScheme.surface,
                    border: Border.all(
                      color: theme.colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.person_outline,
                      size: 50,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Obx(() {
                    final user = profileController.currentUser.value;
                    return Column(
                      children: [
                        Text(
                          user.name,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (user.bio != null && user.bio!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              user.bio!,
                              style: theme.textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ],
                    );
                  }),
                ),
                const SizedBox(height: 32),
                StatsRow(workouts: workouts),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      ProfileMenuItem(
                        icon: Icons.person_outline,
                        title: 'Edit Profile',
                        onTap: () => Get.toNamed(RouteNames.editProfile),
                      ),
                      ProfileMenuItem(
                        icon: Icons.settings_outlined,
                        title: 'Settings',
                        onTap: () => Get.toNamed(RouteNames.settings),
                      ),
                      ProfileMenuItem(
                        icon: Icons.notifications_outlined,
                        title: 'Notifications',
                        onTap: () => Get.toNamed(RouteNames.notifications),
                      ),
                      ProfileMenuItem(
                        icon: Icons.help_outline,
                        title: 'Help & Support',
                        onTap: () => Get.toNamed(RouteNames.helpSupport),
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        onTap: () => showLogoutConfirmationDialog(context),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        leading: Icon(
                          Icons.logout,
                          color: theme.colorScheme.secondary,
                        ),
                        title: Text(
                          'Sign Out',
                          style: TextStyle(color: theme.colorScheme.secondary),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

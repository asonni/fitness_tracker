import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../config/constants/constants.dart';
import '../controllers/notification_controller.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationController = Get.put(NotificationController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView(
        children: [
          _NotificationSection(
            title: 'Workout Reminders',
            children: [
              Obx(() {
                return _NotificationTile(
                  title: 'Daily Workout Reminder',
                  subtitle: 'Remind me to workout daily',
                  value: notificationController.workoutReminder.value,
                  onChanged: (value) {
                    notificationController.workoutReminder.value = value;
                    notificationController.saveNotificationPreference(
                      hasWorkoutReminder,
                      value,
                    );
                  },
                );
              }),
              Obx(() {
                return _NotificationTile(
                  title: 'Weekly Progress Report',
                  subtitle: 'Send me weekly progress updates',
                  value: notificationController.weeklyProgress.value,
                  onChanged: (value) {
                    notificationController.weeklyProgress.value = value;
                    notificationController.saveNotificationPreference(
                      hasWeeklyProgress,
                      value,
                    );
                  },
                );
              }),
            ],
          ),
          _NotificationSection(
            title: 'System Notifications',
            children: [
              Obx(() {
                return _NotificationTile(
                  title: 'Push Notifications',
                  subtitle: 'Enable push notifications',
                  value: notificationController.pushNotifications.value,
                  onChanged: (value) {
                    notificationController.pushNotifications.value = value;
                    notificationController.saveNotificationPreference(
                      hasPushNotifications,
                      value,
                    );
                  },
                );
              }),
              Obx(() {
                return _NotificationTile(
                  title: 'Email Notifications',
                  subtitle: 'Receive email notifications',
                  value: notificationController.emailNotifications.value,
                  onChanged: (value) {
                    notificationController.emailNotifications.value = value;
                    notificationController.saveNotificationPreference(
                      hasEmailNotifications,
                      value,
                    );
                  },
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}

class _NotificationSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _NotificationSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        ...children,
      ],
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _NotificationTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
    );
  }
}

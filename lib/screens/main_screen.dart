import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../controllers/main_controller.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mainController = Get.put(MainController());
    return Obx(() {
      return Scaffold(
        body: mainController.screens[mainController.selectedIndex.value],
        bottomNavigationBar: NavigationBar(
          selectedIndex: mainController.selectedIndex.value,
          onDestinationSelected: (index) {
            mainController.selectedIndex.value = index;
          },
          destinations: const [
            NavigationDestination(
              label: 'Home',
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
            NavigationDestination(
              label: 'Profile',
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    });
  }
}

import 'package:fitness_tracker/config/router-configs/route_names.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '/controllers/sign_in_controller.dart';
import '../utils/validators.dart';
import '../widgets/app_button.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInController());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                Icon(
                  Icons.fitness_center,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 24),
                Text(
                  'Welcome Back!',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign in to continue your fitness journey',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                TextFormField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    errorMaxLines: 3,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) => Validators.validateEmail(value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    errorMaxLines: 3,
                  ),
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  validator: (value) => Validators.validatePassword(value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onFieldSubmitted: (_) => controller.onSignIn(),
                ),
                const SizedBox(height: 24),
                Obx(() {
                  return AppButton(
                    text: 'Sign In',
                    onPressed: controller.onSignIn,
                    isLoading: controller.isLoading.value,
                  );
                }),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    controller.formKey.currentState?.reset();
                    controller.emailController.clear();
                    controller.passwordController.clear();
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => const SignUpScreen(),
                    //   ),
                    // );
                    Get.toNamed(RouteNames.signup);
                  },
                  child: Text.rich(
                    TextSpan(
                      text: 'Don\'t have an account? ',
                      children: [
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

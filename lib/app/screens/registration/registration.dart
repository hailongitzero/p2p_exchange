import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p2p_exchange/app/controllers/registration_controller.dart';

class RegistrationPage extends StatelessWidget {
  final RegistrationController controller = Get.put(RegistrationController());

  RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/assets/images/logo.png', height: 100),
            const SizedBox(height: 20),
            TextField(
              controller: controller.emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 20),
            Obx(() => TextField(
                  controller: controller.passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(controller.isPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                  ),
                  obscureText: !controller.isPasswordVisible.value,
                )),
            const SizedBox(height: 20),
            Obx(() => TextField(
                  controller: controller.confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    suffixIcon: IconButton(
                      icon: Icon(controller.isPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                  ),
                  obscureText: !controller.isPasswordVisible.value,
                )),
            const SizedBox(height: 20),
            Obx(() => Text(
                  controller.errorMessage.value,
                  style: const TextStyle(color: Colors.red),
                )),
            Obx(() => CheckboxListTile(
                  value: controller.isAccepted.value,
                  onChanged: controller.toggleAcceptance,
                  title: const Text('Accept Terms and Conditions'),
                )),
            Obx(() => ElevatedButton(
                  onPressed: controller.isAccepted.value
                      ? () => controller.register(context)
                      : null,
                  child: const Text('Register'),
                )),
            const SizedBox(height: 20),
            const Text('Or register with'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.g_translate),
                  onPressed: controller.signInWithGoogle,
                ),
                IconButton(
                  icon: const Icon(Icons.facebook),
                  onPressed: controller.signInWithFacebook,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

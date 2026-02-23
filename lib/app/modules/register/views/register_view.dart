import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../components/my_button.dart';
import '../../../components/my_text_field.dart';
import '../../../routes/app_pages.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.school,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 20),

              MyTextField(hintText: "Name", controller: controller.nameC),
              const SizedBox(height: 15),
              MyTextField(hintText: "Email", controller: controller.emailC),
              const SizedBox(height: 15),
              MyTextField(
                hintText: "Password",
                controller: controller.passwordC,
                obscureText: true,
              ),
              const SizedBox(height: 15),
              MyTextField(
                hintText: "Confirm Password",
                controller: controller.confirmPasswordC,
                obscureText: true,
              ),

              const SizedBox(height: 20),

              MyButton(
                text: "Register",
                onTap: () => controller.register(context),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.LOGIN);
                    },
                    child: Text("login", style: TextStyle(color: Colors.grey)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

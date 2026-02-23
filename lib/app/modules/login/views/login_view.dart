import 'package:expenses_tracker/app/constants/app_color.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../components/my_button.dart';
import '../../../components/my_text_field.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.account_balance_wallet,
                size: 80,
                color: AppColor.primary
              ),
              const SizedBox(height: 20),
              MyTextField(hintText: "Email", controller: controller.emailC),
              const SizedBox(height: 15),
              MyTextField(
                hintText: "Password",
                controller: controller.passwordC,
                obscureText: true,
              ),
              const SizedBox(height: 15),
              MyButton(text: "Login", onTap: () => controller.login(context)),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.clearField();
                      Get.toNamed(Routes.REGISTER);
                    },
                    child: const Text(
                      "register",
                      style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),
                    ),
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

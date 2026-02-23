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
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 80),

              /// Logo
              Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  color: AppColor.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.account_balance_wallet_rounded,
                  size: 45,
                  color: AppColor.primary,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColor.textPrimary,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                "Login to continue tracking",
                style: TextStyle(fontSize: 14, color: AppColor.textSecondary),
              ),

              const SizedBox(height: 40),

              MyTextField(hintText: "Email", controller: controller.emailC),

              const SizedBox(height: 18),

              MyTextField(
                hintText: "Password",
                controller: controller.passwordC,
                obscureText: true,
              ),

              const SizedBox(height: 30),

              MyButton(text: "Login", onTap: () => controller.login(context)),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: AppColor.textSecondary),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.clearField();
                      Get.toNamed(Routes.REGISTER);
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        color: AppColor.primary,
                        fontWeight: FontWeight.w600,
                      ),
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

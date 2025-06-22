import 'package:expenses_tracker/screens/login/login_screen.dart';
import 'package:expenses_tracker/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthService _authService = AuthService();
  final isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> register() async {
    final name = fullNameController.text.trim();
    final email = emailController.text.trim();
    final pw = passwordController.text.trim();

    if (name.isEmpty) {
      Get.snackbar("error", "please fill name field");
      return;
    }

    if (email.isEmpty) {
      Get.snackbar("error", "please fill email field");
      return;
    } else if (!email.endsWith("@gmail.com")) {
      Get.snackbar("error", "please enter an email");
      return;
    }
    if (pw.isEmpty) {
      Get.snackbar("error", "please fill password field");
      return;
    }
    try {
      final user = await _authService.register(name, email, pw);

      if (user != null) {
        Get.snackbar("Success", "Account registered!");
        print("UNTIL HERE REGISTER?");
        Get.to(() => LoginScreen());
      }
    } catch (e) {
      Get.snackbar("Register Failed", e.toString());
      // print(e);
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

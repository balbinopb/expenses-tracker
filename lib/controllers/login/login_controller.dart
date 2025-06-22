import 'package:expenses_tracker/screens/home/home_screen.dart';
import 'package:expenses_tracker/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'base_login_controller.dart';

class LoginController extends GetxController implements BaseLoginController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isVissibility = true.obs;

  final AuthService _authService = AuthService();

  @override
  void togglePwVisibility() {
    isVissibility.value = !isVissibility.value;
  }

  @override
  void login() async {
    final email = emailController.text.trim();
    final pw = passwordController.text.trim();

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
      final user = await _authService.login(email, pw);

      if (user != null) {
        Get.snackbar("success", "Login succesfull");
        print("UNTIL HERE LOGIN?");
        Get.offAll(() => HomeScreen());
      }
    } catch (e) {
      Get.snackbar("login failed","",snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

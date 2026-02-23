import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../data/services/auth_service.dart';
import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController confirmPasswordC = TextEditingController();

  final AuthService _authService = AuthService();

  final isLoading = false.obs;

  bool validation() {
    final name = nameC.text.trim();
    final email = emailC.text.trim();
    final password = passwordC.text.trim();
    final confirmPassword = confirmPasswordC.text.trim();

    if (name.isEmpty) {
      showError("Name cannot be empty");
      return false;
    }

    if (email.isEmpty) {
      showError("Email cannot be empty");
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      showError("Invalid email");
      return false;
    }

    if (password.isEmpty) {
      showError("Password cannot be empty");
      return false;
    }

    if (password != confirmPassword) {
      showError("Password and confirmation must match");
      return false;
    }

    return true;
  }

  Future<void> register(BuildContext context) async {
    if (!validation()) return;

    try {
      isLoading.value = true;

      Get.dialog(
        Center(child: Lottie.asset('assets/lottie/loading.json', width: 120)),
        barrierDismissible: false,
      );

      await _authService.createUserWithEmailPassword(
        email: emailC.text.trim(),
        password: passwordC.text.trim(),
        name: nameC.text.trim(),
      );
      // print("---------------success------------");

      Get.back(); // close loading
      Get.toNamed(Routes.LOGIN);
    } on FirebaseAuthException catch (e) {
      Get.back(); //to ensure the dialog closed

      showError(e.message ?? "An error occurred");
    } finally {
      isLoading.value = false;
    }
  }

  void showError(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade400,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }

  @override
  void onClose() {
    nameC.dispose();
    emailC.dispose();
    passwordC.dispose();
    confirmPasswordC.dispose();
    super.onClose();
  }
}

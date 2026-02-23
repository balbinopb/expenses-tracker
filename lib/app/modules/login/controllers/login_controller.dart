import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../data/services/auth_service.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  final AuthService _authService = AuthService();

  // Error state
  // final emailError = RxnString();
  // final passwordError = RxnString();

  // Loading state
  final isLoading = false.obs;

  bool validation() {
    final email = emailC.text.trim();
    final password = passwordC.text.trim();

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

    return true;
  }

  Future<void> login(BuildContext context) async {
    if (!validation()) return;

    try {
      isLoading.value = true;

      // show loading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Center(
          child: Lottie.asset('assets/lottie/loading.json', width: 120),
        ),
      );

      await _authService.signInWithEmailPassword(
        email: emailC.text.trim(),
        password: passwordC.text.trim(),
      );

      // show loading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Center(
          child: Lottie.asset('assets/lottie/success.json', width: 120),
        ),
      );

      await Future.delayed(Duration(seconds: 2));

      Get.offAndToNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      Get.back();
      // print("--------------${e.message}-------------------------");
      Get.snackbar(
        "Login Failed",
        e.message ?? "An error occurred",
        backgroundColor: Colors.red.shade400,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      if (Get.isDialogOpen ?? false) {
        Get.back(); // always close dialog
      }
      isLoading.value = false;
    }
  }

  // Future<void> logout() async {
  //   await _authService.logout();
  //   Get.offAllNamed(Routes.LOGIN);
  // }

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
    emailC.dispose();
    passwordC.dispose();
    super.onClose();
  }
}

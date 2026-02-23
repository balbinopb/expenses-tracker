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
      Get.snackbar(
        "Erro",
        "Email seidauk prenxe",
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar(
        "Erro",
        "Email invalidu",
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar(
        "Erro",
        "Password seidauk prenxe",
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    return true;
  }

  Future<void> login(BuildContext context) async {
    if (!validation()) return;
    try {
      isLoading.value = true;

      // loading animation
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

      // close loading
      Get.back();
      Get.offAndToNamed(Routes.HOME);
    } on FirebaseAuthException {
      Get.snackbar(
        "Falha no Login",
        "Ocorreu um erro",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> logout() async {
  //   await _authService.logout();
  //   Get.offAllNamed(Routes.LOGIN);
  // }

  @override
  void onClose() {
    emailC.dispose();
    passwordC.dispose();
    super.onClose();
  }
}

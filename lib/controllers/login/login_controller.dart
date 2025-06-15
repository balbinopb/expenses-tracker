
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'base_login_controller.dart';

class LoginController extends GetxController implements BaseLoginController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isVissibility=true.obs;

  @override
  void togglePwVisibility() {
    isVissibility.value = !isVissibility.value;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

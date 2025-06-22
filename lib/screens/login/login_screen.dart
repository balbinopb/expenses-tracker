import 'package:expenses_tracker/controllers/login/login_controller.dart';
import 'package:expenses_tracker/screens/register/register_screen.dart';
import 'package:expenses_tracker/widgets/button_custom.dart';
import 'package:expenses_tracker/widgets/textfield_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  final double distance = 10;
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding:  EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextfieldCustom(
                  labelText: "Email",
                  controller: controller.emailController,
                  onChanged: (val) {},
                ),
                SizedBox(height: distance),
                Obx(
                  () => TextfieldCustom(
                    labelText: "Password",
                    controller: controller.passwordController,
                    onChanged: (val) {},
                    obscureText: controller.isVissibility.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isVissibility.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: controller.togglePwVisibility,
                    ),
                  ),
                ),
                SizedBox(height: distance),
                ButtonCustom(text: "Login", onPressed: controller.login),
                SizedBox(height: distance),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? "),
                    InkWell(
                      onTap: () {
                        Get.to(() => RegisterScreen());
                      },
                      child: Text("Register"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

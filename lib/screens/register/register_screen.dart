import 'package:expenses_tracker/controllers/register/register_controller.dart';
import 'package:expenses_tracker/screens/login/login_screen.dart';
import 'package:expenses_tracker/widgets/button_custom.dart';
import 'package:expenses_tracker/widgets/textfield_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends GetView<RegisterController> {

  final controller =Get.put(RegisterController());
  RegisterScreen({super.key});

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
                Text("Register",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                SizedBox(height: 16),
                TextfieldCustom(labelText: "Full name",controller: controller.fullNameController,),
                SizedBox(height: 12),
                TextfieldCustom(labelText: "Email",controller: controller.emailController,),
                SizedBox(height: 12),
                TextfieldCustom(labelText: "Password",controller: controller.passwordController,suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),),
                SizedBox(height: 14),
                ButtonCustom(text: "Register", onPressed: controller.register),
                SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? "),
                    InkWell(
                      onTap: () {
                        Get.to(()=>LoginScreen());
                      },
                      child: Text("Login"),
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

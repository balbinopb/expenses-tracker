import 'package:expenses_tracker/screens/login_screen.dart';
import 'package:expenses_tracker/widgets/button_custom.dart';
import 'package:expenses_tracker/widgets/textfield_custom.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Register",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                SizedBox(height: 16),
                TextfieldCustom(labelText: "Full name"),
                SizedBox(height: 12),
                TextfieldCustom(labelText: "Email"),
                SizedBox(height: 12),
                TextfieldCustom(labelText: "Password"),
                SizedBox(height: 14),
                ButtonCustom(text: "Register", onPressed: () {}),
                SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? "),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webtutorial/controller/auth/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Login"
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: loginController.emailController,
              decoration: InputDecoration(
                  hintText: 'Email'
              ),
            ),
            TextFormField(
              controller: loginController.passController,
              decoration: InputDecoration(
                  hintText: 'Password'
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: ElevatedButton(
                  onPressed: () {
                    loginController.validate();
                  },
                  child: Text('Login')
              ),
            )
          ],
        ),
      ),
    );
  }
}

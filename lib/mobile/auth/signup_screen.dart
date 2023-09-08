import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webtutorial/controller/auth/signup_controller.dart';
import 'package:webtutorial/utils/routes_constant.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignUpController signUpController = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Signup"
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: signUpController.nameController,
              decoration: const InputDecoration(
                  hintText: 'Name'
              ),
            ),
            TextFormField(
              controller: signUpController.emailController,
              decoration: const InputDecoration(
                hintText: 'Email'
              ),
            ),
            TextFormField(
              controller: signUpController.passController,
              decoration: const InputDecoration(
                hintText: 'Password'
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: ElevatedButton(
                onPressed: () {
                  signUpController.validate();
                },
                child: const Text('Sign Up')
              ),
            ),

            GestureDetector(
              onTap: (){
                Get.toNamed(LOGIN_SCREEN);
              },
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Already Registered "
                    ),
                    TextSpan(
                      text: "Login"
                    ),
                  ]
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}

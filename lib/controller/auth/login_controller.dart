import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webtutorial/utils/routes_constant.dart';

class LoginController extends GetxController{
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  validate(){
     if(emailController.text.isEmpty){
      Get.snackbar('Error', "email cannot be empty",backgroundColor: Colors.red);
    }else if(passController.text.isEmpty){
      Get.snackbar('Error', "pass cannot be empty",backgroundColor: Colors.red);
    }else {
      loginUser();
    }
  }


  loginUser() async {
    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passController.text.trim()
      );
      Get.snackbar('Success', "${userCredential.additionalUserInfo?.username}");
      Get.toNamed(BASE_SCREEN);
    }on FirebaseAuthException catch(e){
      // if(e.code == 'weak-password'){
      Get.snackbar('Error', "${e.message!}",backgroundColor: Colors.red);
      // }
    }
  }
}
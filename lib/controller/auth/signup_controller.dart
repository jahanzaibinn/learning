import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webtutorial/utils/routes_constant.dart';

class SignUpController extends GetxController{
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController passController = TextEditingController();

  validate(){
    if(nameController.text.isEmpty){
      Get.snackbar('Error', " name cannot be empty",backgroundColor: Colors.red);
    }else if(emailController.text.isEmpty){
      Get.snackbar('Error', "email cannot be empty",backgroundColor: Colors.red);
    }else if(passController.text.isEmpty){
      Get.snackbar('Error', "pass cannot be empty",backgroundColor: Colors.red);
    }else {
      registerUser();
    }
  }


  registerUser() async {
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passController.text.trim()
      );
      FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'name': nameController.text.trim(),
        'email': emailController.text.trim()
      });
      Get.snackbar('Success', "${userCredential.additionalUserInfo?.authorizationCode}");
      Get.toNamed(BASE_SCREEN);
    }on FirebaseAuthException catch(e){
      // if(e.code == 'weak-password'){
        Get.snackbar('Error', "${e.message!}",backgroundColor: Colors.red);
      // }
    }
  }
}
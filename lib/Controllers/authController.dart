import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Pages/Auth/signin.dart';
import '../widgets/showSnackBar.dart';

class AuthController {
  login(
    BuildContext context,
    TextEditingController emailEditingController,
    TextEditingController passwordEditingController,
  ) async {
    String email = emailEditingController.text.trim();
    String password = passwordEditingController.text.trim();
    if (email == "" || password == "") {
      showSnackBar(context, 'Please fill all the fields');
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(
            context,
            '/home',
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          showSnackBar(context, 'Invalid Credentials');
        }
      }
    }
  }

  createAccount(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController confirmPasswordController,
  ) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();
    if (email == "" || password == "") {
      showSnackBar(context, 'Please fill all the fields');
    } else if (password != confirmPassword) {
      showSnackBar(context, 'Passwords do not match');
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => signIn()));
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          showSnackBar(context, 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          showSnackBar(context, 'The account already exists for that email.');
        }
      }
    }
  }
}

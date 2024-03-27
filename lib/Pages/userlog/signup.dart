// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:finance_manager/Pages/userlog/signin.dart';
import 'package:finance_manager/widgets/input_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class signUp extends StatefulWidget {
  const signUp({super.key});

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  bool visiblep = true;
  bool visiblecp = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void createAccount() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();
    if (email == "" || password == "") {
      log("Please filled the details");
    } else if (password != confirmPassword) {
      log('Password does not match');
    } else {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      log("user created");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(top: 50, left: 10, right: 10),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(
                "TRACKIZER",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 160,
              ),
              Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('E-mail address')),
              SizedBox(
                height: 5,
              ),
              InputTextFieldWidget(emailController, 'E-mail address'),
              SizedBox(
                height: 15,
              ),
              Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Password')),
              SizedBox(
                height: 5,
              ),
              InputTextFieldWidget(passwordController, 'Password',
                  passwordField: true),
              SizedBox(
                height: 15,
              ),
              Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Confirm Password')),
              SizedBox(
                height: 5,
              ),
              InputTextFieldWidget(
                  confirmPasswordController, 'Confirm Password',
                  passwordField: true),
              SizedBox(
                height: 70,
              ),
              TextButton(
                onPressed: () {
                  createAccount();
                },
                child: Text(
                  'Get started',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                style: TextButton.styleFrom(
                    shadowColor: Colors.redAccent,
                    elevation: 15,
                    fixedSize: Size(340, 45),
                    side: BorderSide(width: 1, color: Colors.redAccent),
                    backgroundColor: Colors.redAccent),
              ),
              SizedBox(
                height: 50,
              ),
              Text('Do you have already an account?'),
              SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => signIn()));
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                style: TextButton.styleFrom(
                    shadowColor: Color.fromARGB(255, 0, 0, 0),
                    elevation: 15,
                    fixedSize: Size(320, 45),
                    side: BorderSide(
                        width: 1, color: Color.fromARGB(255, 55, 54, 54)),
                    backgroundColor: Color.fromARGB(255, 44, 44, 44)),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

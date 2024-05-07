// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:finance_manager/Controllers/authController.dart';
import 'package:finance_manager/widgets/input_fields.dart';
import 'package:finance_manager/widgets/submit_button.dart';
import 'package:flutter/material.dart';

import 'signup_option.dart';

class signIn extends StatefulWidget {
  const signIn({super.key});

  @override
  State<signIn> createState() => _signInState();
}

class _signInState extends State<signIn> {
  bool isCheck = false;
  bool isloading = false;
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  AuthController authController = AuthController();

  void handleSignIn() async {
    setState(() {
      isloading = true;
    });

    await authController.login(context, emailEditingController.text.trim(),
        passwordEditingController.text.trim());

    setState(() {
      isloading = false;
    });
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
              InputTextFieldWidget(emailEditingController, 'Email Address'),
              SizedBox(
                height: 15,
              ),
              Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Password')),
              SizedBox(
                height: 5,
              ),
              InputTextFieldWidget(passwordEditingController, 'Password',
                  passwordField: true),
              SizedBox(
                height: 8,
              ),
              Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: GestureDetector(
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16,
                      ),
                    ),
                  )),
              SizedBox(
                height: 8,
              ),
              SubmitButton(
                  onPressed: () => handleSignIn(),
                  title: 'Sign In',
                  loading: isloading,
                  color: Colors.redAccent,
                  textsize: 20),
              SizedBox(
                height: 160,
              ),
              Text("If you don't have an account yet?"),
              SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => signupOption()));
                },
                child: Text(
                  'Sign Up',
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

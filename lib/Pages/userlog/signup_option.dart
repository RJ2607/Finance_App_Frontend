// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:finance_manager/Pages/userlog/signin.dart';
import 'package:finance_manager/Pages/userlog/signup.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class signupOption extends StatefulWidget {
  const signupOption({super.key});

  @override
  State<signupOption> createState() => _signupOptionState();
}

class _signupOptionState extends State<signupOption> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 60),
        child: Center(
          child: Column(
            children: [
              Text('TRACKIZER',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w500)),
              SizedBox(
                height: 240,
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Bootstrap.github,
                      color: Colors.white,
                      size: 25,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      'Sign Up with GitHub',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
                style: TextButton.styleFrom(
                    shadowColor: Color.fromARGB(255, 0, 0, 0),
                    elevation: 15,
                    fixedSize: Size(320, 50),
                    side: BorderSide(
                        width: 1, color: Color.fromARGB(255, 0, 0, 0)),
                    backgroundColor: Color.fromARGB(255, 0, 0, 0)),
              ),
              SizedBox(
                height: 15,
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Bootstrap.google,
                      color: Colors.black,
                      size: 25,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      'Sign Up with Google',
                      style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ],
                ),
                style: TextButton.styleFrom(
                    shadowColor: Colors.white,
                    elevation: 10,
                    fixedSize: Size(320, 50),
                    side: BorderSide(
                        width: 1, color: Color.fromARGB(255, 255, 255, 255)),
                    backgroundColor: Color.fromARGB(255, 255, 255, 255)),
              ),
              SizedBox(
                height: 15,
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Bootstrap.facebook,
                      color: Colors.white,
                      size: 25,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      'Sign Up with Facebook',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
                style: TextButton.styleFrom(
                    shadowColor: Color.fromARGB(255, 45, 147, 255),
                    elevation: 15,
                    fixedSize: Size(320, 50),
                    side: BorderSide(
                        width: 1, color: Color.fromARGB(255, 45, 147, 255)),
                    backgroundColor: Color.fromARGB(255, 45, 147, 255)),
              ),
              SizedBox(
                height: 35,
              ),
              Text('or',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
              SizedBox(
                height: 35,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => signUp()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Bootstrap.person,
                      color: Colors.white,
                      size: 25,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      'Sign Up with Email',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
                style: TextButton.styleFrom(
                    shadowColor: Color.fromARGB(255, 0, 0, 0),
                    elevation: 15,
                    fixedSize: Size(320, 50),
                    side: BorderSide(
                        width: 3, color: Color.fromARGB(255, 45, 45, 45)),
                    backgroundColor: Color.fromARGB(255, 0, 0, 0)),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => signIn()));
                },
                child: Text(
                  'Already have an account? Sign In',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

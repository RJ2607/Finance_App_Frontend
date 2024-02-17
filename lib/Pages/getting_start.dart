// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:ui';

import 'package:finance_manager/Pages/userlog/signin.dart';
import 'package:finance_manager/Pages/userlog/signup_option.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class GettingStart extends StatefulWidget {
  const GettingStart({super.key});

  @override
  State<GettingStart> createState() => _GettingStartState();
}

class _GettingStartState extends State<GettingStart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 16, 16, 16),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 60,
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                width: MediaQuery.of(context).size.width * 1.7,
                left: 100,
                top: 50,
                child: Image.asset(
                  "assets/Backgrounds/Spline.png",
                ),
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: const SizedBox(),
                ),
              ),
              const RiveAnimation.asset(
                'assets/RiveAssets/shapes.riv',
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                  child: const SizedBox(),
                ),
              ),
              frontDisplay(),
            ],
          ),
        ),
      ),
    );
  }

  Center frontDisplay() {
    return Center(
      child: Column(
        children: [
          Text(
            "TRACKIZER",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 510,
          ),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => signupOption()));
              },
              style: TextButton.styleFrom(
                side: BorderSide(color: Colors.redAccent, width: 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.symmetric(
                  horizontal: 113,
                ),
                backgroundColor: Colors.redAccent,
                shadowColor: const Color.fromARGB(255, 255, 57, 57),
                elevation: 20,
              ),
              child: Text(
                "Get Started",
                style: TextStyle(color: Colors.white, fontSize: 18),
              )),
          const SizedBox(
            height: 20,
          ),
          OutlinedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => signIn(),
                    ));
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.symmetric(
                  horizontal: 88,
                ),
                side: BorderSide(
                    color: Color.fromARGB(255, 255, 255, 255), width: 1),
              ),
              child: Text(
                "I have an account",
                style: TextStyle(color: Colors.white, fontSize: 18),
              )),
        ],
      ),
    );
  }
}

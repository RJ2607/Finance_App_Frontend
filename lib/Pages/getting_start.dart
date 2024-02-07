// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:ui';

import 'package:finance_manager/Pages/userlog/signin.dart';
import 'package:finance_manager/Pages/userlog/signup_option.dart';
import 'package:flutter/material.dart';

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
              Align(
                alignment: const AlignmentDirectional(1.5, -0.2),
                child: Container(
                  height: 160,
                  width: 200,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 248, 39, 39),
                      shape: BoxShape.circle),
                ),
              ),
              Align(
                alignment: const Alignment(1.8, 0.1),
                child: Container(
                  height: 100,
                  width: 200,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 109, 23, 221),
                      shape: BoxShape.circle),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-1.6, 1.1),
                child: Container(
                  height: 160,
                  width: 200,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 157, 41, 41),
                      shape: BoxShape.circle),
                ),
              ),
              Align(
                alignment: const Alignment(-2, -1.4),
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 86, 19, 174),
                      shape: BoxShape.circle),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
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

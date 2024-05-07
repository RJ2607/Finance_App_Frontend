import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/showSnackBar.dart';

class AuthController {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final Map<String, dynamic> defaultData = Map<String, dynamic>();
  login(
    BuildContext context,
    String email,
    String password,
  ) async {
    if (email == "" || password == "") {
      showSnackBar(context, 'Please fill all the fields', Colors.red);
    } else {
      try {
        log('email: $email, password: $password');
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) => {
                  Navigator.popUntil(context, (route) => route.isFirst),
                  Navigator.pushReplacementNamed(
                    context,
                    '/home',
                  )
                });
        // if (userCredential.user != null) {
        //   Navigator.popUntil(context, (route) => route.isFirst);
        //   Navigator.pushReplacementNamed(
        //     context,
        //     '/home',
        //   );
        // }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          showSnackBar(context, 'Invalid Credentials', Colors.red);
        }
      }
    }
  }

  createAccount(BuildContext context, String email, String password,
      String confirmPassword) async {
    if (email == "" || password == "") {
      showSnackBar(context, 'Please fill all the fields', Colors.red);
    } else if (password != confirmPassword) {
      showSnackBar(context, 'Passwords do not match', Colors.red);
    } else {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {
                  // create empty map<string,dynamic>
                  FirebaseAuth.instance.currentUser!
                      .updateDisplayName(value.user!.email!.split('@')[0]),
                  users.doc(value.user!.uid).set(defaultData)
                })
            .then((value) => {
                  Navigator.popUntil(context, (route) => route.isFirst),
                  Navigator.pushReplacementNamed(
                    context,
                    '/home',
                  )
                });
        // if (userCredential.user != null) {
        //   Navigator.push(
        //       context, MaterialPageRoute(builder: (context) => signIn()));
        // }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          showSnackBar(
              context, 'The password provided is too weak.', Colors.red);
        } else if (e.code == 'email-already-in-use') {
          showSnackBar(context, 'The account already exists for that email.',
              Colors.red);
        }
      }
    }
  }

  delete(BuildContext context) async {
    await users
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .delete()
        .then((value) => FirebaseAuth.instance.currentUser!.delete())
        .then((value) => {
              Navigator.popUntil(context, (route) => route.isFirst),
              Navigator.pushReplacementNamed(context, '/gettingStart')
            });
  }
}

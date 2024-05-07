import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_manager/Views/Auth/getting_start.dart';
import 'package:finance_manager/components/bottom_nav.dart';
import 'package:finance_manager/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool login = false;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Raleway', brightness: Brightness.dark),
      initialRoute: (FirebaseAuth.instance.currentUser == null)
          ? '/gettingStart'
          // : '/test',
          : '/home',
      routes: {
        '/gettingStart': (context) => const GettingStart(),
        '/home': (context) => BottomNav(
              tab: 0,
            ),
        '/test': (context) => MyTest()
      },
    );
  }
}

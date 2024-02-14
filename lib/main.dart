import 'package:finance_manager/Pages/getting_start.dart';
import 'package:finance_manager/Pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
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
      initialRoute: login ? '/home' : '/gettingStart',
      routes: {
        '/gettingStart': (context) => const GettingStart(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}

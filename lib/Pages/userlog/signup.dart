// ignore_for_file: prefer_const_constructors

import 'package:finance_manager/Pages/userlog/signin.dart';
import 'package:flutter/material.dart';

class signUp extends StatefulWidget {
  const signUp({super.key});

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  bool visible = true;
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
              SizedBox(
                height: 50,
                width: 340,
                child: TextField(
                  style: TextStyle(),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    labelText: 'E-mail address',
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Password')),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 50,
                width: 340,
                child: TextField(
                  obscureText: visible,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    hintText: "Confirm Password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          visible = !visible;
                        });
                      },
                      icon: Icon(
                          visible ? Icons.visibility : Icons.visibility_off),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(40, 65, 98, 1),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Confirm Password')),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 50,
                width: 340,
                child: TextField(
                  obscureText: visible,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    hintText: "Confirm Password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          visible = !visible;
                        });
                      },
                      icon: Icon(
                          visible ? Icons.visibility : Icons.visibility_off),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(40, 65, 98, 1),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 70,
              ),
              TextButton(
                onPressed: () {},
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

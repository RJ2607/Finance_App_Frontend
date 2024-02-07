// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:finance_manager/Pages/userlog/signup.dart';
import 'package:finance_manager/components/bottom_nav.dart';
import 'package:flutter/material.dart';

class signIn extends StatefulWidget {
  const signIn({super.key});

  @override
  State<signIn> createState() => _signInState();
}

class _signInState extends State<signIn> {
  bool isCheck = false;
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
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                          side: BorderSide(width: 1, color: Colors.grey),
                          value: isCheck,
                          onChanged: (bool? value) {
                            setState(() {
                              isCheck = value!;
                            });
                          }),
                      Text(
                        "Remember me",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      )
                    ],
                  ),
                  Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
              SizedBox(
                height: 4,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => BottomNav())));
                },
                child: Text(
                  'Sign In',
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
                height: 160,
              ),
              Text("If you don't have an account yet?"),
              SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => signUp()));
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

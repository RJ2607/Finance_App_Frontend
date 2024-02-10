// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // create a profile page with a sliver app bar with profile image overlapping the app bar
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            topBar(context),
            SizedBox(
              height: 20,
            ),
            profileImage()
          ],
        ),
      ),
    );
  }

  Row topBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Profile',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w400,
            )),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
              padding: EdgeInsets.fromLTRB(18, 5, 18, 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                '<  Back',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              )),
        ),
      ],
    );
  }

  Stack profileImage() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 180,
          width: 180,
          decoration: BoxDecoration(
            // image: DecorationImage(
            //   image: AssetImage('assets/images/me.jpg'),
            //   fit: BoxFit.cover,
            // ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: -5,
                blurRadius: 25,
              ),
            ],
            shape: BoxShape.circle,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
          child: ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.white30, Colors.white10]),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.4),
                spreadRadius: -5,
                blurRadius: 25,
                offset: Offset(10, 10),
                blurStyle: BlurStyle.normal,
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('assets/images/me.jpg'),
          ),
        ),
        Positioned(
            bottom: 25,
            right: 15,
            child: GestureDetector(
              onTap: () {},
              //create a pencil button to change profile image
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.edit,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ))
      ],
    );
  }
}

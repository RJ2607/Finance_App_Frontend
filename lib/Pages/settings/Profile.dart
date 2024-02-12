// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:finance_manager/Pages/settings/Settings.dart';
import 'package:finance_manager/Pages/settings/edit_profile.dart';
import 'package:flutter/cupertino.dart';
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
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            topBar(context),
            SizedBox(
              height: 10,
            ),
            profileImage(),
            SizedBox(
              height: 5,
            ),
            Text(
              'John Doe',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'xyz123@gmail.com',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditPage()));
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    color: Colors.white.withOpacity(0.3),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  profileOptions(context, 'Settings', CupertinoIcons.settings,
                      true, MySettings(), Colors.white),
                  profileOptions(context, 'Contact Us', CupertinoIcons.phone,
                      true, MySettings(), Colors.white),
                  profileOptions(context, 'Logout', Icons.logout, false,
                      MySettings(), Colors.red),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row profileOptions(BuildContext context, String title, IconData icon,
      bool arrow, Widget page, Color textColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            if (title == 'Logout') {
              Navigator.pop(context);
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              );
            }
          },
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.3),
                ),
                child: Icon(
                  icon,
                  size: 20,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  )),
            ],
          ),
        ),
        arrow
            ? Container(
                padding: EdgeInsets.all(13),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.3),
                ),
                child: Text(
                  '>',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              )
            : Container(
                padding: EdgeInsets.all(13),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                child: Text(
                  '',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
      ],
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
        TweenAnimationBuilder(
          tween: Tween<double>(begin: 1.4, end: 2),
          duration: Duration(seconds: 1),
          builder: (BuildContext context, double value, Widget? child) {
            return Container(
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
                          transform: GradientRotation((value) * 3.14),
                          colors: [Colors.white30, Colors.white10]),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            );
          },
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
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditPage()));
              },
              //create a pencil button to change profile image
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  CupertinoIcons.pencil,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            )),
      ],
    );
  }
}

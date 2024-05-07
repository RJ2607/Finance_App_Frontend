// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'dart:ui';

import 'package:finance_manager/Controllers/authController.dart';
import 'package:finance_manager/Views/settings/Settings.dart';
import 'package:finance_manager/Views/settings/edit_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isloading = false;

  final user = FirebaseAuth.instance.currentUser;
  void logout() async {
    try {
      setState(() {
        isloading = true;
      });
      await FirebaseAuth.instance.signOut().then((value) => {
            Navigator.popUntil(context, (route) => route.isFirst),
            Navigator.pushReplacementNamed(context, '/gettingStart')
          });
    } on FirebaseAuthException catch (e) {
      log(e.code.toString());
    } finally {
      setState(() {
        isloading = false;
      });
    }
  }

  void deleteAccount() async {
    try {
      setState(() {
        isloading = true;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure you want to delete?'),
            content: SingleChildScrollView(
                child: TextButton(
              child: isloading
                  ? CircularProgressIndicator(
                      color: Colors.black,
                      strokeWidth: 2,
                      strokeCap: StrokeCap.round,
                    )
                  : Text('Sure'),
              onPressed: () => AuthController().delete(context),
            )),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      log(e.code.toString());
    } finally {
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
        child: Stack(children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                topBar(context),
                SizedBox(
                  height: 10,
                ),
                ProfileImage(
                    context: context, photoURL: user!.photoURL.toString()),
                SizedBox(
                  height: 5,
                ),
                Text(
                  user!.displayName.toString(),
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  user!.email.toString(),
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
                      profileOptions(
                          context,
                          'Settings',
                          CupertinoIcons.settings,
                          true,
                          MySettings(),
                          Colors.white),
                      profileOptions(
                          context,
                          'Contact Us',
                          CupertinoIcons.phone,
                          true,
                          MySettings(),
                          Colors.white),
                      profileOptions(context, 'Logout', Icons.logout, false,
                          MySettings(), Colors.red),
                      Text(
                        'DANGER ZONE',
                        style: TextStyle(color: Colors.red),
                      ),
                      Divider(
                        color: Colors.red.withOpacity(0.3),
                      ),
                      profileOptions(context, 'Delete Account',
                          CupertinoIcons.trash, false, MySettings(), Colors.red)
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isloading) logoutLoading(),
        ]),
      ),
    );
  }

  Container logoutLoading() {
    return Container(
      alignment: Alignment.center,
      color: Colors.black.withOpacity(0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Colors.white,
            strokeCap: StrokeCap.round,
          ),
          Text(
            'Logging out...',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          )
        ],
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
              logout();
            } else if (title == 'Delete Account') {
              deleteAccount();
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
            Navigator.pushNamed(context, '/home');
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
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.context,
    required this.photoURL,
  });

  final BuildContext context;
  final String? photoURL;

  @override
  Widget build(BuildContext context) {
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
                color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.4),
                spreadRadius: -5,
                blurRadius: 25,
                offset: Offset(10, 10),
                blurStyle: BlurStyle.normal,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: photoURL != null && photoURL!.startsWith('http')
                ? Image.network(
                    photoURL!,
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/default_profile.png', // Provide a default image path
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        Positioned(
            bottom: 25,
            right: 15,
            child: Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.7),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EditPage()));
                },
                icon: Icon(CupertinoIcons.pencil),
                color: Colors.white,
                iconSize: 25,
              ),
            )),
      ],
    );
  }
}

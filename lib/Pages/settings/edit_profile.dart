// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late File _image;
  final imagePicker = ImagePicker();

  Future popUp() async {
    // options for image picker by gallery or camera
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose an option'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: Text('Gallery'),
                  onTap: () {
                    Navigator.pop(context, ImageSource.gallery);
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text('Camera'),
                  onTap: () {
                    Navigator.pop(context, ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              topBar(context),
              SizedBox(
                height: 10,
              ),
              profileImage(),
              SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14, right: 14),
                child: Column(
                  children: [
                    textFields(
                      'Full Name',
                      CupertinoIcons.person,
                      TextInputType.name,
                      false,
                      Colors.white,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    textFields(
                      'Email',
                      CupertinoIcons.mail,
                      TextInputType.emailAddress,
                      false,
                      Colors.white,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    textFields(
                      'Phone No',
                      CupertinoIcons.phone,
                      TextInputType.phone,
                      false,
                      Colors.white,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(1),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Color.fromARGB(255, 64, 64, 64),
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  TextField textFields(String label, IconData icon, TextInputType type,
      bool obsecure, Color color) {
    return TextField(
      style: TextStyle(
        color: color,
      ),
      keyboardType: type,
      obscureText: obsecure,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 17, 20, 17),
        prefixIcon: Icon(
          icon,
          color: color,
        ),
        labelText: label,
        labelStyle: TextStyle(
          color: color,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(34),
        ),
      ),
    );
  }

  Future getImage(value) async {
    final pickedFile = await imagePicker.pickImage(source: value);

    // options for image picker by gallery or camera
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Row topBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Edit Profile',
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
                popUp().then((value) => getImage(value));
              },
              //create a pencil button to change profile image
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  CupertinoIcons.camera,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            )),
      ],
    );
  }
}

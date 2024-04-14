// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui';

import 'package:finance_manager/utils.dart';
import 'package:finance_manager/widgets/submit_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../Controllers/profileController.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  bool isloading = false;
  Uint8List? _image;
  ProfileController _profileController = ProfileController();

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);

    setState(() {
      _image = img;
    });
  }

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
                      nameController,
                      'Full Name',
                      CupertinoIcons.person,
                      TextInputType.name,
                      false,
                      Colors.white,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SubmitButton(
                        onPressed: () => handleUpdateProfile(),
                        // onPressed: () {
                        //   Navigator.pushNamed(context, '/home');
                        // },
                        title: 'Edit Profile',
                        loading: isloading,
                        color: Colors.black,
                        textsize: 20)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void handleUpdateProfile() async {
    setState(() {
      isloading = true;
    });

    String? imageUrl;

    if (_image != null) {
      // Upload image to Firebase Storage
      imageUrl = await _profileController.uploadImageToFirebaseStorage(_image!);
      log('Image URL: $imageUrl');

      if (imageUrl == null) {
        setState(() {
          isloading = false;
        });
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to upload image.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }

    // Update user's profile with new data
    await _profileController.updateProfileInFirebase(
      imageUrl,
      nameController.text,
    );

    setState(() {
      isloading = false;
    });

    // Show success message
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Success'),
        content: Text('Profile updated successfully.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  TextField textFields(TextEditingController controller, String label,
      IconData icon, TextInputType type, bool obsecure, Color color) {
    return TextField(
      style: TextStyle(
        color: color,
      ),
      controller: controller,
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

  // Future getImage(value) async {
  //   final pickedFile = await imagePicker.pickImage(source: value);

  //   // options for image picker by gallery or camera
  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = pickedFile;
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

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
          child: _image != null
              ? CircleAvatar(
                  radius: 60,
                  backgroundImage: MemoryImage(_image!),
                )
              : CircleAvatar(
                  radius: 60,
                  backgroundColor: const Color.fromARGB(255, 27, 27, 27),
                  backgroundImage: NetworkImage(
                      'https://static.vecteezy.com/system/resources/previews/019/879/186/original/user-icon-on-transparent-background-free-png.png'),
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
                onPressed: selectImage,
                icon: Icon(CupertinoIcons.camera),
                color: Colors.white,
                iconSize: 25,
              ),
            )),
      ],
    );
  }
}

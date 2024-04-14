import 'dart:developer';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProfileController {
  final user = FirebaseAuth.instance.currentUser;

  getProfile() async {
    return user;
  }

  Future<String?> uploadImageToFirebaseStorage(Uint8List imageBytes) async {
    try {
      // Generate a unique filename
      String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      log('Uploading image: $fileName');

      // Upload image to Firebase Storage
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child(fileName);
      await ref.putData(imageBytes);

      // Get download URL of the uploaded image
      String imageUrl = await ref.getDownloadURL();

      log('Image uploaded: $imageUrl');

      return imageUrl;
    } catch (e) {
      log('Error uploading image: $e');
      return null;
    }
  }

  Future<void> updateProfileInFirebase(String? imageUrl, String newName) async {
    try {
      // Update user's profile with new data
      await user!.updateDisplayName(newName);
      if (imageUrl != null) {
        await user!.updatePhotoURL(imageUrl);
      }
    } catch (e) {
      log('Error updating profile: $e');
    }
  }
}

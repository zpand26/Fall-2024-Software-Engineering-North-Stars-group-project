import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class PhotoGalleryModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload a photo to Firebase Storage and return its URL
  Future<String> uploadPhoto(File photo, String userId) async {
    try {
      // Create user-specific path
      final fileName = DateTime.now().toIso8601String();
      final storageRef = _storage.ref().child('user_photos/$userId/$fileName.jpg');

      final uploadTask = await storageRef.putFile(photo);
      final downloadUrl = await uploadTask.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      throw Exception('Error uploading photo: $e');
    }
  }

  // Save the photo URL to Firestore
  Future<void> savePhotoUrlToFirestore(String downloadUrl, String userId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('gallery')
          .add({'url': downloadUrl, 'uploadedAt': Timestamp.now(),
      });
    } catch (e) {
      throw Exception('Error saving photo URL to Firestore: $e');
    }
  }

  // Fetch user-specific photo URLs from Firestore
  Future<List<String>> fetchUserPhotos(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('gallery')
          .get();

      return snapshot.docs.map((doc) => doc['url'] as String).toList();
    } catch (e) {
      throw Exception('Error fetching user photos: $e');
    }
  }
}
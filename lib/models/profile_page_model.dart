import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';


class ProfilePageModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  String get userId => _auth.currentUser?.uid ?? '';

  Future<void> updateProfile(Map<String, dynamic> profileData) async {
    if (userId.isNotEmpty) {
      await _firestore
          .collection('users')
          .doc(userId)
          .set(profileData, SetOptions(merge: true));
    }
  }

  Future<Map<String, dynamic>> getProfile() async {
    if (userId.isNotEmpty) {
      final doc = await _firestore.collection('users').doc(userId).get();
      return doc.data() ?? {};
    }
    return {};
  }

  // Individual Field Helpers
  Future<void> setProfileField(String field, dynamic value) async {
    if (userId.isNotEmpty) {
      await _firestore
          .collection('users')
          .doc(userId)
          .set({field: value}, SetOptions(merge: true));
    }
  }

  Future<dynamic> getProfileField(String field) async {
    if (userId.isNotEmpty) {
      final doc = await _firestore.collection('users').doc(userId).get();
      return doc.data()?[field];
    }
    return null;
  }

  Future<String> uploadProfilePicture(File photo) async {
    final userId = _auth.currentUser?.uid ?? '';
    if (userId.isEmpty) throw Exception('User is not logged in.');

    final fileName = 'profile_picture.jpg';
    final storageRef = _storage.ref().child('user_photos/$userId/$fileName');

    final uploadTask = await storageRef.putFile(photo);
    return await uploadTask.ref.getDownloadURL();
  }
}

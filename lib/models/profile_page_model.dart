import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePageModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
}

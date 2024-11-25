import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class PhotoGalleryModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // In-memory storage of photo URLs
  final List<String> photoUrls = [];

  // Upload a photo to Firebase Storage and return its URL
  Future<String> uploadPhoto(File photo) async {
    try {
      final fileName = DateTime.now().toIso8601String();
      final storageRef = _storage.ref().child('gallery/$fileName.jpg');

      final uploadTask = await storageRef.putFile(photo);
      final downloadUrl = await uploadTask.ref.getDownloadURL();

      print('Download URL: $downloadUrl'); // Debug log

      // Save photo URL to Firestore
      await _firestore.collection('gallery').add({'url': downloadUrl});
      print('URL saved to Firestore'); // Debug log

      photoUrls.add(downloadUrl);
      return downloadUrl;
    } catch (e) {
      print('Error uploading photo: $e'); // Debug log
      throw Exception('Failed to upload photo');
    }
  }
  // Fetch all photo URLs from Firestore
  Future<List<String>> fetchPhotos() async {
    try {
      final snapshot = await _firestore.collection('gallery').get();

      photoUrls.clear();
      photoUrls.addAll(snapshot.docs.map((doc) => doc['url'] as String));

      return photoUrls;
    } catch (e) {
      throw Exception('Error fetching photos: $e');
    }
  }
}

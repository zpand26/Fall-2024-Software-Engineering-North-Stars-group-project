import 'dart:io';
import '../models/photo_gallery_model.dart';

typedef ViewUpdater = void Function();

class PhotoGalleryPresenter {
  final PhotoGalleryModel _model;
  final ViewUpdater updateView;
  final String userId;

  PhotoGalleryPresenter(this._model, this.updateView, this.userId);

  // Add a photo and update the view
  Future<void> addPhoto(File photo) async {
    try {
      final downloadUrl = await _model.uploadPhoto(photo, userId);
      await _model.savePhotoUrlToFirestore(downloadUrl, userId);
      updateView(); // Notify the view to refresh
    } catch (e) {
      print('Error adding photo: $e');
    }
  }

  // Fetch photos and update the view
  Future<void> fetchPhotos() async {
    try {
      await _model.fetchUserPhotos(userId);
      updateView(); // Notify the view to refresh
    } catch (e) {
      print('Error fetching photos: $e');
    }
  }

  // Get photo URLs from the model
  Future<List<String>> getPhotos() async {
    return _model.fetchUserPhotos(userId);
  }
}
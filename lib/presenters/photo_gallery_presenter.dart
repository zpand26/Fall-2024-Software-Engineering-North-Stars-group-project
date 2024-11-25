import 'dart:io';
import '../models/photo_gallery_model.dart';

typedef ViewUpdater = void Function();

class PhotoGalleryPresenter {
  final PhotoGalleryModel _model;
  final ViewUpdater updateView;

  PhotoGalleryPresenter(this._model, this.updateView);

  // Add a photo and update the view
  Future<void> addPhoto(File photo) async {
    try {
      await _model.uploadPhoto(photo);
      updateView(); // Notify the view to refresh
    } catch (e) {
      print('Error adding photo: $e');
    }
  }

  // Fetch photos and update the view
  Future<void> fetchPhotos() async {
    try {
      await _model.fetchPhotos();
      updateView(); // Notify the view to refresh
    } catch (e) {
      print('Error fetching photos: $e');
    }
  }

  // Get photo URLs from the model
  List<String> getPhotos() => _model.photoUrls;
}

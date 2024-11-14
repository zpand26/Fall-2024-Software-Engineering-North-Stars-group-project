// presenters/photo_gallery_presenter.dart

import '../models/photo_gallery_model.dart';

class PhotoGalleryPresenter {
  final PhotoGalleryModel model;

  PhotoGalleryPresenter(this.model);

  List<String> getImages() {
    return model.getImageUrls();
  }
}

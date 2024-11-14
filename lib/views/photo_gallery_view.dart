// views/photo_gallery_view.dart

import 'package:flutter/material.dart';
import '../presenters/photo_gallery_presenter.dart';

class PhotoGalleryView extends StatelessWidget {
  final PhotoGalleryPresenter presenter;

  PhotoGalleryView({Key? key, required this.presenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageUrls = presenter.getImages();  // Fetch images from presenter

    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Gallery'),
      ),
      body: Center(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 images per row
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: imageUrls.length,
          itemBuilder: (context, index) {
            return Image.network(imageUrls[index]);  // Display image from URL
          },
        ),
      ),
    );
  }
}

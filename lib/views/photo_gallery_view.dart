import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../presenters/photo_gallery_presenter.dart';

class PhotoGalleryView extends StatefulWidget {
  final PhotoGalleryPresenter presenter;

  const PhotoGalleryView({super.key, required this.presenter});

  @override
  _PhotoGalleryViewState createState() => _PhotoGalleryViewState();
}

class _PhotoGalleryViewState extends State<PhotoGalleryView> {
  late PhotoGalleryPresenter _presenter;
  List<String> _photos = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _presenter = widget.presenter;

    // Fetch photos on startup
    _loadPhotos();
  }

  // Load photos from Firestore
  Future<void> _loadPhotos() async {
    setState(() => _isLoading = true);
    final photos = await _presenter.getPhotos();
    setState(() {
      _photos = photos;
      _isLoading = false;
    });
  }

  // Capture a photo using the camera and upload it
  Future<void> _capturePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() => _isLoading = true);
      await _presenter.addPhoto(File(pickedFile.path));
      await _loadPhotos(); // Refresh the photo list
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Gallery'),
      ),
      body: Column(
        children: [
          if (_isLoading) const LinearProgressIndicator(),
          Expanded(
            child: _photos.isEmpty
                ? const Center(child: Text('No photos available'))
                : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: _photos.length,
              itemBuilder: (context, index) {
                return Image.network(
                  _photos[index],
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: _capturePhoto,
              icon: const Icon(Icons.camera_alt),
              label: const Text('Capture Photo'),
            ),
          ),
        ],
      ),
    );
  }
}

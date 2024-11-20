import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:north_stars/presenters/camera_presenter.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> implements CameraView {
  late CameraPresenter _cameraPresenter;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _cameraPresenter = CameraPresenter(this);
    _cameraPresenter.initializeCamera();
  }

  @override
  void dispose() {
    _cameraPresenter.cameraModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Camera')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : (_cameraPresenter.cameraModel.controller != null)
          ? CameraPreview(_cameraPresenter.cameraModel.controller!)
          : Center(child: Text('Camera not initialized')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _cameraPresenter.capturePhoto(),
        child: Icon(Icons.camera_alt),
      ),
    );
  }

  @override
  void updateView() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  @override
  void showError(String message) {
    setState(() {
      _isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}

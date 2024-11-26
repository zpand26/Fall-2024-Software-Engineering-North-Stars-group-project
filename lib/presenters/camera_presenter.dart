
import 'package:north_stars/models/camera_model.dart';

abstract class CameraView {
  void updateView();
  void showLoading();
  void showError(String message);
}

class CameraPresenter {
  final CameraModel _cameraModel;
  final CameraView _cameraView;

  CameraPresenter(this._cameraView) : _cameraModel = CameraModel();

  Future<void> initializeCamera() async {
    try {
      _cameraView.showLoading();
      await _cameraModel.initializeCamera();
      _cameraView.updateView();
    } catch (e) {
      _cameraView.showError('Failed to initialize camera: $e');
    }
  }

  Future<void> capturePhoto() async {
    try {
      final imagePath = await _cameraModel.takePicture();
      if (imagePath != null) {
        // Handle the image (e.g., show a success message or navigate)
        print('Photo taken at: $imagePath');
      } else {
        _cameraView.showError('Failed to capture photo');
      }
    } catch (e) {
      _cameraView.showError('Error capturing photo: $e');
    }
  }

  CameraModel get cameraModel => _cameraModel;
}

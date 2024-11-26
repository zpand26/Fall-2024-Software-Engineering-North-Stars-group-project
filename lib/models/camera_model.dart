import 'package:camera/camera.dart';

class CameraModel {
  List<CameraDescription>? _cameras;
  CameraController? _controller;

  Future<void> initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      _controller = CameraController(_cameras![0], ResolutionPreset.high);
      await _controller!.initialize();
    }
  }

  CameraController? get controller => _controller;

  Future<String?> takePicture() async {
    if (_controller != null && _controller!.value.isInitialized) {
      final image = await _controller!.takePicture();
      return image.path;
    }
    return null;
  }

  void dispose() {
    _controller?.dispose();
  }
}
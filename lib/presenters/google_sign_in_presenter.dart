import 'package:firebase_auth/firebase_auth.dart';
import '../models/google_sign_in_model.dart';
import '../views/google_sign_in_view.dart';

class GoogleSignInPresenter {
  final GoogleSignInModel _model;
  final GoogleSignInView _view;

  GoogleSignInPresenter(this._view) : _model = GoogleSignInModel();

  Future<void> signInWithGoogle() async {
    try {
      final User? user = await _model.signInWithGoogle();
      if (user != null) {
        _view.onGoogleSignInSuccess(user); // Notify the view of success
      } else {
        _view.onGoogleSignInCancelled(); // Notify the view if user cancels
      }
    } catch (error) {
      _view.onGoogleSignInError(error.toString()); // Notify the view of an error
    }
  }
}

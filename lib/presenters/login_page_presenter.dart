// auth_presenter.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/login_page_model.dart';

abstract class AuthViewContract {
  void showError(String message);
  void navigateToHome();
  void navigateToLogin();
}

class AuthPresenter {
  final AuthModel _authModel;
  final AuthViewContract _view;
  final GoogleSignIn _googleSignIn = GoogleSignIn(); // Google Sign-In instance

  AuthPresenter(this._view) : _authModel = AuthModel();

  Future<void> login(String email, String password) async {
    try {
      await _authModel.signIn(email, password);
      _view.navigateToHome();
    } catch (e) {
      _view.showError(e.toString());
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      await _authModel.signUp(email, password);
      _view.navigateToHome();
    } catch (e) {
      _view.showError(e.toString());
    }
  }

  // Add Google Sign-In logic
  Future<void> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Firebase authentication
        await FirebaseAuth.instance.signInWithCredential(credential);

        // Navigate to home on success
        _view.navigateToHome();
      }
    } catch (error) {
      _view.showError('Google Sign-In failed: $error');
    }
  }

  Future<void> logout() async {
    try {
      await _authModel.logout();
      _view.navigateToLogin();
    } catch (e) {
      _view.showError("Logout failed: ${e.toString()}");
    }
  }
}

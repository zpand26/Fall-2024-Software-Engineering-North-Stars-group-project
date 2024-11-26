import 'package:your_app/models/login_model.dart';

class LoginPresenter {
  final LoginModel _model;
  final LoginView _view;

  LoginPresenter(this._model, this._view);

  Future<void> handleGoogleSignIn() async {
    try {
      final user = await _model.signInWithGoogle();
      if (user != null) {
        _view.onGoogleSignInSuccess(user);
      } else {
        _view.onGoogleSignInCancelled();
      }
    } catch (error) {
      _view.onGoogleSignInError(error.toString());
    }
  }
}

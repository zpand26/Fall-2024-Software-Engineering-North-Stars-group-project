// auth_presenter.dart

import 'package:firebase_auth/firebase_auth.dart';
import '../models/login_page_model.dart';

abstract class AuthViewContract {
  void showError(String message);
  void navigateToHome();
}

class AuthPresenter {
  final AuthModel _authModel;
  final AuthViewContract _view;

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
}

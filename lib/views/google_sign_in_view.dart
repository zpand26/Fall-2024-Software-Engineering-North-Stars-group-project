import 'package:flutter/material.dart';
import 'package:your_app/presenters/login_presenter.dart';

abstract class LoginView {
  void onGoogleSignInSuccess(dynamic user);
  void onGoogleSignInCancelled();
  void onGoogleSignInError(String error);
}

class LoginPageView extends StatefulWidget {
  final LoginPresenter presenter;

  const LoginPageView({required this.presenter});

  @override
  State<LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> implements LoginView {
  @override
  void initState() {
    super.initState();
    widget.presenter._view = this;
  }

  @override
  void onGoogleSignInSuccess(dynamic user) {
    // Navigate to home page or show user info
    print('User signed in: ${user.displayName}');
  }

  @override
  void onGoogleSignInCancelled() {
    // Notify the user that sign-in was cancelled
    print('Google Sign-In cancelled');
  }

  @override
  void onGoogleSignInError(String error) {
    // Show error message
    print('Google Sign-In error: $error');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: ElevatedButton.icon(
          icon: Icon(Icons.login),
          label: Text('Sign in with Google'),
          onPressed: () {
            widget.presenter.handleGoogleSignIn();
          },
        ),
      ),
    );
  }
}

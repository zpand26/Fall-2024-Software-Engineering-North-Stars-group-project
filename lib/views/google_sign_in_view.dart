import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../presenters/google_sign_in_presenter.dart';

abstract class GoogleSignInView {
  void onGoogleSignInSuccess(User user);
  void onGoogleSignInError(String error);
  void onGoogleSignInCancelled();
}

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton>
    implements GoogleSignInView {
  late GoogleSignInPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = GoogleSignInPresenter(this);
  }

  @override
  void onGoogleSignInSuccess(User user) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Welcome, ${user.displayName}!')),
    );
  }

  @override
  void onGoogleSignInError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $error')),
    );
  }

  @override
  void onGoogleSignInCancelled() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sign-in cancelled.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        _presenter.signInWithGoogle();
      },
      icon: Image.asset(
        'assets/google_logo.png', // Ensure this asset exists
        height: 24,
        width: 24,
      ),
      label: const Text('Sign in with Google'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}

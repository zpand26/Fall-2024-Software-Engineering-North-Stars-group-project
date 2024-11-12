// profile_page_view.dart
import 'package:flutter/material.dart';
import '../presenters/profile_page_presenter.dart';

class ProfilePageView extends StatelessWidget {
  final ProfilePagePresenter presenter;

  ProfilePageView({Key? key, required this.presenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(presenter.profilePictureUrl),
            ),
            SizedBox(height: 16),
            Text(
              presenter.username,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              presenter.email,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

// profile_page_presenter.dart
import '../models/profile_page_model.dart';

class ProfilePagePresenter {
  final ProfilePageModel model;

  ProfilePagePresenter(this.model);

  String get username => model.username;
  String get email => model.email;
  String get profilePictureUrl => model.profilePictureUrl;
}

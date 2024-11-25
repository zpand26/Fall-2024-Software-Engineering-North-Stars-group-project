import '../models/profile_page_model.dart';

class ProfilePagePresenter {
  final ProfilePageModel model;
  void Function(String)? updateView;

  ProfilePagePresenter({
    required this.model,
    this.updateView,
  });

  /// Load the username and trigger the view update.
  void loadUsername() {
    updateView?.call(model.username);
  }

  /// Save the username and trigger the view update.
  void saveUsername(String newUsername) {
    model.updateUsername(newUsername);
    updateView?.call(newUsername);
  }

  /// Save the mobile phone and trigger the view update.
  void saveMobilePhone(String newMobilePhone) {
    model.updateMobilePhone(newMobilePhone);
    updateView?.call(model.username); // Triggers view update
  }

  /// Save the birthday and trigger the view update.
  void saveBirthday(DateTime newBirthday) {
    model.updateBirthday(newBirthday);
    updateView?.call(model.username); // Triggers view update
  }
}

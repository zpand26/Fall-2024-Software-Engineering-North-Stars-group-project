import '../models/profile_page_model.dart';

class ProfilePagePresenter {
  final ProfilePageModel model;
  void Function(String)? updateView;

  ProfilePagePresenter({
    required this.model,
    this.updateView,
  });

  void loadUsername() {
    updateView?.call(model.username);
  }

  void saveUsername(String newUsername) {
    model.updateUsername(newUsername);
    updateView?.call(newUsername);
  }

  void saveMobilePhone(String newMobilePhone) {
    model.updateMobilePhone(newMobilePhone);
    updateView?.call(model.username);
  }

  void saveBirthday(DateTime newBirthday) {
    model.updateBirthday(newBirthday);
    updateView?.call(model.username);
  }
}

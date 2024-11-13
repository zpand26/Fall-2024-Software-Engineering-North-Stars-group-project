import '../models/profile_page_model.dart';

class ProfilePagePresenter {
  final ProfilePageModel model;
  void Function(String)? updateView;

  ProfilePagePresenter({
    required this.model,
    this.updateView,
  });

  // Load the initial username to display in the view
  void loadUsername() {
    updateView?.call(model.username);
  }

  // Save the updated username in the model and refresh the view
  void saveUsername(String newUsername) {
    model.username = newUsername;
    updateView?.call(newUsername); // Trigger the view to update with the new username
  }
}
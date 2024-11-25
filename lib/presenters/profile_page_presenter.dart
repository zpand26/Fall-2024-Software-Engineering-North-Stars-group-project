import '../models/profile_page_model.dart';

class ProfilePagePresenter {
  final ProfilePageModel profileModel;
  final Function(String, Map<String, dynamic>?) updateView;

  ProfilePagePresenter(this.profileModel, this.updateView);

  Future<void> loadProfileData() async {
    try {
      final data = await profileModel.getProfile();
      updateView('Profile loaded successfully.', data);
    } catch (e) {
      updateView('Failed to load profile: $e', null);
    }
  }

  Future<void> saveProfile(Map<String, dynamic> newProfileData) async {
    try {
      await profileModel.updateProfile(newProfileData);
      updateView('Profile saved successfully.', newProfileData);
    } catch (e) {
      updateView('Failed to save profile: $e', null);
    }
  }

  Future<void> updateField(String field, dynamic value) async {
    try {
      await profileModel.setProfileField(field, value);
      updateView('$field updated successfully.', null);
    } catch (e) {
      updateView('Failed to update $field: $e', null);
    }
  }
}

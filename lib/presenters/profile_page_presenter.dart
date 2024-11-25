import '../models/profile_page_model.dart';

typedef ViewUpdater = void Function();

class ProfilePagePresenter {
  final ProfilePageModel profileModel;
  final ViewUpdater updateView;

  ProfilePagePresenter(this.profileModel, this.updateView);

  // Fetch profile data automatically when the page is created
  Future<void> fetchProfileData() async {
    try {
      final data = await profileModel.getProfile();  // Fetch profile data
      updateView(); // Notify the view to refresh with fetched data
    } catch (e) {
      print('Error fetching profile data: $e');
    }
  }

  // Save profile data
  Future<void> saveProfile(Map<String, dynamic> newProfileData) async {
    try {
      await profileModel.updateProfile(newProfileData);
      updateView();  // Refresh the view after saving profile data
    } catch (e) {
      print('Error saving profile: $e');
    }
  }

  // Update individual fields in the profile
  Future<void> updateField(String field, dynamic value) async {
    try {
      await profileModel.setProfileField(field, value);
      updateView();  // Notify the view to refresh after updating field
    } catch (e) {
      print('Error updating $field: $e');
    }
  }
}
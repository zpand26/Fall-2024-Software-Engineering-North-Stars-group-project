import '../models/profile_page_model.dart';
import 'dart:io';


typedef ViewUpdater = void Function();

class ProfilePagePresenter {
  final ProfilePageModel profileModel;
  final ViewUpdater updateView;

  ProfilePagePresenter(this.profileModel, this.updateView);

  // Fetch profile data automatically when the page is created
  Future<Map<String, dynamic>> fetchProfileData() async {
    try {
      return await profileModel.getProfile();
    } catch (e) {
      print('Error fetching profile data: $e');
      return {};
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

  Future<String> uploadProfilePicture(File photo) async {
    return await profileModel.uploadProfilePicture(photo);
  }

}
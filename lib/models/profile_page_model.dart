
class ProfilePageModel {
  String username;
  String email;
  String profilePictureUrl;
  DateTime? birthday;
  String? mobilePhone;

  ProfilePageModel({
    required this.username,
    required this.email,
    required this.profilePictureUrl,
    this.birthday,
    this.mobilePhone,
  });

  // Method to update the username
  void updateUsername(String newUsername) {
    username = newUsername;
  }

  // Optional: Additional methods to update birthday and mobile phone
  void updateBirthday(DateTime newBirthday) {
    birthday = newBirthday;
  }

  void updateMobilePhone(String newMobilePhone) {
    mobilePhone = newMobilePhone;
  }
}

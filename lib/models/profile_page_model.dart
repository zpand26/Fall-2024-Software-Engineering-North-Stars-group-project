class ProfilePageModel {
  String username;
  String email;
  String profilePictureUrl;
  String? mobilePhone;
  DateTime? birthday;

  ProfilePageModel({
    required this.username,
    required this.email,
    required this.profilePictureUrl,
    this.mobilePhone,
    this.birthday,
  });

  void updateUsername(String newUsername) {
    username = newUsername;
  }

  void updateMobilePhone(String newMobilePhone) {
    mobilePhone = newMobilePhone;
  }

  void updateBirthday(DateTime newBirthday) {
    birthday = newBirthday;
  }
}

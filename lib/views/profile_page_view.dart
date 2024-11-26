import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../presenters/profile_page_presenter.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


class ProfilePageView extends StatefulWidget {
  final ProfilePagePresenter profilePagePresenter;

  const ProfilePageView({Key? key,
    required this.profilePagePresenter})
      : super(key: key);

  @override
  _ProfilePageViewState createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobilePhoneController = TextEditingController();
  DateTime? _selectedBirthday;
  String _statusMessage = '';
  String? _profilePictureUrl;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  void _loadProfileData() async {
    try {
      final profileData = await widget.profilePagePresenter.fetchProfileData();
      setState(() {
        _nameController.text = profileData['username'] ?? '';
        _mobilePhoneController.text = profileData['mobilePhone'] ?? '';
        _selectedBirthday = profileData['birthday'] != null
            ? DateTime.parse(profileData['birthday'])
            : null;
        _profilePictureUrl = profileData['profilePictureUrl']; // If you want to handle a picture.
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Failed to load profile data.';
      });
      print('Error loading profile data: $e');
    }
  }

  void _saveProfile() async {
    final newProfile = {
      'username': _nameController.text.trim(),
      'mobilePhone': _mobilePhoneController.text.trim(),
      'birthday': _selectedBirthday?.toIso8601String(),
      'profilePictureUrl': _profilePictureUrl,
    };

    try {
      await widget.profilePagePresenter.saveProfile(newProfile);
      setState(() {
        _statusMessage = 'Profile saved successfully!';
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Failed to save profile. Please try again.';
      });
      print('Error saving profile: $e');
    }
  }

  Future<void> _selectBirthday(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedBirthday ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedBirthday) {
      setState(() {
        _selectedBirthday = pickedDate;
      });
    }
  }

  Future<void> _selectProfilePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final photoFile = File(pickedFile.path);

      // Upload photo and get URL
      try {
        final profilePictureUrl = await widget.profilePagePresenter.uploadProfilePicture(photoFile);

        // Update the view and save to Firestore
        setState(() {
          _profilePictureUrl = profilePictureUrl;
        });

        await widget.profilePagePresenter.updateField('profilePictureUrl', profilePictureUrl);

        setState(() {
          _statusMessage = 'Profile picture updated!';
        });
      } catch (e) {
        setState(() {
          _statusMessage = 'Failed to update profile picture. Please try again.';
        });
        print('Error uploading profile picture: $e');
      }
    }
  }

  Future<void> _selectProfilePictureFromGallery() async {
    setState(() => _statusMessage = 'Loading gallery...');
    final photoGallery = await widget.profilePagePresenter.fetchPhotoGallery();

    if (photoGallery.isEmpty) {
      setState(() => _statusMessage = 'No photos found in the gallery.');
      return;
    }

    // Show dialog with photos
    final selectedPhoto = await showDialog<String>(
      context: context,
      builder: (context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Select a Profile Picture'),
              ),
              SizedBox(
                height: 300, // Adjust height for gallery display
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemCount: photoGallery.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pop(context, photoGallery[index]);
                      },
                      child: Image.network(
                        photoGallery[index],
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );

    // Update profile picture if an image was selected
    if (selectedPhoto != null) {
      try {
        setState(() {
          _profilePictureUrl = selectedPhoto;
          _statusMessage = 'Profile picture updated!';
        });

        await widget.profilePagePresenter.updateField('profilePictureUrl', selectedPhoto);
      } catch (e) {
        setState(() {
          _statusMessage = 'Failed to update profile picture. Please try again.';
        });
        print('Error updating profile picture: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Picture
            CircleAvatar(
              radius: 60,
              backgroundImage:
              _profilePictureUrl != null ? NetworkImage(_profilePictureUrl!) : null,
              child: GestureDetector(
                onTap: _selectProfilePictureFromGallery, // Open gallery on tap
                child: _profilePictureUrl == null
                    ? const Icon(Icons.person, size: 60)
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            // Name
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // Mobile Phone
            TextField(
              controller: _mobilePhoneController,
              decoration: InputDecoration(
                labelText: 'Mobile Phone',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // Birthday
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Birthday: ${_selectedBirthday != null ? DateFormat.yMMMd().format(_selectedBirthday!) : "Not set"}',
                  ),
                ),
                TextButton(
                  onPressed: () => _selectBirthday(context),
                  child: const Text('Select Date'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Save Button
            ElevatedButton(
              onPressed: _saveProfile,
              child: const Text('Save Profile'),
            ),
            // Status Message
            if (_statusMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  _statusMessage,
                  style: TextStyle(color: Colors.green),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
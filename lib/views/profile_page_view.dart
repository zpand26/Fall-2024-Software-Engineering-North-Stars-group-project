
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../presenters/profile_page_presenter.dart';
import '../presenters/photo_gallery_presenter.dart';
import 'photo_gallery_view.dart';

class ProfilePageView extends StatefulWidget {
  final ProfilePagePresenter profilePagePresenter;
  final PhotoGalleryPresenter photoGalleryPresenter;

  const ProfilePageView({
    Key? key,
    required this.profilePagePresenter,
    required this.photoGalleryPresenter,
  }) : super(key: key);

  @override
  _ProfilePageViewState createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobilePhoneController = TextEditingController();
  DateTime? _selectedBirthday;
  String _statusMessage = '';

  @override
  void initState() {
    super.initState();
    _loadProfileData();

    widget.profilePagePresenter.updateView = (username) {
      setState(() {
        _nameController.text = username;
      });
    };

    widget.profilePagePresenter.loadUsername();
  }

  void _loadProfileData() {
    setState(() {
      _nameController.text = widget.profilePagePresenter.model.username;
      _mobilePhoneController.text =
          widget.profilePagePresenter.model.mobilePhone ?? '';
      _selectedBirthday = widget.profilePagePresenter.model.birthday;
    });
  }

  void _saveProfileInfo() {
    final newUsername = _nameController.text;
    final newMobilePhone = _mobilePhoneController.text;

    bool hasChanges = false;

    if (newUsername != widget.profilePagePresenter.model.username) {
      widget.profilePagePresenter.saveUsername(newUsername);
      hasChanges = true;
    }
    if (newMobilePhone != widget.profilePagePresenter.model.mobilePhone) {
      widget.profilePagePresenter.model.updateMobilePhone(newMobilePhone);
      hasChanges = true;
    }
    if (_selectedBirthday != null &&
        _selectedBirthday != widget.profilePagePresenter.model.birthday) {
      widget.profilePagePresenter.model.updateBirthday(_selectedBirthday!);
      hasChanges = true;
    }

    setState(() {
      _statusMessage = hasChanges ? "Profile updated!" : "No changes to save.";
    });
  }

  Future<void> _selectBirthday(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedBirthday ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedBirthday = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.teal, // Set AppBar color to teal
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Picture
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                    widget.profilePagePresenter.model.profilePictureUrl),
                onBackgroundImageError: (_, __) =>
                const Icon(Icons.person, size: 60),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                widget.profilePagePresenter.model.email,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal, // Set text color to teal
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Profile Info Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Profile Information",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal, // Set heading color to teal
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: "Name",
                        labelStyle: TextStyle(color: Colors.teal),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _mobilePhoneController,
                      decoration: InputDecoration(
                        labelText: "Mobile Phone",
                        labelStyle: TextStyle(color: Colors.teal),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Birthday: ${_selectedBirthday != null ? DateFormat.yMMMd().format(_selectedBirthday!) : "Not set"}",
                          ),
                        ),
                        TextButton(
                          onPressed: () => _selectBirthday(context),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.teal, // Set button color
                          ),
                          child: const Text("Select Date"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _saveProfileInfo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal, // Set button color
                  ),
                  icon: const Icon(Icons.save, color: Colors.white),
                  label: const Text(
                    "Save Profile",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PhotoGalleryView(
                          presenter: widget.photoGalleryPresenter,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal, // Set button color
                  ),
                  icon: const Icon(Icons.photo_album, color: Colors.white),
                  label: const Text(
                    "Photo Gallery",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),

            // Status Message
            if (_statusMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  _statusMessage,
                  style: TextStyle(
                    color: Colors.teal[700],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

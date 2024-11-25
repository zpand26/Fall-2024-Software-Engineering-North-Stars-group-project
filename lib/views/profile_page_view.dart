import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../presenters/profile_page_presenter.dart';

class ProfilePageView extends StatefulWidget {
  final ProfilePagePresenter presenter;

  ProfilePageView({Key? key, required this.presenter}) : super(key: key);

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

    widget.presenter.updateView = (username) {
      setState(() {
        _nameController.text = username;
        _mobilePhoneController.text = widget.presenter.model.mobilePhone ?? '';
        _selectedBirthday = widget.presenter.model.birthday;
        _statusMessage = '';
      });
    };

    widget.presenter.loadUsername();
  }

  void _saveProfileInfo() {
    final newUsername = _nameController.text;
    final newMobilePhone = _mobilePhoneController.text;

    if (newUsername != widget.presenter.model.username ||
        newMobilePhone != widget.presenter.model.mobilePhone ||
        _selectedBirthday != widget.presenter.model.birthday) {
      widget.presenter.saveUsername(newUsername);
      widget.presenter.saveMobilePhone(newMobilePhone);
      if (_selectedBirthday != null) {
        widget.presenter.saveBirthday(_selectedBirthday!);
      }
      setState(() {
        _statusMessage = "Profile updated!";
      });
    } else {
      setState(() {
        _statusMessage = "No changes to save.";
      });
    }
  }

  Future<void> _selectBirthday(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.presenter.model.profilePictureUrl),
                onBackgroundImageError: (_, __) => const Icon(Icons.person, size: 50),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                widget.presenter.model.email,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Name"),
              onSubmitted: (_) => _saveProfileInfo(),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _mobilePhoneController,
              decoration: const InputDecoration(labelText: "Mobile Phone"),
              keyboardType: TextInputType.phone,
              onSubmitted: (_) => _saveProfileInfo(),
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
                  child: const Text("Select Date"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _saveProfileInfo,
              child: const Text("Save Profile"),
            ),
            if (_statusMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  _statusMessage,
                  style: TextStyle(
                    color: Colors.green[700],
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

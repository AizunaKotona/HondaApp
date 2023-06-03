import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _first_nameController = TextEditingController();
  final TextEditingController _last_nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _usernameController.text = prefs.getString('username') ?? '';
      _first_nameController.text = prefs.getString('first_name') ?? '';
      _last_nameController.text = prefs.getString('last_name') ?? '';
      _phoneController.text = prefs.getString('phone') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _first_nameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: _last_nameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Save the updated profile data
                saveProfileData();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _usernameController.text);
    await prefs.setString('first_name', _first_nameController.text);
    await prefs.setString('last_name', _last_nameController.text);
    await prefs.setString('phone', _phoneController.text);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile updated successfully!'),
      ),
    );
  }
}

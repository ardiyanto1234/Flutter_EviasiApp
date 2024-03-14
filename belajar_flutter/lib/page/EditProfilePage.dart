import 'package:flutter/material.dart';

void main() {
  runApp(EditProfilePage());
}

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edit Profile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EditProfileScreen(),
    );
  }
}

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: EditProfileForm(),
    );
  }
}

class EditProfileForm extends StatefulWidget {
  @override
  _EditProfileFormState createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: 'Username'),
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextFormField(
            controller: _phoneNumberController,
            decoration: InputDecoration(labelText: 'Phone Number'),
          ),
          TextFormField(
            controller: _addressController,
            decoration: InputDecoration(labelText: 'Address'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Implementasi logika untuk menyimpan perubahan profil
              _saveProfileChanges();
            },
            child: Text('Save Changes'),
          ),
        ],
      ),
    );
  }

  void _saveProfileChanges() {
    String newUsername = _usernameController.text;
    String newEmail = _emailController.text;
    String newPhoneNumber = _phoneNumberController.text;
    String newAddress = _addressController.text;

    // Implementasi logika untuk menyimpan perubahan profil disini
    print('New Username: $newUsername');
    print('New Email: $newEmail');
    print('New Phone Number: $newPhoneNumber');
    print('New Address: $newAddress');
  }
}

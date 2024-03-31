import 'dart:io';

import 'package:belajar_flutter/page/Profilepage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
      debugShowCheckedModeBanner: false,
      home: EditProfileScreen(),
    );
  }
}

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

  ImagePicker _imagePicker = ImagePicker();
  File? _profileImage;

  Future<void> _getImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 24.0),
          SizedBox(
            width: 500,
            child: TextField(controller: _usernameController,
            cursorColor: Colors.black,
            decoration: const InputDecoration(
              labelText: 'Username Baru',
              labelStyle: TextStyle(color: Colors.black),
              fillColor: Color.fromARGB(255, 225, 225, 225),
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
                  prefixIcon: Icon(Icons.person, color: Colors.black),
                  ),
            ),

          ),
         SizedBox(height: 24.0),
          SizedBox(
            width: 500,
            child: TextField(controller: _usernameController,
            cursorColor: Colors.black,
            decoration: const InputDecoration(
              labelText: 'Email Baru',
              labelStyle: TextStyle(color: Colors.black),
              fillColor: Color.fromARGB(255, 225, 225, 225),
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
                  prefixIcon: Icon(Icons.person, color: Colors.black),
                  ),
            ),

          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _phoneNumberController,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _addressController,
            decoration: InputDecoration(
              labelText: 'Address',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 24.0),
          ElevatedButton(
            onPressed: () {
                Navigator.push
                      (context, 
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation ) =>
                        ProfilePage(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return FadeTransition(opacity: animation,
                          child: child,
                          );
                        } ,
                      ),
                      );
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

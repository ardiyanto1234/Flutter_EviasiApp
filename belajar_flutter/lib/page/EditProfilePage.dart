import 'dart:io';
import 'package:belajar_flutter/page/Dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:belajar_flutter/page/Login.dart';
import 'package:belajar_flutter/page/Profilepage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(EditProfilePage());
}

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

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
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EditProfileForm(),
    );
  }
}

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({super.key});

  @override
  _EditProfileFormState createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();
  File? _profileImage;

  Future<void> postDataToServer() async {
    // Persiapkan data yang akan dikirim
    Map<String, dynamic> data = {
      'nama': _usernameController.text,
      'email': _emailController.text,
      'no_hp': _phoneNumberController.text,
      'alamat': _addressController.text,
      'id': LoginPage.id.toString(),
    };

    // Buat request POST ke URL server
    Uri url = Uri.parse("http://efiasi.tifnganjuk.com/api/MobileApi/editprofile");

      try {
        // Kirim request POST ke server
        final response = await http.post(url, body: data);

        // Periksa kode status respons
        if (response.statusCode == 200) {
          // Sukses mengirim data
          print(response.body);
          print('Data berhasil dikirim');

          Navigator.push(context, PageRouteBuilder(pageBuilder: (context,animation,secondaryAnimation)=>DashboardPage(),transitionsBuilder: (context,animation,secondaryAnimation,child){
            return FadeTransition(opacity: animation,child:child);
          }));
        } else {
          // Gagal mengirim data
          print('Gagal mengirim data. Kode status: ${response.body}');
        }
      } catch (error) {
        // Tangani kesalahan jika terjadi
        print('Terjadi kesalahan: $error');
      }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 129, 120),
        title: const Text('Edit Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
           Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        DashboardPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                ); // Kembali ke halaman sebelumnya
              },
            ),
          ),
        
      body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 24.0),
          SizedBox(
            width: 500,
            child: TextField(controller: _usernameController,
            cursorColor: Colors.black,
            decoration: const InputDecoration(
              labelText: 'Nama Lengkap Baru',
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
         const SizedBox(height: 24.0),
          SizedBox(
            width: 500,
            child: TextField(controller: _phoneNumberController,
            cursorColor: Colors.black,
            decoration: const InputDecoration(
              labelText: 'no.Handpone Baru',
              labelStyle: TextStyle(color: Colors.black),
              fillColor: Color.fromARGB(255, 225, 225, 225),
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
                  prefixIcon: Icon(Icons.contact_page, color: Colors.black),
                  ),
            ),

          ),
       const SizedBox(height: 24.0),
          SizedBox(
            width: 500,
            child: TextField(controller: _addressController,
            cursorColor: Colors.black,
            decoration: const InputDecoration(
              labelText: 'Almat Baru',
              labelStyle: TextStyle(color: Colors.black),
              fillColor: Color.fromARGB(255, 225, 225, 225),
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
                  prefixIcon: Icon(Icons.add_home, color: Colors.black),
                  ),
            ),

          ),
          const SizedBox(height: 24.0),
          SizedBox(
            width: double.infinity,
         child: ElevatedButton(
            onPressed: () {
              postDataToServer();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 255, 129, 119)
            ),
            child: const Text('Simpan profil baru'),
              ),
            ),
          ],
        ),
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

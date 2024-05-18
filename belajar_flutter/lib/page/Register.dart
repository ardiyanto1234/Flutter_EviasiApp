import 'dart:convert';

import 'package:belajar_flutter/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_method/d_method.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:belajar_flutter/page/Login.dart';
import 'package:belajar_flutter/page/KodeOtpRegister.dart';
import 'package:belajar_flutter/src/CustomColors.dart';

void main() {
  runApp(Register());
}

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration Form',
      home: RegistrationForm(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _nama_Lengkap = '';
  String _email = '';
  String _no_hp = '';
  String _alamat = '';
  String _password = '';
  bool isHidden = true;

  TextEditingController emailCont = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      print('Formulir valid, data tersimpan.');
    }
  }

  Future<void> sendOtp(String email) async {
    try {
      var url = Uri.parse('http://192.168.193.152:8000/api/apieviasi/otp');
      var response = await http.post(
        url,
        body: {
          'email': email,
        },
      );
 
      DMethod.log('email : $email');
      DMethod.log('url   : ${url.toString()}');

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var otp = jsonResponse['data']['otp'];
        DMethod.log('OTP terkirim : $otp');

        var user = UserModel(
          username: _username,
          email: _email,
          name: _nama_Lengkap,
          noHp: _no_hp,
          alamat: _alamat,
          password: _password,
        );

        // Get.to(OTPPage(otpCode: otp,));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTPPage(otpCode: otp, userMode: user,),
          ),
        );
      } else {
        DMethod.log('OTP gagal terkirim');
      }
    } catch (ex) {
      DMethod.log('Exception: ${ex.toString()}');
    }
  }


// http://172.16.103.51:8000/api/apieviasi/otp
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.193.152:8000/api/apieviasi/register'),
        body: jsonEncode({
          'username': _username,
          'email': _email,
          'password': _password,
          'alamat': _alamat,
          'nama_lengkap': _nama_Lengkap,
          'no_hp': _no_hp,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      print('status code : ${response.statusCode}');

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                LoginPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      } else {
        final error = jsonDecode(response.body)['message'];

        print("ERRORRRR " + error);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Login Gagal'),
              content: Text(error),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Tutup'),
                ),
              ],
            );
          },
        );
      }
    } catch ($e) {
      print('Error: ' + $e.toString());
      print(_username);
      print(_email);
      print(_alamat);
      print(_no_hp);
      print(_nama_Lengkap);
      print(_password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.redEviasi,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Text(
                'Register',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          prefixIcon: Icon(Icons.person, color: Colors.black),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Username harus diisi';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _username = value;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: [AutofillHints.email],
                        decoration: InputDecoration(
                          labelText: 'Nama Lengkap',
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          prefixIcon: Icon(Icons.email, color: Colors.black),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email harus diisi';
                          }
                          if (!value.contains('@')) {
                            return 'Email tidak valid';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _nama_Lengkap = value;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          prefixIcon: Icon(Icons.email, color: Colors.black),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email harus diisi';
                          }
                          if (!value.contains('@')) {
                            return 'Email tidak valid';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _email = value;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          labelText: 'No_hp',
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          prefixIcon: Icon(Icons.email, color: Colors.black),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'No_hp harus diisi';
                          }
                          if (!value.contains('@')) {
                            return 'no_hp tidak valid';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _no_hp = value;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          labelText: 'Alamat',
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          prefixIcon: Icon(Icons.email, color: Colors.black),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Alamat harus diisi';
                          }
                          if (!value.contains('@')) {
                            return 'Alamat tidak valid';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _alamat = value;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          prefixIcon: Icon(Icons.lock, color: Colors.black),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isHidden = !isHidden;
                              });
                            },
                            icon: isHidden
                                ? Icon(Icons.visibility_off,
                                    color: Colors.black)
                                : Icon(Icons.visibility, color: Colors.black),
                          ),
                        ),
                        obscureText: isHidden,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password harus diisi';
                          }
                          if (value.length < 6) {
                            return 'Password minimal 6 karakter';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _password = value;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            // await signInWithGoogle(context);
                            await sendOtp(_email);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 255, 126, 117),
                            onPrimary: Colors.white,
                          ),
                          child: Text('Buat Akun'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

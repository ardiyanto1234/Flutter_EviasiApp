import 'package:belajar_flutter/page/KodeOtpLupaPassword.dart';
import 'package:d_method/d_method.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResetPasswordController {
  final String apiUrl ="http://efiasi.tifnganjuk.com/api/apieviasi/resetpassword"; // Replace with your actual API endpoint
}

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 129, 120), // Change to CustomColors.redEviasi if you have it defined
        title: Text('Forgot Password'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: ForgotPasswordForm(),
      ),
    );
  }
}

class ForgotPasswordForm extends StatefulWidget {
  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _controller = ResetPasswordController();
  bool isHidden = true;

  Future<void> _resetPassword() async {
    await sendOtp(_emailController.text);
  }

  Future<void> sendOtp(String email) async {
    try {
      var url = Uri.parse('http://efiasi.tifnganjuk.com/api/apieviasi/otp');
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

        Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  OTPPForgotpassword(otpCode: otp, email: _emailController.text, password : _passwordController.text),
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
        DMethod.log('OTP gagal terkirim');
      }
    } catch (ex) {
      DMethod.log('Exception: ${ex.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 100),
          Text(
            'Password Baru',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 40),
          SizedBox(
            width: 500,
            child: TextFormField(
              controller: _emailController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                labelText: 'Masukkan Email',
                labelStyle: TextStyle(color: Colors.black),
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                prefixIcon: Icon(Icons.email, color: Colors.black),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: 500,
            child: TextFormField(
              controller: _passwordController,
              obscureText: isHidden,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                labelText: 'Masukkan Password',
                labelStyle: TextStyle(color: Colors.black),
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                prefixIcon: Icon(Icons.lock, color: Colors.black),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isHidden = !isHidden;
                    });
                  },
                  icon: isHidden
                      ? Icon(Icons.visibility_off, color: Colors.black)
                      : Icon(Icons.visibility, color: Colors.black),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (value.length < 8 || value.length > 30) {
                  return 'Password must be between 8 and 30 characters';
                }
                if (!RegExp(r'[^\w\s]').hasMatch(value)) {
                  return 'Password must contain at least one special character';
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: 300,
            child: ElevatedButton(
              onPressed: _resetPassword,
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 255, 126, 117),
                onPrimary: Colors.white,
              ),
              child: Text('Ganti Password'),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ForgotPasswordPage(),
  ));
}

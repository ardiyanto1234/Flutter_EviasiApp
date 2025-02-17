import 'dart:convert';

import 'package:belajar_flutter/page/LupaPassword.dart';
import 'package:d_method/d_method.dart';
import 'package:flutter/material.dart';
import 'package:belajar_flutter/page/Login.dart';
import 'package:belajar_flutter/src/CustomColors.dart';
import 'package:belajar_flutter/page/Register.dart';
import 'package:http/http.dart' as http;

class OTPPForgotpassword extends StatefulWidget {
  @override
  State<OTPPForgotpassword> createState() => _OTPPForgotpasswordState();
  final String otpCode;
  final String email;
  final String password;

  const OTPPForgotpassword({
    Key? key,
    required this.otpCode,
    required this.email,
    required this.password,
  }) : super(key: key);
}

class _OTPPForgotpasswordState extends State<OTPPForgotpassword> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.redEviasi,
          elevation: 0,
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        Register(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: OTPForm(
              otpCode: widget.otpCode,
              password: widget.password,
              email: widget.email,
            ),
          ),
        ),
      ),
    );
  }
}

class OTPForm extends StatefulWidget {
  const OTPForm({
    Key? key,
    required this.otpCode,
    required this.email,
    required this.password,
  }) : super(key: key);

  @override
  _OTPFormState createState() => _OTPFormState();

  final String otpCode;
  final String email;
  final String password;
}

class _OTPFormState extends State<OTPForm> {
  List<TextEditingController> controllers =
      List.generate(5, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 150),
        const SizedBox(height: 100),
        const Text(
          'Kode Otp',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            5,
            (index) => SizedBox(
              width: 50,
              child: TextFormField(
                cursorColor: Colors.black,
                controller: controllers[index],
                maxLength: 1,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  counterText: '',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 300, // Tentukan lebar untuk tombol
          child: ElevatedButton(
            onPressed: () async{
              var otpInput =
                  '${controllers[0].text}${controllers[1].text}${controllers[2].text}${controllers[3].text}${controllers[4].text}';

              // Tambahkan aksi ketika tombol ditekan
              DMethod.log('otp input : $otpInput');
              DMethod.log('otp asli  : $widget');

              if (otpInput != widget.otpCode) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Kode OTP Tidak Cocok'),
                    duration: Duration(seconds: 3),
                  ),
                );
              } else {
                await resetPassword(context, widget.email, widget.password);
              }
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: CustomColors.redEviasi,
            ),
            child: const Text('Konfirmasi'),
          ),
        ),
        // Add more widgets here
      ],
    );
  }

Future<void> resetPassword(BuildContext context, String email, String password) async {
  try {
    final response = await http.post(
      Uri.parse('http://efiasi.tifnganjuk.com/api/MobileApi/resetpassword'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      /// buka window login
       Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
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
      
      // Show success dialog
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return AlertDialog(
      //       title: Text('Success'),
      //       content: Text('Password has been successfully changed.'),
      //       actions: <Widget>[
      //         TextButton(
      //           child: Text('OK'),
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //           },
      //         ),
      //       ],
      //     );
      //   },
      // );
    } else {
      // Show failure dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to change password. Please try again.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  } catch (e) {
    // Handle network errors
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text('An error occurred: $e'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}

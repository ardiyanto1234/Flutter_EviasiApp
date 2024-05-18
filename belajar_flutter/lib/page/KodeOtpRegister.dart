import 'dart:convert';

import 'package:belajar_flutter/models/user_model.dart';
import 'package:d_method/d_method.dart';
import 'package:flutter/material.dart';
import 'package:belajar_flutter/page/Login.dart';
import 'package:belajar_flutter/src/CustomColors.dart';
import 'package:belajar_flutter/page/Register.dart';
import 'package:http/http.dart' as http;

class OTPPage extends StatefulWidget {
  final String otpCode;
  final UserModel userMode;

  const OTPPage({
    Key? key,
    required this.otpCode,
    required this.userMode,
  }) : super(key: key);

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.redEviasi,
          // Placeholder color
          elevation: 0,
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.arrow_back),
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
                ); // Kembali ke halaman sebelumnya
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: OTPForm(
              otpCode: widget.otpCode,
              userModel: widget.userMode,
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
    required this.userModel,
  }) : super(key: key);

  @override
  _OTPFormState createState() => _OTPFormState();

  final String otpCode;
  final UserModel userModel;
}

class _OTPFormState extends State<OTPForm> {
  List<TextEditingController> controllers =
      List.generate(5, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 150),
        Text(
          'Kode Otp',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20), // Add spacing as needed
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
        SizedBox(height: 20),
        SizedBox(
          width: 300, // Tentukan lebar untuk tombol
          child: ElevatedButton(
            onPressed: () async {
              var otpInput =
                  '${controllers[0].text}${controllers[1].text}${controllers[2].text}${controllers[3].text}${controllers[4].text}';

              // Tambahkan aksi ketika tombol ditekan
              DMethod.log('otp input : $otpInput');
              DMethod.log('otp asli  : ${widget}');

              if (otpInput != widget.otpCode) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Kode OTP Tidak Cocok'),
                    duration: Duration(seconds: 3),
                  ),
                );
              } else {
                await register(user: widget.userModel);
              }
            },
            style: ElevatedButton.styleFrom(
              primary:
                  CustomColors.redEviasi, // Mengubah warna tombol menjadi merah
              onPrimary: Colors.white,
            ),
            child: Text('Konfirmasi'),
          ),
        ),
        // Add more widgets here
      ],
    );
  }

  Future<void> register({
    required UserModel user,
  }) async {
    try {
      Map<String, dynamic> data = {
        'nama_lengkap': user.name,
        'username': user.username,
        'email': user.email,
        'password': user.password,
        'no_hp': user.noHp,
        'alamat': user.alamat,
      };

      // Melakukan permintaan POST ke endpoint register
      final response = await http.post(
        Uri.parse('http://192.168.193.152:8000/api/apieviasi/register'),
        body: jsonEncode(data),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      // Memeriksa status kode respons
      if (response.statusCode == 200) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      } else {
        // Ambil pesan error dari respons
        String errorMessage = 'Gagal';
        try {
          Map<String, dynamic> errorResponse = jsonDecode(response.body);
          if (errorResponse.containsKey('message')) {
            errorMessage = errorResponse['message'];
          }
        } catch (e) {
          print('Error decoding error message: $e');
        }

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text(
                'Gagal membuat akun  response : $errorMessage'), // tampilkan pesan error dari response
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Gagal membuat akun.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
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

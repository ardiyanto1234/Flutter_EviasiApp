import 'package:belajar_flutter/page/Dashboard.dart';
import 'package:belajar_flutter/page/LupaPassword.dart';
import 'package:belajar_flutter/page/Register.dart';
import 'package:belajar_flutter/services/google_signin_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../configuration/Constant.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers untuk field username dan password
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // Untuk mengatur apakah password tersembunyi atau tidak
  bool isHidden = true;

  // Fungsi untuk melakukan login
  void _login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _usernameController.text,
        password: _passwordController.text,
      );
      // Navigasi ke halaman dashboard jika login berhasil
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              DashboardPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    } on FirebaseAuthException catch (e) {
      // Menampilkan dialog jika login gagal
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Gagal'),
            content: Text('Username atau password salah.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  // Fungsi untuk menavigasi ke halaman pendaftaran
  void _register() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => Register(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }
  static Future<void> signIn(String username, String password, BuildContext context) async {
    // Ganti URL sesuai dengan URL endpoint Anda
    final String apiUrl = '${OrderinAppConstant.baseURL}/login';

    try {
      // Kirim permintaan HTTP POST ke server
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {'username': username, 'password': password,},
      );

      // Periksa status code respons dari server
      if (response.statusCode == 200) {
        // Decode respons JSON
        final responseData = json.decode(response.body);

        // Periksa status dalam respons
        if (responseData['status'] == 'success') {
          // Jika login berhasil, dapatkan response message
           Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage()),
      );

          // Lakukan apa yang perlu dilakukan setelah login berhasil, misalnya navigasi ke halaman beranda
        } else {
          // Jika login gagal, dapatkan pesan error
          String errorMessage = responseData['message'];
          showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Login Gagal'),
                      content: Text(responseData['message']),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );

        }
      } else {
        showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Gagal'),
            content: Text('error 01'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Gagal'),
            content: Text('error 02'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 129, 120),
        title: Text('Eviasi'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Gambar logo
              Image.asset(
                "img/Logo_Eviasi.png",
                width: 150,
                height: 150,
              ),
              SizedBox(height: 20),
              // Field untuk username
              SizedBox(
                width: 500,
                child: TextField(
                  controller: _usernameController,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    labelText: 'Masukkan Username',
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    prefixIcon: Icon(Icons.person, color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 500,
                child: TextField(
                  controller: _passwordController,
                  obscureText: isHidden,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    labelText: 'Masukkan Password',
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
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
                ),
              ),
              SizedBox(height: 20),
              // Tombol untuk lupa password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  ForgotPasswordPage(),
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
                    child: Text(
                      'Lupa Password?',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Tombol untuk login
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: ()async {
                  await signIn(_usernameController.text, _passwordController.text, context);
                }, // Memanggil fungsi login
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 255, 129, 120),
                    onPrimary: Colors.white,
                  ),
                  child: Text('Login'),
                ),
              ),
              SizedBox(height: 20),
              // Tombol untuk pendaftaran
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: _register, // Memanggil fungsi register
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 255, 129, 120),
                    onPrimary: Colors.white,
                  ),
                  child: Text('Register'),
                ),
              ),
              SizedBox(height: 18.0),
              // Tombol untuk login dengan Google
              Consumer<GoogleSignService>(
                builder: (context, googleSignIn, child) {
                  return ElevatedButton(
                    onPressed: () async {
                      // await googleSignIn.googleLogin();
                      // print("NAMA : ${googleSignIn.user.displayName}");
                      // await googleSignIn.logout();
                      // Navigator.push(
                      //   context,
                      //   PageRouteBuilder(
                      //     pageBuilder: (context, animation, secondaryAnimation) =>
                      //         DashboardPage(),
                      //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      //       return FadeTransition(opacity: animation, child: child);
                      //     },
                      //   ),
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          vertical: 11.0, horizontal: 83.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      primary: Colors.white,
                      side: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "img/google.png",
                          width: 24.0,
                          height: 24.0,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'Masuk dengan Google',
                          style: TextStyle(color: Colors.black).copyWith(
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginPage(),
  ));
}

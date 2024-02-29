import 'package:belajar_flutter/src/CustomColors.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.redEviasi,
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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  bool isHidden = true;

  @override
  void dispose() {
    emailController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: TextField(
            controller: emailController,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              labelText: 'Masukkan Email',
              labelStyle: TextStyle(color: Colors.black),
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0), // optional
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0), // optional
              ),
              prefixIcon: Icon(Icons.email, color: Colors.black),
            ),
          ),
        ),
        SizedBox(height: 20),
        SizedBox(
          width: 500,
          child: TextField(
            controller: newPasswordController,
            obscureText: isHidden,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              labelText: 'Masukkan Password',
              labelStyle: TextStyle(color: Colors.black),
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0), // optional
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0), // optional
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
          ),
        ),
        SizedBox(height: 20),
        SizedBox(width: 300,
        child: ElevatedButton(
          onPressed: () {
            // Implement ganti password logic here
          },
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 255, 126, 117),
            onPrimary: Colors.white,
          ),
          child: Text('Ganti Password'),
        ),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ForgotPasswordPage(),
  ));
}

import 'package:flutter/material.dart';
import 'package:belajar_flutter/page/Login.dart';
import 'package:belajar_flutter/src/CustomColors.dart';
import 'package:belajar_flutter/page/Register.dart';

void main() {
  runApp(OTPPage());
}

class OTPPage extends StatelessWidget {
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
            child: OTPForm(),
          ),
        ),
      ),
    );
  }
}

class OTPForm extends StatefulWidget {
  @override=
  _OTPFormState createState() => _OTPFormState();
}

class _OTPFormState extends State<OTPForm> {
  List<TextEditingController> controllers =
      List.generate(5, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 0),
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
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
              // Tambahkan aksi ketika tombol ditekan
            },
            style: ElevatedButton.styleFrom(
              primary: CustomColors.redEviasi, // Mengubah warna tombol menjadi merah
              onPrimary: Colors.white,
            ),
            child: Text('Konfirmasi'),
          ),
        ),
        // Add more widgets here
      ],
    );
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}

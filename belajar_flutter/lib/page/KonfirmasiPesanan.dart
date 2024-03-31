import 'package:belajar_flutter/page/Dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(KonfirmasiPesanan());
}

class KonfirmasiPesanan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Konfirmasi Pesanan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: ConfirmationPage(),
    );
  }
}

class ConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Terima kasih atas pesanan Anda!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.0),
              // Gambar mobil
              Image.asset(
                'img/brio.png', // Sesuaikan dengan path gambar mobil Anda
                width: 150,
                height: 150,
              ),
              SizedBox(height: 20.0),
              Text(
                'Barang yang dibeli:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 5.0),
              Text(
                '1. Poles Body',
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.left,
              ),
              Text(
                '2. Cuci Mesin',
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 20.0),
              Divider(
              thickness: 1.0,
              color: Colors.black,
              ), // Garis atas total pembayaran
              SizedBox(height: 10.0),
              Text(
                'Total Pembayaran: Rp500.000',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left, // Posisikan ke kiri
              ),
              SizedBox(height: 10.0),
              Text(
                'Tanggal Pesanan: 31 Maret 2024',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left, // Posisikan ke kiri
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                 Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  DashboardPage(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ),
                      );  // Implementasi tindakan setelah tombol ditekan
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 255, 129, 120),
                  onPrimary: Colors.white
                ),
                child: Text('Kembali ke Beranda'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
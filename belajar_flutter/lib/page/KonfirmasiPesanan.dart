import 'package:belajar_flutter/page/Dashboard.dart';
import 'package:belajar_flutter/page/ulasan.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';

// Halaman KonfirmasiPesanan dengan parameter konstruktor pemesananData
class KonfirmasiPesanan extends StatefulWidget {
  final List<String> pemesananData;
  final int Pembayaran;
  final String tanggal;
  final File? profileImage;
  KonfirmasiPesanan(
      {required this.pemesananData,
      required this.Pembayaran,
      required this.profileImage,
      required this.tanggal});

  @override
  State<KonfirmasiPesanan> createState() => _KonfirmasiPesananState();
}

class _KonfirmasiPesananState extends State<KonfirmasiPesanan> {
  @override
  void initState() {
    print(widget.pemesananData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> pemesananTerpilih =
        widget.pemesananData.where((item) => item.isNotEmpty).toList();

    return MaterialApp(
      title: 'Konfirmasi Pesanan',
      theme: ThemeData(
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Konfirmasi Pesanan'),
          backgroundColor: const Color.fromARGB(255, 255, 129, 120),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  widget.profileImage != null
                      ? Container(
                          width: double.infinity,
                          height: 300,
                          child: Image(image: FileImage(widget.profileImage!)))
                      : Container(
                          width: double.infinity,
                          height: 300,
                          child: Icon(Icons.person),
                        ),
                  Text(
                    'Terima kasih atas pesanan Anda!',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.0),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: pemesananTerpilih.length,
                    itemBuilder: (context, index) {
                      return Text(
                        '${pemesananTerpilih[index]}',
                        style: TextStyle(fontSize: 18.0),
                        textAlign: TextAlign.left,
                      );
                    },
                  ),
                  SizedBox(height: 20.0),
                  Divider(
                    thickness: 1.0,
                    color: Colors.black,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Total Pembayaran: Rp${widget.Pembayaran}',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Tanggal Pesanan: ${widget.tanggal}',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 30.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 255, 129, 120),
                      onPrimary: Colors.white,
                    ),
                    child: Text('Kembali'),
                  ),
                  SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Navigasi ke halaman untuk mengirim ulasan
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ulasan()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                  ),
                  child: Text('Kirim Ulasan'),
                ),
              ],
            ),
          ),
        ),
      ),
      ),
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
              Image.asset(
                'img/brio.png',
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
              ),
              SizedBox(height: 10.0),
              Text(
                'Total Pembayaran: Rp500.000',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 10.0),
              Text(
                'Tanggal Pesanan: 31 Maret 2024',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
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
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 255, 129, 120),
                  onPrimary: Colors.white,
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

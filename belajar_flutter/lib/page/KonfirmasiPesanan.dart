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
  const KonfirmasiPesanan(
      {super.key, required this.pemesananData,
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
          title: const Text('Konfirmasi Pesanan'),
          backgroundColor: const Color.fromARGB(255, 255, 129, 120),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  widget.profileImage != null
                      ? SizedBox(
                          width: double.infinity,
                          height: 300,
                          child: Image(image: FileImage(widget.profileImage!)))
                      : SizedBox(
                          width: double.infinity,
                          height: 300,
                          child: const Icon(Icons.person),
                        ),
                  const Text(
                    'Terima kasih atas pesanan Anda!',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10.0),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: pemesananTerpilih.length,
                    itemBuilder: (context, index) {
                      return Text(
                        pemesananTerpilih[index],
                        style: const TextStyle(fontSize: 18.0),
                        textAlign: TextAlign.left,
                      );
                    },
                  ),
                  const SizedBox(height: 20.0),
                  const Divider(
                    thickness: 1.0,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Total Pembayaran: Rp${widget.Pembayaran}',
                    style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Tanggal Pesanan: ${widget.tanggal}',
                    style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 30.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 255, 129, 120),
                    ),
                    child: const Text('Kembali'),
                  ),
                  const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Navigasi ke halaman untuk mengirim ulasan
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ulasan()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.blue,
                  ),
                  child: const Text('Kirim Ulasan'),
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
  const ConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Terima kasih atas pesanan Anda!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0),
              Image.asset(
                'img/brio.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Barang yang dibeli:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 5.0),
              const Text(
                '1. Poles Body',
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.left,
              ),
              const Text(
                '2. Cuci Mesin',
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 20.0),
              const Divider(
                thickness: 1.0,
                color: Colors.black,
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Total Pembayaran: Rp500.000',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Tanggal Pesanan: 31 Maret 2024',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 30.0),
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
                  foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 255, 129, 120),
                ),
                child: const Text('Kembali ke Beranda'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

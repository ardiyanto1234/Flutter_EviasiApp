import 'package:belajar_flutter/page/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:belajar_flutter/src/CustomColors.dart';

void main() {
  runApp(WorkshopInformation());
}

class WorkshopInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Info Kami',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: InfoPage(),
    );
  }
}

class InfoPage extends StatelessWidget {
  final List<String> img = [
  
    "img/banner depan.png",
   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.redEviasi,
        title: Text('Info Kami'),
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
                          DashboardPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      })); // Kembali ke halaman sebelumnya
            },
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          // Wrap the column with SingleChildScrollView
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: img.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Image.asset(
                        img[index],
                        width: 350,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
             SizedBox(height: 20),
              Center( // Pindahkan teks "Nama Perusahaan" ke tengah
                child: Text(
                  'Prestasi salon mobil',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center( // Pindahkan teks "Deskripsi perusahaan" ke tengah
                child: Text(
                  'Prestasi Salon Mobil & Variasi Mobil merupakan salah satu bengkel variasi di Kabupaten Nganjuk. Bengkel ini menjual dan melayani pemasangan variasi dan aksesoris kendaraan. Prestasi Salon Mobil & Variasi Mobil menawarkan jasa dan produk variasi dengan harga terjangkau. Kunjungi bengkel variasi terdekat ini untuk informasi lainnya seperti daftar harga, pemesanan dan list produk. Anda juga bisa menghubungi kontak nomor telepon jika tersedia. Jam buka / jam kerja:Senin - Sabtu : 08:00 - 17:00 WIB Minggu : Libur.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InfoCard(
                    title: 'Alamat',
                    value: 'Jl. Merapi No.52, Besuk',
                  ),
                  InfoCard(
                    title: 'Telepon',
                    value: '+62 123 456 789',
                  ),
                ],
              ),
              SizedBox(height: 20),
              // RaisedButton(
              //   onPressed: () {
              //     // Aksi yang dijalankan ketika tombol ditekan
              //   },
              //   child: Text('Hubungi Kami'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
class InfoCard extends StatelessWidget {
  final String title;
  final String value;

  const InfoCard({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:belajar_flutter/src/CustomColors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(notif());
}

class notif extends StatelessWidget {
  const notif({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Riwayat> riwayatDiterima = [
    Riwayat(
      namaMobil: 'Brio',
      warnaMobil: 'putih',
      tipePelayanan: 'Variasi',
      tanggalPelayanan: DateTime(2023, 10, 20),
      status: 'Diterima',
    ),
    Riwayat(
      namaMobil: 'Brio',
      warnaMobil: 'putih',
      tipePelayanan: 'Detailing',
      tanggalPelayanan: DateTime(2023, 10, 10),
      status: 'Diterima',
    ),
  ];

  List<Riwayat> riwayatDitolak = [
    Riwayat(
      namaMobil: 'Brio',
      warnaMobil: 'putih',
      tipePelayanan: 'Variasi',
      tanggalPelayanan: DateTime(2023, 9, 29),
      status: 'Ditolak',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.redEviasi,
        title: const Text('Riwayat Pesanan'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Riwayat Diterima',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Lihat Semua',
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: riwayatDiterima.length,
              itemBuilder: (context, index) {
                final item = riwayatDiterima[index];
                return Card(
                  margin: const EdgeInsets.all(16),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nama Mobil: ${item.namaMobil}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Warna Mobil: ${item.warnaMobil}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tipe Pelayanan: ${item.tipePelayanan}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tanggal Pelayanan: ${item.tanggalPelayanan.day}-${item.tanggalPelayanan.month}-${item.tanggalPelayanan.year}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Status: ${item.status}',
                          style: const TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Riwayat Ditolak',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Lihat Semua',
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: riwayatDitolak.length,
              itemBuilder: (context, index) {
                final item = riwayatDitolak[index];
                return Card(
                  margin: const EdgeInsets.all(16),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nama Mobil: ${item.namaMobil}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Warna Mobil: ${item.warnaMobil}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tipe Pelayanan: ${item.tipePelayanan}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tanggal Pelayanan: ${item.tanggalPelayanan.day}-${item.tanggalPelayanan.month}-${item.tanggalPelayanan.year}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Status: ${item.status}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Riwayat {
  String namaMobil;
  String warnaMobil;
  String tipePelayanan;
  DateTime tanggalPelayanan;
  String status;

  Riwayat({
    required this.namaMobil,
    required this.warnaMobil,
    required this.tipePelayanan,
    required this.tanggalPelayanan,
    required this.status,
  });
}
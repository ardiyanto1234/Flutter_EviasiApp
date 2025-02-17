import 'dart:convert';

import 'package:belajar_flutter/page/Login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HistoryPemesananPage extends StatefulWidget {
  const HistoryPemesananPage({super.key});

  @override
  State<HistoryPemesananPage> createState() => _HistoryPemesananPageState();
}

class _HistoryPemesananPageState extends State<HistoryPemesananPage> {
  Future<Map<String, dynamic>> fetchHistory(String userId) async {
    final url = Uri.parse('http://efiasi.tifnganjuk.com/api/MobileApi/history'); // Update with your API URL
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'id': userId}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load history');
    }
  }


  @override
  void initState() {
    super.initState();
    fetchHistory(LoginPage.id); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchHistory(LoginPage.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!['status'] != 'success') {
            return const Center(child: Text('No history found'));
          }
          final historyData = snapshot.data!['data'] as List;
          return ListView.builder(
            itemCount: historyData.length,
            itemBuilder: (context, index) {
              final service = historyData[index];
              return ListTile(
                title: Text(service['nama_lengkap']),
                subtitle: Text(service['tipe_service']),
                trailing: Text('Rp ${service['harga']}'),
              );
            },
          );
        },
      ),
    );
  }
}
class DetailUlasanPage extends StatelessWidget {
  final String namaPemesan;

  const DetailUlasanPage({super.key, required this.namaPemesan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ulasan oleh $namaPemesan'),
      ),
      body: Center(
        child: Text('Ini adalah halaman detail ulasan oleh $namaPemesan'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HistoryPemesananPage(),
  ));
}

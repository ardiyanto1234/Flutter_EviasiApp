import 'package:belajar_flutter/page/ulasan.dart';
import 'package:flutter/material.dart';

class HistoryPemesananPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 4, 
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text('Atilah lazuardi ${index + 1}'),
              subtitle: Text('Salon Mobil'), 
              trailing: Text('Rp 100.000'), 
              onTap: () {
                 Navigator.push
                      (context, 
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation ) =>
                        ulasan(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return FadeTransition(opacity: animation,
                          child: child,
                          );
                        } ,
                      ),
                      );
              },
            ),
          );
        },
      ),
    );
  }
}

class DetailUlasanPage extends StatelessWidget {
  final String namaPemesan;

  DetailUlasanPage({required this.namaPemesan});

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

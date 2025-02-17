import 'package:belajar_flutter/page/Dashboard.dart';
import 'package:flutter/material.dart';
import 'HalamanTiga.dart';

void main() {
  runApp(DeskripsiVariasi());
  
}

class Product {
  final String name;
  final List<String> descriptions;
  final String imagePath;

  Product({required this.name, required this.descriptions, required this.imagePath});
}

class DeskripsiVariasi extends StatelessWidget {
  final Product product = Product(
    name: "Variasi",
    descriptions: [
      "Lampu mobil adalah bagian penting dari kendaraan yang memberikan pencahayaan saat berkendara di kondisi cahaya rendah atau di malam hari. Ini termasuk lampu utama depan dan belakang, lampu sein, lampu hazard, lampu rem, lampu mundur, dan lampu kabut. Lampu mobil membantu pengemudi melihat jalan dengan lebih jelas dan memberikan sinyal kepada pengemudi lain tentang niat berbelok atau berhenti. Ini juga meningkatkan keselamatan pengemudi, penumpang, dan pengguna jalan lainnya.",
    ],
    imagePath: "img/lampu.png",
  );

  DeskripsiVariasi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Detail',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 129, 119),
          title: Text(product.name),
        ),
        
         body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 200, 
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage(product.imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Deskripsi Produk:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: product.descriptions.map((desc) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(desc),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              Center(
                child:SizedBox(
            width: 200,
         child: ElevatedButton(
            onPressed: () {
                Navigator.push
                      (context, 
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation ) =>
                        HalamanTiga(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return FadeTransition(opacity: animation,
                          child: child,
                        );
                          },
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 255, 129, 119),
                    ),
                    child: const Text('Segera Pesan'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
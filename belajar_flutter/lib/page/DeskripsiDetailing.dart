import 'package:belajar_flutter/page/Dashboard.dart';
import 'package:flutter/material.dart';
import 'HalamanDua.dart';
void main() {
  runApp(DeskripsiDetailing());
  
}

class Product {
  final String name;
  final List<String> descriptions;
  final String imagePath;

  Product({required this.name, required this.descriptions, required this.imagePath});
}

class DeskripsiDetailing extends StatelessWidget {
  final Product product = Product(
    name: "Detailing mobil",
    descriptions: [
      "Interior detailing adalah proses pembersihan dan perawatan dalam kendaraan untuk menjaga kebersihan, keamanan, dan kenyamanan penggunanya. Ini melibatkan pembersihan mendalam dari setiap bagian interior kendaraan, termasuk kursi, karpet, panel pintu, konsol, jok, dan area lainnya. Selama proses interior detailing, berbagai teknik dan produk pembersih khusus digunakan untuk menghilangkan debu, kotoran, noda, dan bau yang menempel pada permukaan interior kendaraan. Ini bisa meliputi vakum, pembersihan kering, pembersihan basah, penghilangan noda, dan perlindungan permukaan.",
    ],
    imagePath: "img/interior.png",
  );

  DeskripsiDetailing({super.key});

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
                        HalamanDua(),
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
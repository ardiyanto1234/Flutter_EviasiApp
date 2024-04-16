import 'package:belajar_flutter/page/Dashboard.dart';
import 'package:flutter/material.dart';

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
    name: "Detailing mobil",
    descriptions: [
      "Interior detailing adalah proses pembersihan dan perawatan dalam kendaraan untuk menjaga kebersihan, keamanan, dan kenyamanan penggunanya. Ini melibatkan pembersihan mendalam dari setiap bagian interior kendaraan, termasuk kursi, karpet, panel pintu, konsol, jok, dan area lainnya. Selama proses interior detailing, berbagai teknik dan produk pembersih khusus digunakan untuk menghilangkan debu, kotoran, noda, dan bau yang menempel pada permukaan interior kendaraan. Ini bisa meliputi vakum, pembersihan kering, pembersihan basah, penghilangan noda, dan perlindungan permukaan.",
    ],
    imagePath: "img/interior.png",
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Detail',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 129, 119),
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
                    Text(
                      'Deskripsi Produk:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
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
              SizedBox(height: 24.0),
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
                      primary: Color.fromARGB(255, 255, 129, 119),
                    ),
                    child: Text('Segera Pesan'),
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
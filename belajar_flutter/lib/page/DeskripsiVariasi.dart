import 'package:belajar_flutter/page/DeskripsiDetailing.dart';
import 'package:belajar_flutter/page/DeskripsiVariasi.dart';
import 'package:flutter/material.dart';
import 'package:belajar_flutter/page/Dashboard.dart';


void main(){
  runApp(_DeskripsiVariasState());
}

class product{
  final String name;
  final List<String> descriptions;
  final String imagePath;

  product({required this.name, required this.descriptions, required this.imagePath});
}
class _DeskripsiVariasState extends StatefulWidget {
  final Product product = Product(
    name: "Variasi Mobil",  
    descriptions:[ 
      'descriptions',
    ], 
    imagePath: "imagePath",
    );

  @override
  State<_DeskripsiVariasState> createState() => __DeskripsiVariasStateState();
}

class __DeskripsiVariasStateState extends State<_DeskripsiVariasState> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
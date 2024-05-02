import 'dart:io';
import 'package:belajar_flutter/page/DeskripsiDetailing.dart';
import 'package:belajar_flutter/page/DeskripsiVariasi.dart';
import 'package:belajar_flutter/page/HalamanDua.dart';
import 'package:belajar_flutter/page/HistoryPemesananPage.dart';
import 'package:belajar_flutter/page/KonfirmasiPesanan.dart';
import 'package:belajar_flutter/page/notif.dart';
import 'package:belajar_flutter/src/CustomColors.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'Profilepage.dart';
import 'infoBengkel.dart';

class HalamanTiga extends StatefulWidget {
  //codingan halaman Tiga
  @override
  State<HalamanTiga> createState() => _HalamanTigaState();
}

class _HalamanTigaState extends State<HalamanTiga> {
  //TextController untuk edit text
  TextEditingController jenisMobilController = TextEditingController();
  TextEditingController tanggalPemesananController = TextEditingController();
  TextEditingController deskripsiPemesananController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  List<bool> _checked = List.generate(6, (index) => false);
  List<String> _jenisPemesanan = [
    //untuk menginputkan list
    'Lampu',
    'Stiker',
    'Ban',
    'velg',
    'Audio',
    'Kaca Film',
  ];

  List<double> _hargaPilihan = [50.0, 30.0, 20.0, 40.0, 60.0, 25.0];
  double _totalHarga = 0.0;

  void _hitungTotalHarga() {
    double total = 0.0;
    for (int i = 0; i < _checked.length; i++) {
      if (_checked[i]) {
        total += _hargaPilihan[i];
      }
    }
    setState(() {
      _totalHarga = total;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        tanggalPemesananController.text =
            "${picked.day} - ${picked.month} -${picked.year}";
      });
  }

  ImagePicker _imagePicker = ImagePicker();
  File? _profileImage;

  Future<void> _getImage() async {
    final PickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      setState(() {
        _profileImage = File(PickedFile.path);
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.redEviasi,
        title: Text("Sparepart Variasi"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Variasi Mobil',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              TextField(
                controller: jenisMobilController,
                decoration: InputDecoration(
                    hintText: 'Masukan jenis',
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.grey[350],
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0),
                    )),
              ),
              SizedBox(height: 20),
              Text(
                'Tanggal Pemesanan:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: tanggalPemesananController,
                readOnly: true,
                onTap: () {
                  _selectDate(context);
                },
                decoration: InputDecoration(
                  hintText: 'Pilih tanggal pemesanan',
                  labelStyle: TextStyle(color: Colors.black),
                  fillColor: Colors.grey[350],
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Keluhan:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              SizedBox(
                width: 500,
                child: TextField(
                  controller: deskripsiPemesananController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: 'Keluhan anda',
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.grey[350],
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Jenis Pemesanan:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DMSerifDisplay',
                ),
              ),
              Column(
                children: List.generate(_jenisPemesanan.length, (index) {
                  return CheckboxListTile(
                    title: Text(_jenisPemesanan[index]),
                    value: _checked[index],
                    onChanged: (value) {
                      setState(() {
                        _checked[index] = value!;
                        _hitungTotalHarga();
                      });
                    },
                  );
                }),
              ),
              SizedBox(height: 20),
              Text(
                'Total Harga:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.all(20.0),
                child: Text(
                  '$_totalHarga',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Upload Foto Mobil',
                style: TextStyle(
                  fontSize: 16, 
                  fontWeight: FontWeight.bold
                  ),
                ),
               IconButton(
                icon: Icon(Icons.add_a_photo),
                onPressed: _getImage,
              ),
              _profileImage != null
                  ? Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 300,
                          color: Colors.white,
                        ),
                        Center(
                          child: _profileImage != null
                              ? Image(image: FileImage(_profileImage!))
                              : Icon(
                                  Icons.plus_one,
                                  size: 150,
                                  color: Colors.grey,
                                ),
                        ),
                        if (_profileImage == null)
                          Center(
                            child: Icon(Icons.add, size: 50, color: Colors.grey),
                          ),
                      ],
                    )
                  : Container(
                      width: double.infinity,
                      height: 300,
                      child: Icon(Icons.person),
                    ),
                SizedBox(height: 20),
                SizedBox( 
                  width:400,
               child: ElevatedButton(
                  onPressed: (){
                    Navigator.push
                    (context,
                     PageRouteBuilder(
                     pageBuilder: (context, animation, secondaryAnimation ) =>
                     KonfirmasiPesanan(),
                     transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation,
                      child: child,
                      );
                     },
                     ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 255, 129, 120),
                    onPrimary: Colors.white
                  ),
                  child: Text('Konfirmasi Pesanan'),
                ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
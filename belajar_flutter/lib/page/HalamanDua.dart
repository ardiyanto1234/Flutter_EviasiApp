import 'dart:convert';
import 'dart:convert';
import 'dart:io';
import 'package:belajar_flutter/configuration/Constant.dart';
import 'package:belajar_flutter/page/DeskripsiDetailing.dart';
import 'package:belajar_flutter/page/DeskripsiVariasi.dart';
import 'package:belajar_flutter/page/HalamanDua.dart';
import 'package:belajar_flutter/page/HistoryPemesananPage.dart';
import 'package:belajar_flutter/page/KonfirmasiPesanan.dart';
import 'package:belajar_flutter/page/Login.dart';
import 'package:belajar_flutter/page/notif.dart';
import 'package:belajar_flutter/src/CustomColors.dart';
import 'package:d_method/d_method.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'Profilepage.dart';
import 'infoBengkel.dart';
import 'HalamanTiga.dart';
import 'package:http/http.dart' as http;

class HalamanDua extends StatefulWidget {
  const HalamanDua({super.key});

  @override
  _HalamanDuaState createState() => _HalamanDuaState();
}

class _HalamanDuaState extends State<HalamanDua> {
  TextEditingController jenisMobilController = TextEditingController();
  TextEditingController tanggalPemesananController = TextEditingController();
  TextEditingController deskripsiPemesananController = TextEditingController();
  String _jenisPemesananData = '';
  DateTime selectedDate = DateTime.now();
  final List<bool> _checked = List.generate(6, (index) => false);
  final List<String> _jenisPemesanan = [
    'Poles Body',
    'Cuci Mesin',
    'Cuci Velg & Ban',
    'Poles Kaca',
    'Eksterior',
    'Cuci Interior',
  ];

  final List<double> _hargaPilihan = [
    500.000,
    300.000,
    200.000,
    400.000,
    600.000,
    250.000
  ];
  double _totalHarga = 0.0;
  File? _image;
  final picker = ImagePicker();

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
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        String formattedDate =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
        tanggalPemesananController.text = formattedDate;
      });
    }
  }

  final ImagePicker _imagePicker = ImagePicker();
  File? _profileImage;

  Future<void> _getImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _profileImage = File(pickedFile.path);
      });
      return;
    }
  }

  // Function to submit pemesanan
  Future<void> submitPemesanan() async {
    try {
      // Show loading dialog
      // showDialog(
      //   context: context,
      //   barrierDismissible: false,
      //   builder: (BuildContext context) {
      //     return Center(child: CircularProgressIndicator());
      //   },
      // );

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            "${OrderinAppConstant.baseURL}/pemesanan"), // Replace with your API URL
      );

      request.headers['Content-Type'] = 'application/json; charset=UTF-8';

      request.fields['jenis_mobil'] = jenisMobilController.text;
      request.fields['tanggal_pemesanan'] = tanggalPemesananController.text;
      request.fields['keluhan'] = deskripsiPemesananController.text;
      request.fields['harga'] = _totalHarga.toString();
      request.fields['detailing_dan_variasi'] = _jenisPemesananData;
      request.fields['user_id'] = LoginPage.id;

      var pic = await http.MultipartFile.fromPath('gambar', _image!.path);
      request.files.add(pic);

      var response = await request.send();

      Navigator.pop(context); // Close loading dialog

      if (response.statusCode == 201) {
        // Pesanan berhasil dibuat
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KonfirmasiPesanan(
              profileImage: _profileImage,
                Pembayaran: _totalHarga.toInt(),
                tanggal: tanggalPemesananController.text,
                pemesananData: _jenisPemesananData.split(' ')), // Kirim data pemesanan
          ),
        );
      } else {
        // Pesanan gagal dibuat
        var responseData = await response.stream.bytesToString();
        String errorMessage =
            json.decode(responseData)['message'] ?? 'Terjadi kesalahan';
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Gagal'),
              content: Text(errorMessage),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Terjadi kesalahan
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Terjadi kesalahan: $e'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.redEviasi,
        title: const Text("Detailing Mobil"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Jenis Mobil:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: jenisMobilController,
                decoration: InputDecoration(
                  hintText: 'Masukkan jenis mobil',
                  labelStyle: const TextStyle(color: Colors.black),
                  fillColor: Colors.grey[350],
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Tanggal Pemesanan:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: tanggalPemesananController,
                readOnly: true,
                onTap: () {
                  _selectDate(context);
                },
                decoration: InputDecoration(
                  hintText: 'Pilih tanggal pemesanan',
                  labelStyle: const TextStyle(color: Colors.black),
                  fillColor: Colors.grey[350],
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Keluhan:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: 500,
                child: TextField(
                  controller: deskripsiPemesananController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: 'Keluhan anda',
                    labelStyle: const TextStyle(color: Colors.black),
                    fillColor: Colors.grey[350],
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Jenis Pemesanan:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
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
                        if (value) {
                          _jenisPemesananData =
                              '$_jenisPemesananData ${_jenisPemesanan[index]}';
                        } else {
                          _jenisPemesananData = _jenisPemesananData.replaceAll(
                              _jenisPemesanan[index], '');
                        }
                      });
                    },
                  );
                }),
              ),
              const SizedBox(height: 20),
              const Text(
                'Total Harga:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.black,
                    width: 0,
                  ),
                ),
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  '$_totalHarga',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Upload Foto Mobil',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.add_a_photo),
                onPressed: () async {
                  await _getImage();
                },
              ),
              _profileImage != null
                  ? SizedBox(
                      width: double.infinity,
                      height: 300,
                      child: Image(image: FileImage(_profileImage!)))
                  : SizedBox(
                      width: double.infinity,
                      height: 300,
                      child: const Icon(Icons.person),
                    ),
              const SizedBox(height: 20),
              SizedBox(
                width: 400,
                child: ElevatedButton(
                  onPressed: () {
                    submitPemesanan();
                    DMethod.log(
                      'jenis mobile : ${jenisMobilController.text}',
                    );
                    DMethod.log(
                      'tanggal pemesanan : ${tanggalPemesananController.text}',
                    );
                    DMethod.log(
                      'keluhan : ${deskripsiPemesananController.text}',
                    );
                    DMethod.log(
                      'jenis pemesanan : $_jenisPemesananData',
                    );
                    DMethod.log('total harga : $_totalHarga');
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 255, 129, 120)),
                  child: const Text('Konfirmasi Pesanan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

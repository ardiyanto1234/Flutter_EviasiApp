import 'dart:convert';
import 'dart:convert';
import 'dart:io';
import 'package:belajar_flutter/configuration/Constant.dart';
import 'package:belajar_flutter/page/DeskripsiDetailing.dart';
import 'package:belajar_flutter/page/DeskripsiVariasi.dart';
import 'package:belajar_flutter/page/HalamanDua.dart';
import 'package:belajar_flutter/page/HistoryPemesananPage.dart';
import 'package:belajar_flutter/page/KonfirmasiPesanan.dart';
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
  @override
  _HalamanDuaState createState() => _HalamanDuaState();
}

class _HalamanDuaState extends State<HalamanDua> {
  TextEditingController jenisMobilController = TextEditingController();
  TextEditingController tanggalPemesananController = TextEditingController();
  TextEditingController deskripsiPemesananController = TextEditingController();
  String _jenisPemesananData = '';
  DateTime selectedDate = DateTime.now();
  List<bool> _checked = List.generate(6, (index) => false);
  List<String> _jenisPemesanan = [
    'Poles Body',
    'Cuci Mesin',
    'Cuci Velg & Ban',
    'Poles Kaca',
    'Eksterior',
    'Cuci Interior',
  ];

  List<double> _hargaPilihan = [50.0, 30.0, 20.0, 40.0, 60.0, 25.0];
  double _totalHarga = 0.0;
  File? _image = null;
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

  ImagePicker _imagePicker = ImagePicker();
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

  Future<void> submitPemesanan() async {
    try {
      OrderinAppConstant.showLoading(context: context, canPop: true);
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${OrderinAppConstant.baseURL}/pemesanan'), // URL e Cocok no
      );

      request.headers['Content-Type'] = 'application/json; charset=UTF-8';

      request.fields['jenis_mobil'] = jenisMobilController.text;
      request.fields['tanggal_pemesanan'] = tanggalPemesananController.text;
      request.fields['keluhan'] = deskripsiPemesananController.text;
      request.fields['harga'] = _totalHarga.toString();
      request.fields['detailing_dan_variasi'] = _jenisPemesananData;

      // return;

      var pic = await http.MultipartFile.fromPath('gambar', _image!.path);
      request.files.add(pic);

      var response = await request.send();

      Navigator.pop(context);

      if (response.statusCode == 201) {
        // Pesanan berhasil dibuat
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sukses'),
              content: Text('Pesanan berhasil dibuat!'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => KonfirmasiPesanan()),
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
              title: Text('Gagal'),
              content: Text(errorMessage),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
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
            title: Text('Error'),
            content: Text('Terjadi kesalahan: $e'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
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
        title: Text("Detailing Mobil"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Jenis Mobil:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: jenisMobilController,
                decoration: InputDecoration(
                  hintText: 'Masukkan jenis mobil',
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
                  ),
                ),
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
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
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
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.black,
                    width: 0,
                  ),
                ),
                padding: EdgeInsets.all(20.0),
                child: Text(
                  '$_totalHarga',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Upload Foto Mboil',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.add_a_photo),
                onPressed: () async {
                  await _getImage();
                },
              ),
              _profileImage != null
                  ? Container(
                      width: double.infinity,
                      height: 300,
                      child: Image(image: FileImage(_profileImage!)))
                  : Container(
                      width: double.infinity,
                      height: 300,
                      child: Icon(Icons.person),
                    ),
              SizedBox(height: 20),
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
                      primary: Color.fromARGB(255, 255, 129, 120),
                      onPrimary: Colors.white),
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
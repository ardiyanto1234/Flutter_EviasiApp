import 'package:belajar_flutter/page/HalamanDua.dart';
import 'package:belajar_flutter/page/HistoryPemesananPage.dart';
import 'package:belajar_flutter/src/CustomColors.dart';
import 'package:flutter/material.dart';
import 'Profilepage.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 129, 120),
        title: Text("EVIASI"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.notifications_active),
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          DashboardHome(),
          HistoryPemesananPage(), 
          ProfilePage(), 
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: CustomColors.blackColor,
        fixedColor: CustomColors.whiteColor,
        backgroundColor: CustomColors.redEviasi,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            backgroundColor: CustomColors.redEviasi,
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: CustomColors.redEviasi,
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            backgroundColor: CustomColors.redEviasi,
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}




class HalamanDua extends StatefulWidget {
  @override
  State<HalamanDua> createState() => _HalamanDuaState();
}
class _HalamanDuaState extends State<HalamanDua> {
  TextEditingController jenisMobilController = TextEditingController();
  TextEditingController tanggalPemesananController = TextEditingController();
  TextEditingController deskripsiPemesananController = TextEditingController();
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
            "${picked.day}-${picked.month}-${picked.year}";
      });
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
              SizedBox(height: 10),
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
              SizedBox(height: 20),
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
            ],
          ),
        ),
      ),
    );
  }
}


class HalamanTiga extends StatefulWidget {
  @override
    State<HalamanTiga> createState() => _HalamanTigaState();
}
 class _HalamanTigaState extends State<HalamanTiga>{ 
  TextEditingController jenisMobilController = TextEditingController();
  TextEditingController tanggalPemesananController = TextEditingController();
  TextEditingController deskripsiPemesananController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  List<bool> _checked = List.generate(6, (index) => false);
  List<String> _jenisPemesanan = [
    'Lampu',
    'Stiker',
    'Ban',
    'velg',
    'Audio',
    'Kaca Film',
  ];

  List<double> _hargaPilihan =[50.0, 30.0, 20.0, 40.0, 60.0, 25.0];
  double _totalHarga = 0.0;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.redEviasi,
        title: Text("Sparepart Variasi"),
      ),
      body: Center(
        child: Text("Coming Soon"),
      ),
    );
  }
 }
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }


class DashboardHome extends StatefulWidget {
  const DashboardHome({Key? key}) : super(key: key);

  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  int _selectedIndex = 0;

  final List<String> img = [
    "img/image 15.png",
    "img/banner depan.png",
    "img/image 14.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: img.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Image.asset(
                      img[index],
                      width: 250,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        HalamanDua(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 255, 129, 120),
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20),
                minimumSize: Size(130, 40),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Detailing mobil',
                    style: TextStyle(fontSize: 18),
                  ),
                  Icon(Icons.car_repair,
                      size: 50.0,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
               Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        HalamanTiga(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 255, 129, 120),
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  minimumSize: Size(130, 40)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sparepart Variasi',
                    style: TextStyle(fontSize: 18),
                  ),
                  Icon(Icons.directions_car_sharp,
                      size: 50.0,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: file_names
// import 'dart:async';
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
import 'HalamanTiga.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

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
      backgroundColor: const Color.fromARGB(255, 255, 129, 120),
      title: const Text("EVIASI"),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    WorkshopInformation(),
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
          icon: const Icon(Icons.info),
        ),
        // IconButton(
        //   onPressed: () {
        //      Navigator.push(
        //       context,
        //       PageRouteBuilder(
        //         pageBuilder: (context, animation, secondaryAnimation) =>
        //             notif(),
        //         transitionsBuilder:
        //             (context, animation, secondaryAnimation, child) {
        //           return FadeTransition(
        //             opacity: animation,
        //             child: child,
        //           );
        //         },
        //       ),
        //     );
        //          },
        //   icon: Icon(Icons.notifications),
        // ),
      ],
    ),


      body: IndexedStack(
        index: _currentIndex,
        children: [
          const DashboardHome(),
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
            icon: const Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: CustomColors.redEviasi,
            icon: const Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            backgroundColor: CustomColors.redEviasi,
            icon: const Icon(Icons.person),
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
  final int _selectedIndex = 0;

  final List<String> img = [
    "img/image 15.png",
    "img/banner depan.png",
    "img/image 14.png",
  ];

  final List<String> popularDetailingImages = [
    "img/Vector.png",
    "img/interior.png",
  ];

  final List<String> popularvarisaiimage = [
    "img/audio.png",
    "img/lampu.png",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          // Wrap the column with SingleChildScrollView
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
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Image.asset(
                        img[index],
                        width: 250,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
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
                  foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 255, 129, 120),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  minimumSize: const Size(130, 40),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Detailing mobil',
                      style: TextStyle(fontSize: 18),
                    ),
                    Icon(Icons.car_repair,
                        size: 50.0, color: Color.fromARGB(255, 255, 255, 255)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
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
                    foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 255, 129, 120),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    minimumSize: const Size(130, 40)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sparepart Variasi',
                      style: TextStyle(fontSize: 18),
                    ),
                    Icon(Icons.directions_car_sharp,
                        size: 50.0, color: Color.fromARGB(255, 255, 255, 255)),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Detailing mobil',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: popularDetailingImages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Image.asset(
                        popularDetailingImages[index],
                        width: 250,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push
                      (context, 
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation ) =>
                        DeskripsiDetailing(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return FadeTransition(opacity: animation,
                          child: child,
                          );  
                },
                      ),
                      );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 255, 129, 120),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  minimumSize: const Size(130, 40),
                ),
                child: const Text(
                  'Selengkapnya',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Variasi Mobil",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  itemCount: popularvarisaiimage.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Image.asset(
                        popularvarisaiimage[index],
                        width: 250,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push
                  (context,
                  PageRouteBuilder(
                    pageBuilder:(context, animation, secondaryAnimation) =>
                     DeskripsiVariasi(),
                     transitionsBuilder: (context, animation, secondaryAnimation, child) {
                       return FadeTransition(opacity: animation, child: child,
                       );
                     },
                     ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 255, 129, 120),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  minimumSize: const Size(130, 40),
                ),
                child: const Text(
                  'Selengkapnya',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

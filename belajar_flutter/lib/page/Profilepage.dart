import 'dart:convert';
import 'package:belajar_flutter/configuration/Constant.dart';
import 'package:belajar_flutter/page/EditProfilePage.dart';
import 'package:belajar_flutter/page/Login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String jsonDetailUser = "{}";
  // Initialize as an empty JSON object
  Map<String, dynamic> detailUser = {};
  // Initialize as an empty map

  static String email = "";
  static String nama = "";
  static String no_hp = "";
  static String alamat = "";
  
  Future getDetailUser() async {
    final String apiUrl = '${OrderinAppConstant.baseURL}/profile';
    final response = await http
        .post(Uri.parse(apiUrl), body: {"id": LoginPage.id});

    if (response.statusCode == 200) {
      jsonDetailUser = response.body.toString();
      detailUser = json.decode(jsonDetailUser);
      if (detailUser.isNotEmpty) {
        setState(() {
          print("output $nama");
          print("output $email");
          print("output $no_hp");
          print("output $alamat");
          nama = detailUser['name'];
          email = detailUser['email'];
          no_hp = detailUser['no_hp'];
          alamat = detailUser['alamat'];
        });
      } else {
        print("No data available");
      }
    } else {
      print("HTTP Request failed with status: ${response.statusCode}");
    }
  }

  @override
  void initState() {
    print("id user =  ${LoginPage.id}");
    getDetailUser();
    fetchProfiles();
    print("testingggggg");
    setState(() {
    print("id user =  ${LoginPage.id}");
      getDetailUser();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Profile',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('img/admin.png'),
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    title: const Text('Nama'),
                    subtitle: Text(nama),
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  ListTile(
                    title: const Text('Email'),
                    subtitle: Text(email),
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  ListTile(
                    title: const Text('No. Telepon'),
                    subtitle: Text(no_hp),
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  ListTile(
                    title: const Text('Alamat'),
                    subtitle: Text(alamat),
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      EditProfilePage(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 247, 165, 0),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          minimumSize: const Size(130, 40),
                        ),
                        child: const Text('Edit Profil'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      LoginPage(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ),
                          );

                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 255, 17, 0),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          minimumSize: const Size(130, 40),
                        ),
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ));
  }

  Future<List<dynamic>> fetchProfiles() async {
    final response = await http
        .get(Uri.parse("http://efiasi.tifnganjuk.com/api/MobileApi/profile"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("error");
      throw Exception('Failed to load profiles');
    }
  }
}

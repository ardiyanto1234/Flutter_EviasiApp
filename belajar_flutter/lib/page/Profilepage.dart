import 'dart:convert';
import 'dart:convert';
import 'package:belajar_flutter/configuration/Constant.dart';
import 'package:belajar_flutter/page/EditProfilePage.dart';
import 'package:belajar_flutter/page/Login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
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
        .post(Uri.parse(apiUrl), body: {"id_user": LoginPage.id_user});

    if (response.statusCode == 200) {
      jsonDetailUser = response.body.toString();
      detailUser = json.decode(jsonDetailUser);
      if (detailUser.isNotEmpty) {
        setState(() {
          print("output " + nama);
          print("output " + email);
          print("output " + no_hp);
          print("output " + alamat);
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
    super.initState();
    getDetailUser();
    print("testingggggg");
    setState(() {
      getDetailUser();
    });
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
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('img/admin.png'),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    title: Text('Nama'),
                    subtitle: Text(nama),
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  ListTile(
                    title: Text('Email'),
                    subtitle: Text(email),
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  ListTile(
                    title: Text('No. Telepon'),
                    subtitle: Text(no_hp),
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  ListTile(
                    title: Text('Alamat'),
                    subtitle: Text(alamat),
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  SizedBox(height: 20),
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
                          primary: Color.fromARGB(255, 247, 165, 0),
                          onPrimary: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          minimumSize: Size(130, 40),
                        ),
                        child: Text('Edit Profil'),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 255, 17, 0),
                          onPrimary: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          minimumSize: Size(130, 40),
                        ),
                        child: Text('Logout'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ));
  }

  Future<List<dynamic>> fetchProfiles() async {
    final response = await http
        .get(Uri.parse('http://192.168.1.65:8000/api/apieviasi/profile'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load profiles');
    }
  }
}

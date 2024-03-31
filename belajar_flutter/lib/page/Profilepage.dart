import 'package:belajar_flutter/page/EditProfilePage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ProfilePage());
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('img/gambar ilham.png'),
              ),
              Positioned(
                bottom: 0,
                right: 4,
                child: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {},
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text('Nama'),
                subtitle: Text('ilham Pugruk'),
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              ListTile(
                title: Text('Email'),
                subtitle: Text('ArdiXgaming9.7@gmail.com'),
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              ListTile(
                title: Text('No. Telepon'),
                subtitle: Text('085855348099'),
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              ListTile(
                title: Text('Alamat'),
                subtitle: Text('Pugruk'),
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
                      Navigator.push
                      (context, 
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation ) =>
                   
                        EditProfilePage(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return FadeTransition(opacity: animation,
                          child: child,
                          );
                        } ,
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
                    onPressed: () {
                
                    },
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
    );
  }
}
